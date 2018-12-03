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
                       em("Produced by Sarthak Khillon, Juan Moreno, and Christina Walden for STAT 331 with Professor Hunter Glanz.")
                   ),

                   mainPanel(
                       h2("Overview"),
                       p("The data set for this application comes from",
                         a(href = "https://www.kaggle.com/gpreda/h-1b-visa-applications", "Kaggle."),
                         "Originally, this data set had over 3 million observations.
                         However, for performance reasons, we use a subset of 10,000 observations."),
                       div(
                           p("Each tab performs a different visualization. Descriptions are as follows:",
                             tags$ul(
                                 tags$li(tags$b("Interactive Map:"),
                                         "Shows where applicants intended to go.",
                                         em("NOTE: If you apply too many filters, or filters that don't make sense (searching for Construction workers at Apple),
                                            then the map may be blank. Click \"Reset\" to clear your filters, or change them to something else.")),
                                 tags$li(tags$b("Acceptance Rates:"), "Displays a pie chart of case status. Gives a good idea of what the case status distrubution looks like."),
                                 tags$li(tags$b("Top Earners:"), "Displays a bar chart of earnings by case status.")
                             )
                           )
                       ),
                       br(),
                       h3("Personalized Results (optional)"),
                       p("Each tab also has the ability to show what", em("your"),
                         "results would be! Simply input your information in the form below,
                         and every tab will display your projected results next to the main visualization component."),
                       div(
                           id = "user_form",

                           selectizeInput("userEmployer", "Employer",
                                          choices = visas$EMPLOYER_NAME,
                                          options = list(
                                              placeholder = "Select from dropdown",
                                              maxItems = 1
                                          )),

                           selectizeInput("userSOC", "SOC Category",
                                          choices = visas$SOC_NAME,
                                          options = list(
                                              placeholder = "Select from dropdown",
                                              maxItems = 1
                                          )),

                           selectizeInput("userJobTitle", "Job Title",
                                          choices = visas$JOB_TITLE,
                                          options = list(
                                              placeholder = "Select from dropdown",
                                              maxItems = 1
                                          )),

                           checkboxInput("userFullTime", "Full Time?"),

                           sliderInput("userWage", "Annual Wage",
                                       min = MIN.WAGE, max = MAX.WAGE,
                                       value = MIN.WAGE)
                       )
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
