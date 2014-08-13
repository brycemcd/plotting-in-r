# CH 5 working with annotations and error bars

(unemp <- qplot(date, unemploy, data=economics, geom="line", xlab="", ylab="No. unemployed in 1000s"))
presedential <- presidential[-(1:3), ]

yrng <- range(economics$unemploy)
xrng <- range(economics$date)

unemp + geom_vline(aes(xintercept=start), data=presedential)


d <- subset(diamonds, carat < 2 & rbinom(nrow(diamonds), 1, 0.2) == 1)
d$lcarat <- log10(d$carat)
d$lprice <- log10(d$price)

detrend <- lm(lprice ~ lcarat, data=d)
d$lprice2 <- resid(detrend)

mod <- lm(lprice2 ~ lcarat * color, data=d)

library(effects)

effectdf <- function(...){
  suppressWarnings(as.data.frame(effect(...)))
}

color <- effectdf("color", mod)
both1 <- effectdf('lcarat:color', mod)

carat <- effectdf('lcarat', mod, default.levels = 50)
both2 <- effectdf('lcarat:color', mod, default.levels=3)

# demonstrates using different summary functions with color mappings
midm <- function(x) mean(x, trim=0.5)
mp <- ggplot(aes(x=clarity), data=diamonds)
mp <- mp + stat_summary(aes(y=carat, color='carat-mean'), fun.y=mean, geom="point", size=5)
mp <- mp + stat_summary(aes(y=carat, color='carat-median'), fun.y=median, geom="point", size=5)
mp <- mp + stat_summary(aes(y=carat, color='carat-max'), fun.y=max, geom="point")
mp <- mp + stat_summary(aes(y=carat, color='carat-min'), fun.y=min, geom="point")
mp

# Weighting can be done if the data is already summarized:
qplot(percwhite, percbelowpoverty, data=midwest, weight=popdensity, size=popdensity) + 
  geom_smooth(mothod=lm, size=1)

# color gradients can be applied to continuous variables with two, three or n colors:

p <- qplot(cty, hwy, data=mpg, color=cty)
p + scale_x_continuous()
p + scale_color_gradient(low="green", high="red")
p + scale_color_gradient2(low="green", high="red", mid = "pink")
# NOTE: colours has to be spelled wrong here
p + scale_color_gradientn(colours=c('red', 'yellow', 'green', 'blue'))

# scaling discrete data is pretty similar:
p <- qplot(brainwt, bodywt, data=msleep, log="xy", color=vore)
p + scale_color_brewer(palette = 'Patel1')
p + scale_color_manual(values=c('red', 'yellow', 'green', 'blue'))

# things get really funky when assigning names to color mappings:
huron <- data.frame(year = 1875:1972, level=LakeHuron)
ggplot(huron, aes(year)) +
  geom_line(aes(y=level-5, color="below")) + # mapping!
  geom_line(aes(y=level+5, color="above")) + # mapping!
  scale_color_manual("Direction", values=c('below' = 'blue', 'above' = 'red'))
