# This gets into the basic data structures of ggplot

library(ggplot2)

# plots need layers. Layers can be specified in the abstract like: layer(geom, geom_params, stat, stat_params, data, mapping, position)
p <- ggplot(diamonds, aes(carat, price, color=cut))
p <- p + layer(geom='point') # Note the similarity to qlot!
p

p <- ggplot(diamonds, aes(x=carat))
p <- p + layer(
    geom = 'bar',
    geom_params = list(fill = "steelblue"),
    stat = 'bin',
    stat_params = list(binwidth=2)
  )
p

# the above is more declarative for:
p <- ggplot(diamonds, aes(x=carat)) + geom_histogram(binwidth=2, fill="steelblue")
p

## Qplot equivalence:

ggplot(msleep, aes(sleep_rem/sleep_total, awake)) + geom_point()
# equivalent to:
qplot(sleep_rem/sleep_total, awake, data=msleep)

qplot(sleep_rem/sleep_total, awake, data=msleep) + geom_smooth()
# equivalent to:
qplot(sleep_rem/sleep_total, awake, data=msleep, geom=c('point', 'smooth'))
# equivalent to:
ggplot(msleep, aes(sleep_rem/sleep_total, awake)) + geom_point() + geom_smooth()

# Store layers of the plot in variables and reduce duplication!
bestfit <- geom_smooth(method='lm', se=F, color='steelblue', size=2)

qplot(sleep_rem, sleep_total, data=msleep) + bestfit
qplot(awake, brainwt, data=msleep, log="y") + bestfit
qplot(bodywt, brainwt, data=msleep, log="xy") + bestfit

# Swapping out data

p <- ggplot(mtcars, aes(mpg, wt, color=cyl)) + geom_point()
p
mtcars <- ggplot(transform(mtcars, mpg=mpg^2))
p %+% mtcars
