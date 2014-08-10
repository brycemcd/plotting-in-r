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
