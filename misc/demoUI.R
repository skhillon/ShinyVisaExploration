pageWithSidebar(
   headerPanel('Iris Data'),
   sidebarPanel(
      selectInput('xcol', 'X Variable', names(iris)),
      selectInput('ycol', 'Y Variable', names(iris),
                  selected=names(iris)[[2]])
      #look at code in widget webpage
   ),
   mainPanel(
      plotOutput('plot1')
   )
)