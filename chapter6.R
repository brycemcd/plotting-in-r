# Scales, Axes and Legends

# Scales basically lay out the page. They're involved in calculating axes, legends 
# and plotting areas

# scales have a common naming scheme:
# scale_ +
# name of aesthetic (color|fill|x|y|shape|linetype|size)_
# name of scale (gradient|hue|manual)
# table on pg. 94 is very useful

# doesn't make a lot of sense to put this here, but re-labeling a legend:
p <- qplot(sleep_total, sleep_cycle, data=msleep, color=vore)
p
p + scale_color_hue("What does \nit eat?",
                    breaks = c('herbi', 'carni', 'omni', NA),
                    labels = c('plants', 'meat', 'both', 'no idea')
                    )
# another way to more expressively change the title of the legend

p <- qplot(cty, hwy, data=mpg, color=displ)
p
p + labs(x="City MPG", y="Highway MPG", color="Displacement")

# add limits to constrain the plotting area:
p + scale_x_continuous(limits=c(15, 20))
p + scale_y_continuous(limits=c(15,20))

# add breaks to change which values are displayed on this axes and legend
p + scale_x_continuous(breaks=c(15, 20))
p + scale_x_continuous(breaks=c(15, 16))

# use lables to change the actual text of what is displayed. Note that breaks must
# be displayed so ggplot can match the labels with the breaks
p + scale_x_continuous(breaks=c(15, 20), labels=c('big truck', 'Pius'))

# continuous scales can be mathmatically transformed:
# Note that scaling the axis rather than scaling the data first produces
# different axis labels

p + scale_x_log10()
p + scale_x_sqrt()

# scaling time series is special:
p <- qplot(as.Date(date), psavert, data=economics, geom='line')
library(scales)
p + scale_x_date(breaks='5 years', minor_breaks = '6 months', labels = date_format("%Y"))

# discrete data can be changes by using breaks, limits and/or xlim/ylim
p <- qplot(as.factor(cyl), hwy, data=mpg, geom='boxplot')
p + scale_x_discrete(breaks=c(4,5,6,8), labels=c('gutless', 'strange', 'getting there', 'beefy'))

# only show some cyl's
p + scale_x_discrete(limits=c(4,5,6),breaks=c(4,5,6), labels=c('foo', 'bar', 'baz'))
# re-arrange the boxes:
p + scale_x_discrete(limits=c(5,6,4),breaks=c(4,5,6), labels=c('foo', 'bar', 'baz'))
