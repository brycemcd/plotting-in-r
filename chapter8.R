# Themes

# use previous_theme to restore, or get attributes for, the previous theme.
theme_set(previous_theme)

# take a photocopy of pg 143 - theme params
hgram <- qplot(rating, data=movies, binwidth=1)
hgram
previous_theme <- theme_set(theme_bw())
hgram
hgram + previous_theme
theme_set(previous_theme)

# really messing around with params:

base <- hgram + labs(title="hello world!") + theme(plot.title=element_text(color="blue"))

base + theme(axis.line = element_line(size = 3, colour = "red", linetype = "dotted"))
base + theme(panel.grid.minor = element_line(colour = "red", linetype = "dotted"))
base + theme(panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
             panel.grid.major = element_line(color='blue', linetype='dashed'),
             panel.grid.major.y = element_blank(),
             plot.background = element_rect(fill = "green"))

# http://docs.ggplot2.org/0.9.2.1/theme.html for docs

common_theme_options <- theme(panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
             panel.grid.major = element_line(color='blue', linetype='dashed'),
             panel.grid.major.y = element_blank(),
             plot.background = element_rect(fill = "green"))

default <- qplot(x=cty, data=mpg, geom='histogram')
default + common_theme_options


common_theme_options <- theme(
  #panel.grid = element_blank(),
#              panel.grid.major = element_line(color='blue', linetype='dashed'),
             panel.grid.major.y = element_line(color="lightgrey", linetype='dotted'),
             panel.grid.minor.y = element_line(color="darkgrey", linetype='dotted'),
             axis.text.x = element_text(position='top'),
             axis.ticks  = element_blank(),
             plot.background = element_rect(fill = "white"),
             panel.background = element_rect(fill = "white")
)

default <- qplot(x=as.factor(cyl), y=cty, data=mpg, geom='boxplot')
default
default + common_theme_options
