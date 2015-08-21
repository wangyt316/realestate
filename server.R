library(shiny)

shinyServer(
  function(input, output) {
    cf <- reactive({
      data.frame(
        item = c('offer_price',
                 'capital_down',
                 'interest_rate',
                 'mortgage_period',
                 'rent',
                 'vacancy',
                 'insurance',
                 'utility',
                 'maintaince',
                 'agent',
                 'management'),
        value = c(input$offer_price,
                  input$capital_down,
                  input$interest_rate,
                  input$mortgage_period,
                  input$rent,
                  input$vacancy,
                  input$insurance,
                  input$utility,
                  input$maintaince,
                  input$listing_fee,
                  input$management_fee))
        })
    
    loan <- function(offer, capital){
      offer - capital
    }
    monthly_pay <- function(loan, period, interest){
      i = interest / 100 / 12
      n = period * 12
      round(loan * (i * (1 + i)^n) / ((1+i)^n -1),1)
    }
    
    profit <- function(offer, capital, interest, period, rent, vacancy, insurance, utility, maintaince, listing, management){
      loan <- offer - capital
      i = interest / 100 / 12
      n = period * 12
      mortgage <- round(loan * (i * (1 + i)^n) / ((1+i)^n -1),1)
      profit <- rent* (1-vacancy / 100 - listing / 100 - management / 100) - mortgage - insurance / 12 - utility - maintaince / 12 
      round(profit, 1)
    }
    
    cash_on_cash <- function(offer, capital, interest, period, rent, vacancy, insurance, utility, maintaince, listing, management){
      loan <- offer - capital
      i = interest / 100 / 12
      n = period * 12
      mortgage <- round(loan * (i * (1 + i)^n) / ((1+i)^n -1),1)
      profit <- rent* (1-vacancy / 100 - listing / 100 - management / 100) - mortgage - insurance / 12 - utility - maintaince / 12 
      round(profit * 12 * 100 / capital, 1)
    }
    
    output$table1 <- renderTable({ 
      cf()
    })
    
    output$text1 <- renderText({ 
      paste0('20% down: $',
           round(input$offer_price / 5, 1))
    })
    
    output$text2 <- renderText({ 
      paste0('25% down: $',
             round(input$offer_price / 4, 1))
    })
    
    output$text3 <- renderText({ 
      paste0("Loan Amount: $", loan(input$offer_price, input$capital_down))
    })
    
    output$text4 <- renderText({ 
      paste0("Monthly Mortgage Payment: $", monthly_pay(loan(input$offer_price, input$capital_down),
                                                        input$mortgage_period,
                                                        input$interest_rate))
    })
    
    output$text5 <- renderText({ 
      paste0("Monthly net profit: $", profit(input$offer_price,
                                             input$capital_down,
                                             input$interest_rate,
                                             input$mortgage_period,
                                             input$rent,
                                             input$vacancy,
                                             input$insurance,
                                             input$utility,
                                             input$maintaince,
                                             input$listing_fee,
                                             input$management_fee))
    })
    
    output$text6 <- renderText({ 
      paste0("Cash on cash return: ", cash_on_cash(input$offer_price,
                                                   input$capital_down,
                                                   input$interest_rate,
                                                   input$mortgage_period,
                                                   input$rent,
                                                   input$vacancy,
                                                   input$insurance,
                                                   input$utility,
                                                   input$maintaince,
                                                   input$listing_fee,
                                                   input$management_fee), '%')
    })
  }
)
