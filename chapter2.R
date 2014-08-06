# Chapter 2 stuff:

# Alpha can help with overplotting
library(gridextra)
plot1 <- qplot(carat, price, data=diamonds, alpha=1/10)
plot2 <- qplot(carat, price, data=diamonds, alpha=I(1/10))

grid.arrange(plot1, plot2, ncol=2)


# Add smoothers to a basic qplot
plot2 + geom_smooth()
plot2 + geom_smooth(method="gam", formula=y~s(x))

# add plot + smoother in one shot:
qplot(carat, price, data=diamonds, alpha=I(1/10), geom=c('point', 'smooth'))

# adjust binwidths on histograms to reveal data
bins <- c(1, .5, .1, .05, .01) #NOTE learn how to foreach
p1 <- qplot(carat, data=diamonds, geom='histogram', xlim=c(0,3), binwidth=1)
p2 <- qplot(carat, data=diamonds, geom='histogram', xlim=c(0,3), binwidth=0.5)
p3 <- qplot(carat, data=diamonds, geom='histogram', xlim=c(0,3), binwidth=0.1)
p4 <- qplot(carat, data=diamonds, geom='histogram', xlim=c(0,3), binwidth=0.05)
p5 <- qplot(carat, data=diamonds, geom='histogram', xlim=c(0,3), binwidth=0.01)
grid.arrange(p1, p2, p3, p4, p5, ncol=1, nrow=5)

# a regular bar char can plot a histogram showing counts:
qplot(color, data=diamonds, geom='bar')
# but it can also show weighted summaries
qplot(color, data=diamonds, geom='bar', weight=carat)

#timeseries are straightforward:
qplot(date, uempmed, data=economics, geom='line')
qplot(date, uempmed, data=economics, geom='line') + theme_bw()

# plots can be combined. unemployment / population is shown plotted with 
# length of unemployment:
year <- function(x) as.POSIXlt(x)$year + 1900
qplot(unemploy/pop, uempmed, data=economics, geom=c('point', 'path'))
qplot(unemploy/pop, uempmed, data=economics, geom='path', 
      color=year(date)) + scale_size_area()

# faceting is useful:
qplot(carat, ..density.., data=diamonds, geom='histogram', binwidth=0.1, xlim=c(0,3), facets=color ~ .)

# facets + labelling (for reference)
qplot(carat, ..density.., data=diamonds, geom='histogram',
      binwidth=0.1, xlim=c(0,3), facets=color ~ .,
      main="Desity of diamonds by Carat and Color (Facet is Color)",
      ylab="Density of Distribution",
      xlab="Weight in Carats")

# data in plots can be transformed just prior to drawing on the graph object:
qplot(carat, price, data=diamonds, log="xy")
# equiv to this (but notice scales!)
qplot(log(carat), log(price), data=diamonds)
