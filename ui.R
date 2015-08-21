library(shiny)

shinyUI(fluidPage(
  titlePanel("Cash Flow Calculator"),
  
  sidebarLayout(
    sidebarPanel( 
      helpText("Let's checkout this property! Put 0 if not sure."),
      numericInput('offer_price',
                   label = 'Offer Price',
                   value = 0),
      numericInput('capital_down',
                   label = 'Capital Down',
                   value = 0),
      numericInput('interest_rate',
                   label = 'Interest Rate',
                   value = 4.5),
      numericInput('mortgage_period',
                   label = 'Mortgage Period (years)',
                   value = 30),
      numericInput('rent',
                   label = 'Monthly Rent',
                   value = 0),
      numericInput('vacancy',
                   label = 'Vacancy Rate (%)',
                   value = 10),
      numericInput('insurance',
                   label = 'Insurance (year)',
                   value = 600),
      numericInput('utility',
                   label = 'Monthly Utility',
                   value = 100),
      numericInput('maintaince',
                   label = 'Maintaince (year)',
                   value = 1000),
      numericInput('listing_fee',
                   label = 'Listing Agent Fee (%)',
                   value = 0),
      numericInput('management_fee',
                   label = 'Management Fee (%)',
                   value = 8)
      ),
    mainPanel(h2("Report"),
              helpText('Input Data'),
              tableOutput("table1"),
              textOutput('text1'),
              textOutput('text2'),
              h3(textOutput("text3")),
              h3(textOutput("text4")),
              h3(textOutput("text5")),
              h3(textOutput("text6")))
  )
))

