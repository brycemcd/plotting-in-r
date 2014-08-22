# Chapter 10 - reducing duplication

# last_plot() is a reference to the last plot
qplot(as.factor(cyl), cty, data=mpg, geom='boxplot')
last_plot() + ylim(0, 100)
last_plot() + theme_bw()

# trick for abstracting a function for the plotting points
geom_lm <- function(formula= y ~ x) {
  geom_smooth(formula=formula, se=FALSE, method="lm")
}

qplot(mpg, wt, data=mtcars) + geom_lm()
library(splines)
qplot(mpg, wt, data=mtcars) + geom_lm(y~ns(x, 3))
