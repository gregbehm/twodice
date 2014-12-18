library("shiny")

# Define UI for application that plots a probability distribution
shinyUI(fluidPage(
     
     # Application title
     titlePanel("Sum of two dice simulation"),
     
     sidebarLayout(position = "right",
          # Sidebar with a slider input for the number of rolls
          sidebarPanel(
               # Simple slider
               sliderInput("n", "Move slider to select number of rolls:",
                           min = 10, max = 1000, value = 100, step = 1),
               br(),
               img(src = "dice.png", height = 209, width = 113)
          ),
          
          # Show a plot of the generated distribution
          mainPanel(
               p("The common gaming die (plural dice) is a small cube marked on each face with a different number of spots, ranging from one to six, shaken and thrown in gambling and other games of chance."),
               p("The sums of two dice thrown together range from 2 to 12, with these respective probabilities: 1/36, 2/36, 3/36, 4/36, 5/36, 6/36, 5/36, 4/36, 3/36, 2/36, and 1/36."),
               h4("Instructions"),
               p("The plot below simulates a probability distribution of the sum of two dice for a selected number of rolls. Use the slider to select the number of rolls between 10 and 1000."),
               p(""),
               plotOutput("myPlot")
          )
     ) ### sidebarLayout
) ## fluidPage
) # shinyUI