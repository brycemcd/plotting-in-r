# Faceting

# Two basic arguments exist: 1) variable to facet by and 2) positions scales
# should be global or local to the facet

std_plot <-  qplot(cty, hwy, data=mpg)

# facet with rows:
qplot(cty, hwy, data=mpg) + facet_grid(. ~ cyl)

# facet with columns
qplot(cty, hwy, data=mpg) + facet_grid(cyl ~ .)

# facet with both!
qplot(cty, hwy, data=mpg) + facet_grid(drv ~ cyl)

# show rollups:
qplot(cty, hwy, data=mpg) + facet_grid(drv ~ cyl, margins=T)
qplot(cty, hwy, data=mpg) + facet_grid(drv ~ cyl, margins=c('drv'))
qplot(cty, hwy, data=mpg) + facet_grid(drv ~ cyl, margins=c('cyl'))

# facet_wrap with specifics:
qplot(cty, hwy, data=mpg) + facet_wrap(drv ~ cyl, ncol=6)
qplot(cty, hwy, data=mpg) + facet_wrap(drv ~ cyl, nrow=5)

# scales can be fixed or free
std_plot + facet_wrap(drv ~ cyl, scales="fixed") # standard, default
std_plot + facet_wrap(drv ~ cyl, scales="free")
std_plot + facet_wrap(drv ~ cyl, scales="free_x")
std_plot + facet_wrap(drv ~ cyl, scales="free_y")

qplot(cty, model, data=mpg) + facet_grid(manufacturer ~ ., scales="free", space='free') +
  theme(strip.text.y = element_text(angle=0, color="white"),
        strip.background = element_rect(colour="grey", fill="black"))

base <- ggplot(mpg, aes(fill=model)) +
  geom_bar(position='dodge') +
  theme(legend.position='none')
base + aes(x=model) + facet_grid(. ~ manufacturer, scales='free_x', space="free")

# To bin continuous data, using cut_interval or cut_number is useful.
# cut_interval produces consistent intervals. n bins each of the same length
# cut_number produces consistent #'s of points in each bin

mpg2 <- subset(mpg, !is.na(displ) && !is.na(cty) && !is.na(hwy))
mpg2$disp_ww <- cut_interval(mpg2$displ, length = 1)
mpg2$disp_wn <- cut_interval(mpg2$displ, n=6)
mpg2$disp_nn <- cut_interval(mpg2$displ, n=6)

base <- qplot(cty, hwy, data=mpg2) + labs(x=NULL, y=NULL)
base + facet_wrap( ~ disp_ww, nrow=1)
base + facet_wrap( ~ disp_wn, nrow=1)
base + facet_wrap( ~ disp_nn, nrow=1)
