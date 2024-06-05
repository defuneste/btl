fenetre <- spatstat::owin(xrange=c(-1,11), yrange=c(0,2))
line <- spatstat::psp(0, 1, 10, 1,  window = fenetre) 
linedf    <- as.data.frame(line)
eps <- 3                                    # some spacing

leni <- spatstat::lengths_psp(line)         # length of the segment : 10 
nwhole <- floor(leni/eps)                   # how many whole segment can we fit : 3
if(leni/eps - nwhole < 0.5 && nwhole > 2)   # if we do 3 nwhole we have some "leftover"
    nwhole <- nwhole - 1                    # then I guess it is a design choice 
rump <- (leni - nwhole * eps)/2             # 
brks <- c(0, rump + (0:nwhole) * eps, leni) # making bricks: 0 2 5 8 10
nbrks <- length(brks)                       # how many bricks: 5
# points at middle of each piece
ss <- (brks[-1] + brks[-nbrks])/2
tp <- ss/leni                               # make it relative
x <- with(linedf, x0 + tp * (x1-x0))        # give them coords
y <- with(linedf, y0 + tp * (y1-y0))