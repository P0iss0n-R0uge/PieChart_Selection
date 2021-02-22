library(jsonlite)
library(tidyverse)
library(highcharter)

function(input, output, session) {
    set.seed(228)
   
    RegistrationGender <- c('M', 'F')
    RegistrationAge <- c('0~10', '11~20', '21~30', '31~40', '41~50', '51~60', '61~70', '70+')
    RegistrationSource <- c('facebook', 'google', 'yahoo', 'line', 'null')
    RegistrationYear <- as.character(2017:2021)
    
    data <- list(
        'RegistrationGender' = sample(RegistrationGender, size=100, replace=TRUE)
        ,'RegistrationAge' = sample(RegistrationAge, size=100, replace=TRUE)
        ,'RegistrationSource' = sample(RegistrationSource, size=100, replace=TRUE)
        ,'RegistrationYear' = sample(RegistrationYear, size=100, replace=TRUE)
    )
    
    df_data <- as.data.frame(data)

    rv <- reactiveValues()
    
    AllColumns <- ColumnNames(df_data)

    output$PieCharts <- renderUI({
        Output <- tagList()
        
        Output <- lapply(1:length(AllColumns), function(i) {
            
            ColumnName <- AllColumns[i]
            
            ChartData <- df_data %>% select(ColumnName) %>% group_by_all() %>% summarise(y = n()) # group by value of selected column, name it as y   
            
            ColumnNames(ChartData)[ColumnNames(ChartData) == ColumnName] <- 'x' # rename selected column as x
            
            # bind r shiny reactive value with chart click/select/unselect using highchart callbacks
            # add timestamps to each value to make sure it is observable for every click
            
            click_js <- JS(paste0("function(event) {let now = new Date(); console.log(now); console.log(event.point.name); Shiny.onInputChange('",ColumnName,"_PieClick',event.point.name + ' Timestamp ' + now + now.getMilliseconds());}"))
            #select_js <- JS(paste0("function(event) {let now = new Date(); console.log(now); console.log(this.name); Shiny.onInputChange('",ColumnName,"_PieSelect',this.name + ' Timestamp ' + now + now.getMilliseconds());}"))
            #unselect_js <- JS(paste0("function(event) {let now = new Date(); console.log(now); console.log(this.name); Shiny.onInputChange('",ColumnName,"_PieUnselect',this.name + ' Timestamp ' + now + now.getMilliseconds());}"))
            
            hc <- ChartData %>%
                hchart(
                    "pie", hcaes(x = x, y = y)
                ) %>% hc_plotOptions(
                    series = list( 
                        allowPointSelect = TRUE, # enable selection for pie chart
                        point = list(
                            events = list(
                                #select = select_js,
                                #unselect = unselect_js,
                                click = click_js
                            )
                        )
                    ,states = list(
                        select =  list( # set selection style
                            color= NULL,
                            borderWidth = 5,
                            borderColor = '#000'
                        ))
                    ),
                    pie = list( size = 100 ) # set graph size
                ) #%>% hc_add_event_point(event = "unselect")
            
            box(
                title = paste0('Pie Chart of ', ColumnName),
                status = "primary",
                #height = 400,
                solidHeader = T,
                hc %>% hc_size(height = 200), # set container height
                renderPrint({ rv[[paste0(ColumnName, '_CurrentSelection')]] })
            )
        })
    })

    
    lapply(1:length(AllColumns), function(i) {
        
        ColumnName <- AllColumns[i]
        
        rv[[paste0(ColumnName, '_CurrentSelection')]] <- NULL # indicates current selection
        rv[[paste0(ColumnName, '_PreviousSelection')]] <- NULL # indicates previous selection
        
        toListen <- reactive({
            list(
                input[[paste0(ColumnName,"_PieClick")]] 
                #,input[[paste0(ColumnName,"_PieSelect")]]
                #,input[[paste0(ColumnName,"_PieUnselect")]]
                #,rv[[paste0(ColumnName, '_PreviousSelection')]]
                #,rv[[paste0(ColumnName,"_CurrentSelection")]]
            )
        })
        
        observeEvent( 
            toListen() ,{
                rv[[paste0(ColumnName, '_PreviousSelection')]] <- rv[[paste0(ColumnName, '_CurrentSelection')]] # once triggered, store current selection in previous selection
                
                # timestamp will always be stripped from input[[paste0(ColumnName,"_PieClick")]] before assigning to other variables
                
                if( is.null(input[[paste0(ColumnName,"_PieClick")]])) { 
                    rv[[paste0(ColumnName, '_CurrentSelection')]] <- NULL # else if nothing has been clicked yet, set current selection to null 
                }
                else if ( is.null(rv[[paste0(ColumnName, '_PreviousSelection')]]) ) {
                    rv[[paste0(ColumnName, '_CurrentSelection')]] <- strsplit(input[[paste0(ColumnName,"_PieClick")]], " Timestamp ")[[1]][1] # else if previous selection is null, set current selection as clicked value because nothing was previously selected
                }
                else if( strsplit(input[[paste0(ColumnName,"_PieClick")]], " Timestamp ")[[1]][1] == rv[[paste0(ColumnName, '_PreviousSelection')]] ) { 
                    rv[[paste0(ColumnName, '_CurrentSelection')]] <- NULL # else if clicked value matches previous selection, set current result to null because previous selection should be unselected
                }
                else { 
                    rv[[paste0(ColumnName, '_CurrentSelection')]] <- strsplit(input[[paste0(ColumnName,"_PieClick")]], " Timestamp ")[[1]][1] # else set current selection as clicked value because a new value is clicked (previous selection does not match click value)
                }
            })
    })
}
