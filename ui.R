shinyUI(fluidPage(

   # Application Title
   titlePanel("Explore Visa Statuses"),

   # Sidebar contains filters, which are the same regardless of visualization type.
   # Note that any radio elements will have `All` selected by default.
   # `All` will toggle every element; if at least one element is selected, All will make them all unselected.
   # If none are selected, then All will toggle every radio element to ON.
   tabsetPanel(
      type = "tabs",
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
                                 options = list(maxItems = 1)),
                  br(),
                  
                  # Similarly, there are also many values for SOC_NAME. This will also be a text field.
                  selectizeInput("SOC_NAME_MAP", "SOC Name",
                                 choices = visas$SOC_NAME,
                                 options = list(maxItems = 1)),
                  br(),
                  
                  # Another text field for JOB_TITLE
                  selectizeInput("JOB_TITLE_MAP", "Job Title",
                                 choices = visas$JOB_TITLE,
                                 options = list(maxItems = 1)),
                  br(),
                  
                  # Full Time Position is either a yes or a no, so this is a 2-button radio section.
                  radioButtons("FULL_TIME_POSITION_MAP", "Job Type",
                               c("All", "Full Time", "Part Time")),
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
         "Top Earners", 
         sidebarLayout(        
            sidebarPanel(
               # CASE_STATUS only has the following 4 values:
               #- Certified-Withdrawn
               #- Certified
               #- Withdrawn
               #- Denied
               # As such, this will be a checkbox element.
               checkboxGroupInput(
                  "CASE_STATUS_PIE", "Case Status",     
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
                  
                  # Full Time Position is either a yes or a no, so this is a 2-button radio section.
                  radioButtons("FULL_TIME_POSITION_PIE", "Job Type",
                               c("All", "Full Time", "Part Time")),
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
                     plotOutput("wageVis")
                  )
               )
         ),
      tabPanel("Acceptance Rates", 
               sidebarLayout(        
                  sidebarPanel(
                  # CASE_STATUS only has the following 4 values:
                  #- Certified-Withdrawn
                  #- Certified
                  #- Withdrawn
                  #- Denied
                  # As such, this will be a checkbox element.
                     checkboxGroupInput(
                        "CASE_STATUS", "Case Status",     
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
                  selectizeInput("EMPLOYER_NAME", "Employer Name",
                                 choices = visas$EMPLOYER_NAME,
                                 options = list(maxItems = 1)),
                  br(),
                  
                  # Similarly, there are also many values for SOC_NAME. This will also be a text field.
                  selectizeInput("SOC_NAME", "SOC Name",
                                 choices = visas$SOC_NAME,
                                 options = list(maxItems = 1)),
                  br(),
                  
                  # Another text field for JOB_TITLE
                  selectizeInput("JOB_TITLE", "Job Title",
                                 choices = visas$JOB_TITLE,
                                 options = list(maxItems = 1)),
                  br(),
                  
                  # Full Time Position is either a yes or a no, so this is a 2-button radio section.
                  radioButtons("FULL_TIME_POSITION", "Job Type",
                               c("All", "Full Time", "Part Time")),
                  br(),
                  
                  # PREVAILING_WAGE will be an inclusive slider.
                  sliderInput("PREVAILING_WAGE", "Wage Range", min = MIN.WAGE,
                              max = MAX.WAGE, value = c(MIN.WAGE, MAX.WAGE)),
                  br(),
                  
                  # There are very few years that are unique in the dataset, so this will be an inclusive slider.
                  sliderInput("YEAR", "Year Range", min = MIN.YEAR,
                              max = MAX.YEAR, value = c(MIN.YEAR, MAX.YEAR), step = 1,
                              ticks = T, sep = "")
               ),
                  mainPanel(plotOutput("acceptVis"))
                  )
               )
      )
   )
)
#        sidebarLayout(
#         sidebarPanel(
#             # CASE_STATUS only has the following 4 values:
#             #- Certified-Withdrawn
#             #- Certified
#             #- Withdrawn
#             #- Denied
#             # As such, this will be a radio element.
#             radioButtons("CASE_STATUS", "Case Status",
#                          c("All", "Certified-Withdrawn", "Certified", "Withdrawn", "Denied")),
#             br(),
# 
#             # There are many values for EMPLOYER_NAME, so this will be an autocomplete text field.
#             selectizeInput("EMPLOYER_NAME", "Employer Name",
#                            choices = visas$EMPLOYER_NAME,
#                            options = list(maxItems = 1)),
#             br(),
# 
#             # Similarly, there are also many values for SOC_NAME. This will also be a text field.
#             selectizeInput("SOC_NAME", "SOC Name",
#                            choices = visas$SOC_NAME,
#                            options = list(maxItems = 1)),
#             br(),
# 
#             # Another text field for JOB_TITLE
#             selectizeInput("JOB_TITLE", "Job Title",
#                            choices = visas$JOB_TITLE,
#                            options = list(maxItems = 1)),
#             br(),
# 
#             # Full Time Position is either a yes or a no, so this is a 2-button radio section.
#             radioButtons("FULL_TIME_POSITION", "Job Type",
#                          c("All", "Full Time", "Part Time")),
#             br(),
# 
#             # PREVAILING_WAGE will be an inclusive slider.
#             sliderInput("PREVAILING_WAGE", "Wage Range", min = MIN.WAGE,
#                         max = MAX.WAGE, value = c(MIN.WAGE, MAX.WAGE)),
#             br(),
# 
#             # There are very few years that are unique in the dataset, so this will be an inclusive slider.
#             sliderInput("YEAR", "Year Range", min = MIN.YEAR,
#                         max = MAX.YEAR, value = c(MIN.YEAR, MAX.YEAR), step = 1,
#                         ticks = T, sep = "")
#         ),
# 
#         mainPanel(
#             tabsetPanel(type = "tabs",
#                         tabPanel("Interactive Map", leafletOutput("geographicVis")),
#                         tabPanel("Top Earners", plotOutput("wageVis")),
#                         tabPanel("Acceptance Rates", plotOutput("acceptVis")))
#         )
#     )
# ))
