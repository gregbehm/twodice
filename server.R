library("shiny")
library("dplyr")
library("ggplot2")

maxTick <- function(x) {
     x <- max(x)
     r <- plyr::round_any(x, 0.05)
     rc <- ifelse(r < x, r + 0.05, r)
     ifelse(rc < 0.2, 0.2, rc)
}

theme_basic <- function() {
     fill.colour <- "white"
     theme_classic() +
          theme(plot.background    = element_rect(fill = fill.colour)) +
          theme(panel.background   = element_rect(fill = fill.colour)) +
          theme(panel.grid.major   = element_line(colour = "grey95")) +
          theme(panel.grid.major.x = element_blank()) +
          theme(axis.line          = element_blank()) +
          theme(axis.ticks.x       = element_blank()) +
          theme(axis.ticks.y       = element_line(colour = "grey95")) +
          theme(text               = element_text(colour = "grey20"))
}

# Define server logic for two-dice app
shinyServer(function(input, output) {
     
     output$myPlot <- renderPlot({
          
          # n = number of dice rolls from sliderInput widget
          n <- input$n
          # create a vector to count results for histogram data
          sums <- integer(12)
          for (i in 1:n) {
               # "roll" two numbers between 1 and 6; add together
               outcome <- trunc(runif(1, min = 1, max = 7)) +
                          trunc(runif(1, min = 1, max = 7))
               # count result
               sums[outcome] <- sums[outcome] + 1
          }
          # prepare a data frame for graphing
          dice <- data.frame(sum = 2:12, count = sums[2:12]) %>%
               mutate(p = (count / sum(count)), theoretical = (c(1:6, 5:1) / 36))          
          
          max.y.tick <- maxTick(dice$p)
          max.x.tick <- max(dice$sum) + 1
          title <- paste("Sum-of-two-dice Probability Distribution,", n,
                         "rolls\n(simulated vs. theoretical)\n")
          ggplot(dice) + theme_basic() +
               geom_bar(aes(x = sum, y = p),
                        stat = "identity", position = "dodge",
                        fill = "#e99949") +
               scale_x_continuous(limits = c(1, max.x.tick),
                                 breaks = seq(2, 12, by = 1.0)) +
               scale_y_continuous(limits = c(0, max.y.tick),
                                  breaks = seq(0, max.y.tick, by = 0.05)) +
               geom_point(aes(x = sum, y = theoretical),
                          colour = "grey33") +
               annotate("point",
                        x = 12,
                        y = max.y.tick - 0.030,
                        colour = "grey33") +
               annotate("text",
                        x = 12.1,
                        y = max.y.tick - 0.015,
                        label = "theoretical") +
               labs(x = "\nTwo-dice sum") +
               labs(y = "Proportion  ") +
               theme(axis.title.y = element_text(angle = 0, vjust = 0.975)) +
               ggtitle(title)   
     })
})
