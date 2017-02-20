library(shiny)
library(leaflet)
library(ggmap)
crimes_vector <- c("AGGRAVATED ASSAULT" = "AGGRAVATED ASSAULT", "ARSON" = "ARSON", "BURGLARY" = "BURGLARY", "CRIMINAL HOMICIDE" = "CRIMINAL HOMICIDE", 
                  "DISORDERLY CONDUCT" = "DISORDERLY CONDUCT", "DRUNK / ALCOHOL / DRUGS" = "DRUNK / ALCOHOL / DRUGS", 
                  "DRUNK DRIVING VEHICLE / BOAT" = "DRUNK DRIVING VEHICLE / BOAT", "FEDERAL OFFENSES W/O MONEY" = "FEDERAL OFFENSES W/O MONEY", 
                  "FEDERAL OFFENSES WITH MONEY" = "FEDERAL OFFENSES WITH MONEY", "FELONIES MISCELLANEOUS" = "FELONIES MISCELLANEOUS", "FORCIBLE RAPE" = "FORCIBLE RAPE", 
                  "FORGERY" = "FORGERY", "FRAUD AND NSF CHECKS" = "FRAUD AND NSF CHECKS", "GAMBLING" = "GAMBLING", "GRAND THEFT AUTO" = "GRAND THEFT AUTO",
                  "LARCENY THEFT" = "LARCENY THEFT", "LIQUOR LAWS" = "LIQUOR LAWS", "MISDEMEANORS MISCELLANEOUS" = "MISDEMEANORS MISCELLANEOUS", "NARCOTICS" = "NARCOTICS",
                  "NON-AGGRAVATED ASSAULTS" = "NON-AGGRAVATED ASSAULTS", "OFFENSES AGAINST FAMILY" = "OFFENSES AGAINST FAMILY", "RECEIVING STOLEN PROPERTY" = "RECEIVING STOLEN PROPERTY",
                  "ROBBERY" = "ROBBERY", "SEX OFFENSES FELONIES" = "SEX OFFENSES FELONIES", "VANDALISM" = "VANDALISM", "VEHICLE / BOATING LAWS" = "VEHICLE / BOATING LAWS", 
                  "WARRANTS" = "WARRANTS", "WEAPON LAWS" = "WEAPON LAWS")
crimes_checked <- c("AGGRAVATED ASSAULT", "BURGLARY", "CRIMINAL HOMICIDE", "DISORDERLY CONDUCT", "DRUNK / ALCOHOL / DRUGS", "FELONIES MISCELLANEOUS", "FORCIBLE RAPE", "GRAND THEFT AUTO",
                    "LARCENY THEFT", "MISDEMEANORS MISCELLANEOUS", "NARCOTICS", "NON-AGGRAVATED ASSAULTS", "RECEIVING STOLEN PROPERTY", "ROBBERY", "SEX OFFENSES FELONIES",
                    "VANDALISM", "WARRANTS", "WEAPON LAWS")
days_vector <- c("Sunday" = "Sunday", "Monday" = "Monday", "Tuesday" = "Tuesday", "Wednesday" = "Wednesday", "Thursday" = "Thursday", "Friday" = "Friday", "Saturday" = "Saturday")
days_checked <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday") 
periods_vector <- c("MIDNIGHT - 6:00 A.M." = "early_morning", "6:00 A.M. - NOON" = "morning", 
                    "NOON - 6:00 P.M." = "afternoon", "6:00 P.M. - MIDNIGHT" = "evening")
periods_checked <- c("early_morning", "morning", "afternoon", "evening")
plots_facets_vector <- c("day of week" , "time of day" , "crime category" )
years_vector <- c("2015", "2014", "2013", "2012", "2011", "2010", "2009", "2008", "2007", "2006", "2005", "2004")
locations_vector <- c("Pershing Square, Los Angeles, CA", "Los Angeles Union Station", "Pico Rivera, CA", 
                     "Angelus Rosedale Cemetery, Los Angeles, CA", "Vernon, CA", "Compton, CA", "Lynwood, CA",
                     "USC, Los Angeles, CA", "UCLA, Los Angeles, CA", "Rosemead, CA", "San Gabriel, CA",
                     "Pasadena, CA", "Norwalk, CA", "El Monte, CA", "West Covina, CA", "Beverly Hills, CA",
                     "West Hollywood, CA", "Hollywood, CA", "California State University Dominguez Hills", "Carson, CA",
                     "Lawndale, CA", "La Mirada, CA", "Cerritos, CA", "Artesia, CA", "Bellflower, CA", "South Los Angeles, Los Angeles, CA",
                     "Dodger Stadium, Los Angeles")

shinyUI(fluidPage(
  titlePanel(h3("Los Angeles Crime Map"), windowTitle = "Los Angeles Crime Map"),
  sidebarLayout (
    sidebarPanel(
           textInput("address",label=h4("Enter location or click on map"),
                     value=sample(locations_vector, size=1, replace=TRUE) ),
           
           sliderInput("radius",label=h4("Radius in miles"),
                       min=0.5,max=2.0,value=1.5, step=0.5),
           actionButton("goButton", "Search", style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
           selectInput("year", label = h4("Year"), years_vector),
           checkboxGroupInput("crimes", label = h4("Crime Type"), choices = crimes_vector, selected = crimes_checked, inline = TRUE),
           checkboxGroupInput("days_of_week", label = h4("Days of Week"), choices = days_vector, selected = days_checked, inline = TRUE),
           checkboxGroupInput("time_periods", label = h4("Time Periods"), choices = periods_vector, selected = periods_checked, inline = TRUE),
           selectInput("plots_facets", label = h4("Facet density maps and bar plots by"), plots_facets_vector),
           HTML('<a href="https://github.com/carlosror/la_crimes" target="_blank"><img src = "github_icon.png" alt = "xyz"></a>
                 <a href="https://twitter.com/LrnDataScience" target="_blank"><img src = "twitter_icon.png" alt = "xyz"></a>')
    ),
    mainPanel(
        tabsetPanel(
            tabPanel("Map", leafletOutput("map",width="auto",height="640px")),
            tabPanel("Data", dataTableOutput("DataTable")),
            tabPanel("Barplots", plotOutput("barplots", width = "auto", height="640px")),
            tabPanel("Density Maps (Patience)", plotOutput("density_maps", width = "auto", height="640px")),
            tabPanel("Table", verbatimTextOutput("table")),
            tabPanel("Notes", htmlOutput("notes"))
            # tabPanel("Debug", verbatimTextOutput("debug"))
        )
    )
)))