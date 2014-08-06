# we can view the data structures of a plot by calling summary on the plot object:
library(ggplot2)
p <- qplot(displ, hwy, data=mpg, color=factor(cyl)) + geom_smooth()
p # actually plots
summary(p)