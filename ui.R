library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("paper"),

   # Application Title
   titlePanel("H1-B Visa Petitions, 2011-2016"),

   # Sidebar contains filters, which are the same regardless of visualization type.
   # Note that any radio elements will have `All` selected by default.
   # `All` will toggle every element; if at least one element is selected, All will make them all unselected.
   # If none are selected, then All will toggle every radio element to ON.
   tabsetPanel(
      type = "tabs",

      # Overview Panel
      tabPanel("Overview",
               sidebarLayout(
                   sidebarPanel(
                       h3("Welcome!"),
                       p("This application lets you explore H1-B Visa Petitions from 2011-2016.
                      Click on any of the tabs to filter and visualize the data."),
                       br(),
                       p("The last tab lets you enter your information and then
                      produces the likelihood that your visa application would be accepted."),
                       br(),
                       em("Produced by Sarthak Khillon, Juan Moreno, and Christina Walden for STAT 331 with Professor Hunter Glanz.")
                   ),

                   mainPanel(
                       h2("How to Use")
                   )
               )),

      # Leaflet Map
      tabPanel("Interactive Map",
               sidebarLayout(
                  sidebarPanel(
                  # CASE_STATUS only has the following 4 values:
                  #- Certified-Withdrawn
                  #- Certified
                  #- Withdrawn
                  #- Denied
                  # As such, this will be a radio element.
                  checkboxGroupInput(
                     "CASE_STATUS_MAP", "Case Status",
                     choices = list(
                        "Certified-Withdrawn" = "CERTIFIED-WITHDRAWN",
                        "Certified" = "CERTIFIED",
                        "Withdrawn" = "WITHDRAWN",
                        "Denied" = "DENIED"
                     ),
                     selected = c("CERTIFIED-WITHDRAWN", "CERTIFIED", "WITHDRAWN", "DENIED")
                  ),
                  hr(),

                  # There are many values for EMPLOYER_NAME, so this will be an autocomplete text field.
                  selectizeInput("EMPLOYER_NAME_MAP", "Employer Name",
                                 choices = visas$EMPLOYER_NAME,
                                 options = list(
                                     placeholder = "Try \"APPLE INC.\"",
                                     maxItems = 1),
                                 selected = "APPLE INC."),
                  br(),

                  # Similarly, there are also many values for SOC_NAME. This will also be a text field.
                  selectizeInput("SOC_NAME_MAP", "SOC Name",
                                 choices = visas$SOC_NAME,
                                 options = list(
                                     placeholder = "Try \"Software Developers, Applications\"",
                                     maxItems = 1),
                                 selected = "Software Developers, Applications"),
                  br(),

                  # Another text field for JOB_TITLE
                  selectizeInput("JOB_TITLE_MAP", "Job Title",
                                 choices = visas$JOB_TITLE,
                                 options = list(
                                     placeholder = "Try \"SOFTWARE ENGINEER\"",
                                     maxItems = 1),
                                 selected = "SOFTWARE ENGINEER"),
                  br(),

                  # Full Time Position is either a yes or a no, so this is a 3-button radio section.
                  radioButtons("FULL_TIME_POSITION_MAP", "Job Type",
                               choices = list("All" = "", "Full Time" = "Y", "Part Time" = "N")),
                  br(),

                  # PREVAILING_WAGE will be an inclusive slider.
                  sliderInput("PREVAILING_WAGE_MAP", "Wage Range", min = MIN.WAGE,
                              max = MAX.WAGE, value = c(MIN.WAGE, MAX.WAGE)),
                  br(),

                  # There are very few years that are unique in the dataset, so this will be an inclusive slider.
                  sliderInput("YEAR_MAP", "Year Range", min = MIN.YEAR,
                              max = MAX.YEAR, value = c(MIN.YEAR, MAX.YEAR), step = 1,
                              ticks = T, sep = "")
               ),
                  mainPanel(leafletOutput("geographicVis"))
                  )
               ),

      #Pie chart
      tabPanel(
         "Acceptance Rates",
         sidebarLayout(
            sidebarPanel(
                  # There are many values for EMPLOYER_NAME, so this will be an autocomplete text field.
                  selectizeInput("EMPLOYER_NAME_PIE", "Employer Name",
                                 choices = visas$EMPLOYER_NAME,
                                 options = list(maxItems = 1)),
                  br(),

                  # Similarly, there are also many values for SOC_NAME. This will also be a text field.
                  selectizeInput("SOC_NAME_PIE", "SOC Name",
                                 choices = visas$SOC_NAME,
                                 options = list(maxItems = 1)),
                  br(),

                  # Another text field for JOB_TITLE
                  selectizeInput("JOB_TITLE_PIE", "Job Title",
                                 choices = visas$JOB_TITLE,
                                 options = list(maxItems = 1)),
                  br(),

                  # Full Time Position is either a yes or a no, so this is a 3-button radio section.
                  radioButtons("FULL_TIME_POSITION_PIE", "Job Type",
                               choices = list("All" = "", "Full Time" = "Y", "Part Time" = "N")),
                  br(),

                  # PREVAILING_WAGE will be an inclusive slider.
                  sliderInput("PREVAILING_WAGE_PIE", "Wage Range", min = MIN.WAGE,
                              max = MAX.WAGE, value = c(MIN.WAGE, MAX.WAGE)),
                  br(),

                  # There are very few years that are unique in the dataset, so this will be an inclusive slider.
                  sliderInput("YEAR_PIE", "Year Range", min = MIN.YEAR,
                              max = MAX.YEAR, value = c(MIN.YEAR, MAX.YEAR), step = 1,
                              ticks = T, sep = "")
               ),
                  mainPanel(
                     plotOutput("acceptVis")
                  )
               )
         ),
      tabPanel("Top Earners",
               sidebarLayout(
                  sidebarPanel(
                  # There are many values for EMPLOYER_NAME, so this will be an autocomplete text field.
                  selectizeInput("EMPLOYER_NAME_3", "Employer Name",
                                 choices = visas$EMPLOYER_NAME,
                                 options = list(maxItems = 1)),
                  br(),

                  # Similarly, there are also many values for SOC_NAME. This will also be a text field.
                  selectizeInput("SOC_NAME_3", "SOC Name",
                                 choices = visas$SOC_NAME,
                                 options = list(maxItems = 1)),
                  br(),

                  # Another text field for JOB_TITLE
                  selectizeInput("JOB_TITLE_3", "Job Title",
                                 choices = visas$JOB_TITLE,
                                 options = list(maxItems = 1)),
                  br(),

                  # Full Time Position is either a yes or a no, so this is a 2-button radio section.
                  radioButtons("FULL_TIME_POSITION_3", "Job Type",
                               choices = list("All" = "", "Full Time" = "Y", "Part Time" = "N")),
                  br(),

                  # PREVAILING_WAGE will be an inclusive slider.
                  sliderInput("PREVAILING_WAGE_3", "Wage Range", min = MIN.WAGE,
                              max = MAX.WAGE, value = c(MIN.WAGE, MAX.WAGE)),
                  br(),

                  # There are very few years that are unique in the dataset, so this will be an inclusive slider.
                  sliderInput("YEAR_3", "Year Range", min = MIN.YEAR,
                              max = MAX.YEAR, value = c(MIN.YEAR, MAX.YEAR), step = 1,
                              ticks = T, sep = "")
               ),
                  mainPanel(plotOutput("wageVis"))
                  )
               )
      )
   )
)
