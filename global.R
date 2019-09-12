library(shiny)
library(caret)
library(dplyr)
library(ggplot2)
library(plotly)
library(RColorBrewer)
library(PRROC)
library(pROC)    

source("plotlyGraphWidget.R")

ds <- read.csv('nba_rookies_data.csv', stringsAsFactors = F)
ds %>% select(-Name, -Year_drafted, -Yrs) %>% unique() -> ds

feature.list <- list("GP" = "GP",  "MIN" = "MIN", "PTS" = "PTS", 
                     "FG_made" = "FG_made",  "FGA" = "FGA", "FG_percent" = "FG_percent", 
                     "TP_made" = "TP_made", "TPA"  = "TPA", "TP_percent" = "TP_percent", 
                     "FT_made" = "FT_made", "FTA" = "FTA","FT_percent"="FT_percent", 
                     "OREB" = "OREB", "DREB" ="DREB", "REB"="REB", "AST"="AST",
                     "STL"="STL", "BLK"="BLK", 
                     "TOV"="TOV")

original.ds <- ds

ds$Target <- factor(ds$Target)

# create training and test sets
set.seed(123)
training.index <- createDataPartition(ds$Target, p = .8,list = F)
train <- ds[training.index,]
test  <- ds[-training.index,]

#model


#theme for ggplot and tables
table.settings <- list(searching = F, pageLength = 5, bLengthChange = F,
                       bPaginate = F, bInfo = F )

# define theme for ggplots ####
fte_theme <- function() {
  
  # Generate the colors for the chart procedurally with RColorBrewer
  palette <- brewer.pal("Greys", n=9)
  color.background = palette[2]
  color.grid.major = palette[3]
  color.axis.text = palette[9]
  color.axis.title = palette[9]
  color.title = palette[9]
  text.size <- 14
  
  # Begin construction of chart
  theme_bw(base_size=9) +
    
    # Set the entire chart region to a light gray color
    theme(panel.background=element_rect(fill=color.background, color=color.background)) +
    theme(plot.background=element_rect(fill=color.background, color=color.background)) +
    theme(panel.border=element_rect(color=color.background)) +
    
    # Format the grid
    theme(panel.grid.major=element_line(color=color.grid.major,size=.25)) +
    theme(panel.grid.minor=element_blank()) +
    theme(axis.ticks=element_blank()) +
    
    # Format the legend, but hide by default
    theme(legend.background = element_rect(fill=color.background)) +
    theme(legend.text = element_text(size=text.size,color=color.axis.title)) +
    theme(legend.title = element_text(size=text.size,color=color.axis.title)) +
    theme(legend.position = "bottom") +
    theme(legend.direction = "vertical") +
    # Set title and axis labels, and format these and tick marks
    theme(plot.title=element_text(color=color.title, size=text.size, vjust=1.25)) +
    theme(axis.text.x=element_text(size=text.size,color=color.axis.text)) +
    theme(axis.text.y=element_text(size=text.size,color=color.axis.text)) +
    theme(axis.title.x=element_text(size=text.size,color=color.axis.title, vjust=0)) +
    theme(axis.title.y=element_text(size=text.size,color=color.axis.title, vjust=1.25)) +
    
    # Plot margins
    theme(plot.margin = unit(c(0.35, 0.2, 0.3, 0.35), "cm"))
}

