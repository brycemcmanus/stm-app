#Packages
library(shiny)
library(shinythemes)
library(ggplot2)
library(ggthemes)
library(zoo)
library(dplyr)

#Data
load("data/stm_app.RData")

#Objects
justices <- c("Jay, John (10/19/1789 - 06/29/1795)","Rutledge, John (02/15/1790 - 03/05/1791)","Cushing, William (02/02/1790  - 09/13/1810)","Wilson, James (10/05/1789 - 08/21/1798)","Blair, John (02/02/1790 - 01/27/1796)","Iredell, James (05/12/1790 - 10/20/1799)","Johnson, Thomas (09/19/1791 - 02/22/1793)","Paterson,William (03/11/1793 - 09/09/1806)","Rutledge, John (08/12/1795 - 12/15/1795)","Chase, Samuel (02/04/1796 - 06/19/1811)","Ellsworth, Oliver (03/08/1796 - 12/15/1800)","Washington, Bushrod (11/09/1798 - 11/26/1829)","Moore, Alfred (04/21/1800 - 01/26/1804)","Marshall, John (02/04/1801 - 07/06/1835)","Johnson, William (05/07/1804 - 08/04/1834)","Livingston, Henry (01/20/1807 - 03/18/1823)","Todd, Thomas (05/04/1807 - 02/07/1826)","Duvall, Gabriel (11/23/1811 - 01/14/1835)","Story, Joseph (02/03/1812 - 09/10/1845)", "Thompson, Smith (09/01/1823 - 12/18/1843)","Trimble, Robert (06/16/1826 - 08/25/1828)",  
              "McLean, John (01/11/1830 - 04/04/1861)","Baldwin, Henry (01/18/1830 - 04/21/1844)","Wayne, James (01/14/1835 - 07/05/1867)","Taney, Roger (03/28/1836 - 10/12/1864)", "Barbour, Philip (05/12/1836 - 02/25/1841)","Catron, John (05/01/1837 - 05/30/1865)","McKinley, John (04/22/1837 - 07/19/1852)","Daniel, Peter (01/10/1842 - 05/31/1860)","Nelson, Samuel (02/27/1845 - 11/28/1872)","Woodbury, Levi (09/23/1845 - 09/04/1851)","Grier, Robert (08/10/1846 - 01/31/1870)","Curtis, Benjamin (10/10/1851 - 09/30/1857)","Campbell, John (04/11/1853 - 04/30/1861)","Clifford, Nathan (01/21/1858- 07/25/1881)","Swayne, Noah (01/27/1862 - 01/24/1881)","Miller, Samuel (07/21/1862 - 10/13/1890)", "Davis, David (10/17/1862 - 03/04/1877)","Field, Stephen (05/20/1863 - 12/01/1897)","Chase, Salmon (12/15/1864 - 05/07/1873)","Strong, William (03/14/1870 - 12/14/1880)","Bradley, Joseph (03/21/1870 - 01/22/1892)",
              "Hunt, Ward (01/09/1873 - 01/27/1882)","Waite, Morrison (03/04/1874 - 04/03/1888)","Harlan, John (12/10/1877 - 10/14/1911)","Woods, William (01/05/1881 - 05/14/1887)","Matthews, Stanley (05/17/1881 - 03/22/1889)","Gray, Horace (01/09/1882 - 09/15/1902)","Blatchford, Samuel (04/03/1882 - 07/07/1893)","Lamar, Lucius (01/18/1888 - 01/23/1893)","Fuller, Melville (10/08/1888 - 07/04/1910)","Brewer, David (01/06/1890 - 03/28/1910)","Brown, Henry (01/05/1891 - 05/28/1906)","Shiras, George (10/10/1892- 02/23/1903)","Jackson, Howell (03/04/1893 - 08/08/1895)","White, Edward (03/12/1894 - 05/19/1921)","Peckham, Rufus (01/06/1896 - 10/24/1909)","McKenna, Joseph (01/26/1898 - 01/05/1925)","Holmes, Oliver (08/11/1902 - 01/12/1932)", "Day, William (03/02/1903 - 11/13/1922)","Moody, William (12/17/1906 - 11/20/1910)", "Lurton, Horace (01/03/1910- 07/12/1914)","Hughes, Charles (10/10/1910- 06/10/1916)",  
              "Van Devanter, Willis (01/03/1911 - 06/02/1937)","Lamar, Joseph (01/03/1911 - 01/02/1916)","Pitney, Mahlon (03/18/1912 - 12/31/1922)","McReynolds, James (10/12/1914 - 01/31/1941)","Brandeis, Louis (06/05/1916 - 02/13/1939)","Clarke, John (10/09/1916 - 09/18/1922)", "Taft, William (07/11/1921 - 02/03/1930)","Sutherland, George (10/02/1922 - 01/17/1938)", "Butler, Pierce (01/02/1923 - 11/16/1939)","Sanford, Edward (02/19/1923 - 03/08/1930)","Stone, Harlan (03/02/1925- 04/22/1946)","Hughes, Charles (02/24/1930 - 07/01/1941)", "Roberts, Owen (06/02/1930 - 07/31/1945)","Cardozo, Benjamin (03/14/1932 - 07/09/1938)","Black, Hugo (08/19/1937 - 09/17/1971)","Reed, Stanley (01/31/1938 - 02/25/1957)","Frankfurter, Felix (01/30/1939 - 08/28/1962)","Douglas, William (04/17/1939 - 11/12/1975)","Murphy, Francis (02/05/1940 - 07/19/1949)","Byrnes, James (07/08/1941 - 10/03/1942)","Jackson, Robert (07/11/1941 - 10/09/1954)",
              "Rutledge, Wiley (02/15/1943 - 09/10/1949)", "Burton, Harold (10/01/1945 - 10/13/1958)","Vinson, Fred (06/24/1946 - 09/08/1953)","Clark, Tom (08/24/1949 - 06/12/1967)","Minton, Sherman (10/12/1949 - 10/15/1956)","Warren, Earl (10/05/1953 - 06/23/1969)","Harlan, John (03/28/1955 - 09/23/1971)","Brennan, William (10/16/1956 - 07/20/1990)","Whittaker, Charles (03/25/1957 - 03/31/1962)","Stewart, Potter (10/14/1958 - 07/03/1981)","White, Byron (04/16/1962 - 06/28/1993)","Goldberg, Arthur (10/01/1962 - 07/25/1965)","Fortas, Abe (10/04/1965 - 05/14/1969)","Marshall, Thurgood (10/02/1967 - 10/01/1991)","Burger, Warren (06/23/1969 - 09/26/1986)","Blackmun, Harry (06/09/1970 - 08/03/1994)","Powell, Lewis (01/07/1972 - 06/26/1987)","Rehnquist, William (01/07/1972 - 09/03/2005)","Stevens, John (12/19/1975 - 06/29/2010)","O'Connor, Sandra (09/25/1981 - 01/31/2006)","Scalia, Antonin (09/26/1986 - 02/13/2016)",  
              "Kennedy, Anthony (02/18/1988 - 00/00/0000)","Souter, David (10/09/1990 - 06/29/2009)","Thomas, Clarence (10/23/1991 - 00/00/0000)","Ginsburg, Ruth (08/10/1993 - 00/00/0000)", "Breyer, Stephen (08/03/1994 - 00/00/0000)","Roberts, John (09/29/2005 - 00/00/0000)","Alito, Samuel (01/31/2006 - 00/00/0000)","Sotomayor, Sonia (08/08/2009 - 00/00/0000)", "Kagan, Elena (08/07/2010 - 00/00/0000)","Gorsuch, Neil (04/08/2017 - 00/00/0000)","Kavanaugh, Brett (10/06/2018 - 00/00/0000)")

# Define UI ----
ui <- navbarPage("Supreme Court Structural Topic Model", theme = shinytheme("cosmo"),
                 
                 #####Lineplots ----
                 
                 tabPanel("Lineplot",
                          
                          fluidPage(
                            
                            titlePanel("Topic Proportions Over Time"),
                            
                            sidebarLayout(
                              
                              sidebarPanel("",
                                           
                                           selectInput("stm_data", "Select Number of Topics", 
                                                       c("5 topics", "10 topics", "14 topics", "15 topics", "20 topics", "25 topics", "50 topics", "100 topics")), 
                                           
                                           conditionalPanel("input.stm_data == '5 topics'", 
                                                            
                                                            selectInput("Topic_Area_5", 
                                                                        label = "Select a Topic", 
                                                                        choices = colnames(ourData_5[, -c(1:63)]))), 
                                           
                                           conditionalPanel("input.stm_data == '10 topics'", 
                                                            
                                                            selectInput("Topic_Area_10", 
                                                                        label = "Select a Topic", 
                                                                        choices = colnames(ourData_10[, -c(1:63)]))), 
                                           
                                           conditionalPanel("input.stm_data == '14 topics'", 
                                                            
                                                            selectInput("Topic_Area_14", 
                                                                        label = "Select a Topic", 
                                                                        choices = colnames(ourData_14[, -c(1:63)]))), 
                                           
                                           conditionalPanel("input.stm_data == '15 topics'", 
                                                            
                                                            selectInput("Topic_Area_15", 
                                                                        label = "Select a Topic", 
                                                                        choices = colnames(ourData_15[, -c(1:63)]))), 
                                           
                                           conditionalPanel("input.stm_data == '20 topics'",
                                                            
                                                            selectInput("Topic_Area_20", 
                                                                        label = "Select a Topic", 
                                                                        choices = colnames(ourData_20[,-c(1:63)]))), 
                                           
                                           conditionalPanel("input.stm_data == '25 topics'", 
                                                            
                                                            selectInput("Topic_Area_25", 
                                                                        label = "Select a Topic", 
                                                                        choices = colnames(ourData_25[, -c(1:63)]))), 
                                           
                                           conditionalPanel("input.stm_data == '50 topics'", 
                                                            
                                                            selectInput("Topic_Area_50", 
                                                                        label = "Select a Topic", 
                                                                        choices = colnames(ourData_50[, -c(1:63)]))), 
                                           
                                           conditionalPanel("input.stm_data == '100 topics'", 
                                                            
                                                            selectInput("Topic_Area_100", 
                                                                        label = "Select a Topic", 
                                                                        choices = colnames(ourData_100[, -c(1:63)]))), 
                                           
                                           checkboxInput("cb_dd", label = "Sort By Decision Direction",
                                                         value = FALSE),
                                           
                                           sliderInput("range", label = "Select Date Range",
                                                       min = 1803, max = 2010, value = c(1803, 2010))
                              
                                           ),  #sidebarPanel
                              
                              mainPanel(
                                plotOutput("topicplot"),
                                
                                h6("App designed by Bryce McManus with data courtsey of Doug Rice, University of Massachusetts-Amherst"),
                                
                                h5("Using eight separate structural topic models, this app allows users to 
                                   explore topics within every Supreme Court majority opinion from 1803 to 2010. 
                                   Please contact me with any questions or comments at brycemcmanus90@gmail.com.")
                                
                              ) #mainPanel    
                            )  #sidebarLayout
                          )   #fluidPage
                 ),   #tabPanel
                 
                 #####Barplots ----
                 
                 tabPanel("Barplot",
                          
                          fluidPage(
                            
                           titlePanel("Topic Proportions by Justice & Court"),
                            
                            sidebarLayout(
                              
                              sidebarPanel(
                                
                                selectInput("stm_data_bar", "Select Number of Topics", 
                                            c("14 topics", "20 topics"), selected = "14 topics"),
                                
                                conditionalPanel('input.barplots === "chief justice"',
                                                 
                                                 selectInput("chief_j", label = "Select Chief Justice",
                                                             choices = c("Marshall", "Taney", "Chase", 
                                                                         "Waite", "Fuller", "White", "Taft", 
                                                                         "Hughes", "Stone", "Vinson", "Warren", 
                                                                         "Burger", "Rehnquist", "Roberts"),
                                                             selected = "Roberts")), #conditionalPanel  
                                
                                conditionalPanel('input.barplots === "majority opinion writer"', 
                                                 
                                                 selectInput("majOW", label = "Select a Majority Opinion Writer",  
                                                             choices = justices, selected = "Roberts, John (09/29/2005 - 00/00/0000)")
                                ),#conditionalPanel
                                
                                conditionalPanel('input.barplots === "majority opinion assigner"', 
                                                 
                                                 selectInput("majOA", label = "Select a Majority Opinion Assigner",  
                                                             choices = justices, selected = "Roberts, John (09/29/2005 - 00/00/0000)")
                                ),#conditionalPanel
                                
                                checkboxInput("justice_dd", label = "Sort By Decision Direction",
                                              value = FALSE)), # sidebarPanel
                              
                              mainPanel(
                                
                                tabsetPanel(id  = "barplots",
                                            tabPanel("chief justice", plotOutput("c_barplot")),
                                            tabPanel("majority opinion writer", plotOutput("mow_barplot")),                                                  
                                            tabPanel("majority opinion assigner", plotOutput("moa_barplot"))),
                                
                                h6("App designed by Bryce McManus with data courtsey of Doug Rice")
                                
                              )   #mainPanel                         
                            )     #sidebarLayout      
                          )       #fluidPage
                        ),        #tabPanel
                 
                 ### Histograms
                 
                 tabPanel("Histogram", 
                          
                          fluidPage(
                            
                            titlePanel(""),
                            
                            sidebarLayout(
                              
                              sidebarPanel(
                                
                                selectInput("stm_data_hist", "Select Number of Topics", 
                                            c("5 topics", "10 topics", "14 topics", "15 topics", "20 topics", "25 topics", "50 topics", "100 topics")), 
                                
                                conditionalPanel("input.stm_data_hist == '5 topics'", 
                                                 
                                                 selectInput("hist_5", 
                                                             label = "Select a Topic", 
                                                             choices = colnames(ourData_5[, -c(1:63)]))), 
                                
                                conditionalPanel("input.stm_data_hist == '10 topics'", 
                                                 
                                                 selectInput("hist_10", 
                                                             label = "Select a Topic", 
                                                             choices = colnames(ourData_10[, -c(1:63)]))), 
                                
                                conditionalPanel("input.stm_data_hist == '14 topics'", 
                                                 
                                                 selectInput("hist_14", 
                                                             label = "Select a Topic", 
                                                             choices = colnames(ourData_14[, -c(1:63)]))), 
                                
                                conditionalPanel("input.stm_data_hist == '15 topics'", 
                                                 
                                                 selectInput("hist_15", 
                                                             label = "Select a Topic", 
                                                             choices = colnames(ourData_15[, -c(1:63)]))), 
                                
                                conditionalPanel("input.stm_data_hist == '20 topics'",
                                                 
                                                 selectInput("hist_20", 
                                                             label = "Select a Topic", 
                                                             choices = colnames(ourData_20[,-c(1:63)]))),
                                
                                conditionalPanel("input.stm_data_hist == '25 topics'", 
                                                 
                                                 selectInput("hist_25", 
                                                             label = "Select a Topic", 
                                                             choices = colnames(ourData_25[, -c(1:63)]))), 
                                
                                conditionalPanel("input.stm_data_hist == '50 topics'", 
                                                 
                                                 selectInput("hist_50", 
                                                             label = "Select a Topic", 
                                                             choices = colnames(ourData_50[, -c(1:63)]))), 
                                
                                conditionalPanel("input.stm_data_hist == '100 topics'", 
                                                 
                                                 selectInput("hist_100", 
                                                             label = "Select a Topic", 
                                                             choices = colnames(ourData_100[, -c(1:63)]))), 
                                
                                checkboxInput("hist_log", "Log Scale", value = FALSE),
                                
                                checkboxInput("hist_density", "Density", value = FALSE)), # sidebarPanel
                              
                              mainPanel(
                                
                                plotOutput("histogram"),
                                
                                h6("App designed by Bryce McManus with data courtsey of Doug Rice")) # mainPanel
                            
                            )    #sidebarLayout
                          )     #fluidPage
                 )      #tabPanel    
)       #navbarPage


# Define server logic ----
server <- function(input, output) {
  
  output$topicplot <- renderPlot({
    
    if (input$stm_data == "5 topics") { 
      
      topic_names <- names(ourData_5)
      
      topic <- which(topic_names == input$Topic_Area_5)
      
      topic <- ourData_5[[topic]]
      
      if (input$cb_dd) {
        
        ggplot(data = ourData_5, aes(x = term, y = topic)) + geom_smooth(aes(color = factor(decisionDirection))) + 
          coord_cartesian(xlim = input$range) + scale_color_manual(values = c("red", "blue", "green"), labels = c("conservative", "liberal", "not specified")) +
          labs(y = "Topic Prop", x = "Year", color = "Decision Direction") + theme_fivethirtyeight()
        
      } else { ggplot(data = ourData_5, aes(x = term, y = topic)) + geom_smooth() +
          coord_cartesian(xlim = input$range) + labs(y = "Topic Prop", x = "Year") + theme_fivethirtyeight()
      }
      
    } else if (input$stm_data == "10 topics") { 
        
      topic_names <- names(ourData_10)
      
      topic <- which(topic_names == input$Topic_Area_10)
      
      topic <- ourData_10[[topic]]
        
        if (input$cb_dd) {
          
          ggplot(data = ourData_10, aes(x = term, y = topic)) + geom_smooth(aes(color = factor(decisionDirection))) + 
            coord_cartesian(xlim = input$range) + scale_color_manual(values = c("red", "blue", "green"), labels = c("conservative", "liberal", "not specified")) +
            labs(y = "Topic Prop", x = "Year", color = "Decision Direction") + theme_fivethirtyeight()
          
        } else { ggplot(data = ourData_10, aes(x = term, y = topic)) + geom_smooth() +
            coord_cartesian(xlim = input$range) + labs(y = "Topic Prop", x = "Year") + theme_fivethirtyeight()
        }
        
    } else if (input$stm_data == "14 topics") { 
    
      topic_names <- names(ourData_14)
      
      topic <- which(topic_names == input$Topic_Area_14)
      
      topic <- ourData_14[[topic]]
    
      if (input$cb_dd) {
      
        ggplot(data = ourData_14, aes(x = term, y = topic)) + geom_smooth(aes(color = factor(decisionDirection))) + 
          coord_cartesian(xlim = input$range) + scale_color_manual(values = c("red", "blue", "green"), labels = c("conservative", "liberal", "not specified")) +
          labs(y = "Topic Prop", x = "Year", color = "Decision Direction") + theme_fivethirtyeight()
      
      } else { ggplot(data = ourData_14, aes(x = term, y = topic)) + geom_smooth() +
        coord_cartesian(xlim = input$range) + labs(y = "Topic Prop", x = "Year") + theme_fivethirtyeight()
      }
    
    } else if (input$stm_data == "15 topics") { 
      
      topic_names <- names(ourData_15)
      
      topic <- which(topic_names == input$Topic_Area_15)
      
      topic <- ourData_15[[topic]]
      
      if (input$cb_dd) {
        
        ggplot(data = ourData_15, aes(x = term, y = topic)) + geom_smooth(aes(color = factor(decisionDirection))) + 
          coord_cartesian(xlim = input$range) + scale_color_manual(values = c("red", "blue", "green"), labels = c("conservative", "liberal", "not specified")) +
          labs(y = "Topic Prop", x = "Year", color = "Decision Direction") + theme_fivethirtyeight()
        
      } else { ggplot(data = ourData_15, aes(x = term, y = topic)) + geom_smooth() +
          coord_cartesian(xlim = input$range) + labs(y = "Topic Prop", x = "Year") + theme_fivethirtyeight()
      }
      
    } else if (input$stm_data == "20 topics") {
      
      topic_names <- names(ourData_20)
      
      topic <- which(topic_names == input$Topic_Area_20)
      
      topic <- ourData_20[[topic]]
      
      if (input$cb_dd) {
        
        ggplot(data = ourData_20, aes(x = term, y = topic)) + geom_smooth(aes(color = factor(decisionDirection))) + 
          coord_cartesian(xlim = input$range) + scale_color_manual(values = c("red", "blue", "green"), labels = c("conservative", "liberal", "not specified")) +
          labs(y = "Topic Prop", x = "Year", color = "Decision Direction") + theme_fivethirtyeight()
        
      } else { ggplot(data = ourData_20, aes(x = term, y = topic)) + geom_smooth() +
          coord_cartesian(xlim = input$range) + labs(y = "Topic Prop", x = "Year") + theme_fivethirtyeight()
      }
      
    } else if (input$stm_data == "25 topics") {
      
      topic_names <- names(ourData_25)
      
      topic <- which(topic_names == input$Topic_Area_25)
      
      topic <- ourData_25[[topic]]
      
      if (input$cb_dd) {
        
        ggplot(data = ourData_25, aes(x = term, y = topic)) + geom_smooth(aes(color = factor(decisionDirection))) + 
          coord_cartesian(xlim = input$range) + scale_color_manual(values = c("red", "blue", "green"), labels = c("conservative", "liberal", "not specified")) +
          labs(y = "Topic Prop", x = "Year", color = "Decision Direction") + theme_fivethirtyeight()
        
      } else { ggplot(data = ourData_25, aes(x = term, y = topic)) + geom_smooth() +
          coord_cartesian(xlim = input$range) + labs(y = "Topic Prop", x = "Year") + theme_fivethirtyeight()
      }
      
    } else if (input$stm_data == "50 topics") {
      
      topic_names <- names(ourData_50)
      
      topic <- which(topic_names == input$Topic_Area_50)
      
      topic <- ourData_50[[topic]]
      
      if (input$cb_dd) {
        
        ggplot(data = ourData_50, aes(x = term, y = topic)) + geom_smooth(aes(color = factor(decisionDirection))) + 
          coord_cartesian(xlim = input$range) + scale_color_manual(values = c("red", "blue", "green"), labels = c("conservative", "liberal", "not specified")) +
          labs(y = "Topic Prop", x = "Year", color = "Decision Direction") + theme_fivethirtyeight()
        
      } else { ggplot(data = ourData_50, aes(x = term, y = topic)) + geom_smooth() +
          coord_cartesian(xlim = input$range) + labs(y = "Topic Prop", x = "Year") + theme_fivethirtyeight()
      }
    
    }else if (input$stm_data == "100 topics") {
      
      topic_names <- names(ourData_100)
      
      topic <- which(topic_names == input$Topic_Area_100)
      
      topic <- ourData_100[[topic]]
      
      if (input$cb_dd) {
        
        ggplot(data = ourData_100, aes(x = term, y = topic)) + geom_smooth(aes(color = factor(decisionDirection))) + 
          coord_cartesian(xlim = input$range) + scale_color_manual(values = c("red", "blue", "green"), labels = c("conservative", "liberal", "not specified")) +
          labs(y = "Topic Prop", x = "Year", color = "Decision Direction") + theme_fivethirtyeight()
        
      } else { ggplot(data = ourData_100, aes(x = term, y = topic)) + geom_smooth() +
          coord_cartesian(xlim = input$range) + labs(y = "Topic Prop", x = "Year") + theme_fivethirtyeight()
      }
    }
  })
  
  output$c_barplot <- renderPlot({
    
    chj <- switch(input$chief_j,"Marshall" = "Marshall", 
                  "Taney" = "Taney", 
                  "Chase" = "Chase", 
                  "Waite" = "Waite", 
                  "Fuller" =  "Fuller", 
                  "White" = "White", 
                  "Taft" = "Taft", 
                  "Hughes" = "Hughes", 
                  "Stone" = "Stone", 
                  "Vinson" = "Vinson", 
                  "Warren" = "Warren", 
                  "Burger" = "Burger", 
                  "Rehnquist" = "Rehnquist", 
                  "Roberts" = "Roberts")
    
    if (input$stm_data_bar == "14 topics") {
    
    if (input$justice_dd) {
      
      ggplot(data = filter(melt_df_14, chief == chj), aes(x = variable, y = value, fill = factor(decisionDirection))) + 
        stat_summary(fun.y = mean, geom = "bar", position = "dodge", color = "black") + labs(x = "Topic", y = "Topic Prop") +
        theme(axis.text.x = element_text(angle = 90)) + scale_fill_manual(values = c("#F8766D", "#619CCF", "#00BA38"), name = "Decision Direction", labels = c("Conservative", "Liberal", "Not Specified")) +
        scale_x_discrete(labels = c("invention", "writ", "tax", "criminal", "indian", "interstate", "lands", "bankruptcy", "the state", 
                                    "program", "vessel", "bonds", "secretary", "employer")) 
      
    } else {
      
      ggplot(data = filter(melt_df_14, chief == chj), aes(x = variable, y = value)) + 
        stat_summary(fun.y = mean, geom = "bar", fill = "indianred3", color = "black") + labs(x = "Topic", y = "Topic Prop") +
        theme(axis.text.x = element_text(angle = 90)) +
        scale_x_discrete(labels = c("invention", "writ", "tax", "criminal", "indian", "interstate", "lands", "bankruptcy", "the state", 
                                    "program", "vessel", "bonds", "secretary", "employer")) 
    }
    } else if (input$stm_data_bar == "20 topics") {
      
      if (input$justice_dd) {
        
        ggplot(data = filter(melt_df_20, chief == chj), aes(x = variable, y = value, fill = factor(decisionDirection))) + 
          stat_summary(fun.y = mean, geom = "bar", position = "dodge", color = "black") + labs(x = "Topic", y = "Topic Prop") +
          theme(axis.text.x = element_text(angle = 90)) + scale_fill_manual(values = c("#F8766D", "#619CCF", "#00BA38"), name = "Decision Direction", labels = c("Conservative", "Liberal", "Not Specified")) +
          scale_x_discrete(labels = c("invention", "error", "tax", "habeas", "the united", "interstate", "deed", "suits", "the state", 
                                      "s at", "vessel", "railroad company", "secretary", "the contract", "search", "lands", "employees", "the act", "school", "creditors"))
        
      } else {
        
        ggplot(data = filter(melt_df_20, chief == chj), aes(x = variable, y = value)) + 
          stat_summary(fun.y = mean, geom = "bar", fill = "#6699FF", color = "black") + labs(x = "Topic", y = "Topic Prop") +
          theme(axis.text.x = element_text(angle = 90)) + scale_x_discrete(labels = c("invention", "error", "tax", "habeas", "the united", "interstate", "deed", "suits", "the state", 
                                                                                      "s at", "vessel", "railroad company", "secretary", "the contract", "search", "lands", "employees", "the act", "school", "creditors"))
        
      }
    }
  })
  
  output$mow_barplot <- renderPlot({
    
    #use same method as topic plot
    MOW <- which(justices == input$majOW)
    
    if (input$stm_data_bar == "14 topics") {
    
    if (input$justice_dd) {
      
      ggplot(data = filter(melt_df_14, majOpinWriter == MOW), aes(x = variable, y = value, fill = factor(decisionDirection))) + 
        stat_summary(fun.y = mean, geom = "bar", position = "dodge", color = "black") + labs(x = "Topic", y = "Topic Prop") +
        theme(axis.text.x = element_text(angle = 90)) + scale_fill_manual(values = c("#F8766D", "#619CCF", "#00BA38"), name = "Decision Direction", labels = c("Conservative", "Liberal", "Not Specified")) +
        scale_x_discrete(labels = c("invention", "writ", "tax", "criminal", "indian", "interstate", "lands", "bankruptcy", "the state", 
                                    "program", "vessel", "bonds", "secretary", "employer")) 
      
    } else { 
      
      ggplot(data = filter(melt_df_14, majOpinWriter == MOW), aes(x = variable, y = value)) + 
        stat_summary(fun.y = mean, geom = "bar", fill = "sienna1", color = "black") + labs(x = "Topic", y = "Topic Prop") +
        theme(axis.text.x = element_text(angle = 90)) + 
        scale_x_discrete(labels = c("invention", "writ", "tax", "criminal", "indian", "interstate", "lands", "bankruptcy", "the state", 
                                    "program", "vessel", "bonds", "secretary", "employer")) 
      
    }    
    } else if (input$stm_data_bar == "20 topics") {
      
      if (input$justice_dd) {
        
        ggplot(data = filter(melt_df_20, majOpinWriter == MOW), aes(x = variable, y = value, fill = factor(decisionDirection))) + 
          stat_summary(fun.y = mean, geom = "bar", position = "dodge", color = "black") + labs(x = "Topic", y = "Topic Prop") +
          theme(axis.text.x = element_text(angle = 90)) + scale_fill_manual(values = c("#F8766D", "#619CCF", "#00BA38"), name = "Decision Direction", labels = c("Conservative", "Liberal", "Not Specified")) +
          scale_x_discrete(labels = c("invention", "error", "tax", "habeas", "the united", "interstate", "deed", "suits", "the state", 
                                      "s at", "vessel", "railroad company", "secretary", "the contract", "search", "lands", "employees", "the act", "school", "creditors"))
          
      } else { 
        
        ggplot(data = filter(melt_df_20, majOpinWriter == MOW), aes(x = variable, y = value)) + 
          stat_summary(fun.y = mean, geom = "bar", fill = "#FF9933", color = "black") + labs(x = "Topic", y = "Topic Prop") +
          theme(axis.text.x = element_text(angle = 90)) + scale_x_discrete(labels = c("invention", "error", "tax", "habeas", "the united", "interstate", "deed", "suits", "the state", 
                                                                                      "s at", "vessel", "railroad company", "secretary", "the contract", "search", "lands", "employees", "the act", "school", "creditors"))
        
      }
    }  
  })
  
  output$moa_barplot <- renderPlot({
    #use same method as topic plot
    MOA <- which(justices == input$majOA)
    
    if (input$stm_data_bar == "14 topics") {
    
    if (input$justice_dd) {
      
      ggplot(data = filter(melt_df_14, majOpinAssigner == MOA), aes(x = variable, y = value, fill = factor(decisionDirection))) + 
        stat_summary(fun.y = mean, geom = "bar", position = "dodge", color = "black") + labs(x = "Topic", y = "Topic Prop") +
        theme(axis.text.x = element_text(angle = 90)) + scale_fill_manual(values = c("#F8766D", "#619CCF", "#00BA38"), name = "Decision Direction", labels = c("Conservative", "Liberal", "Not Specified")) +
        scale_x_discrete(labels = c("invention", "writ", "tax", "criminal", "indian", "interstate", "lands", "bankruptcy", "the state", 
                                    "program", "vessel", "bonds", "secretary", "employer")) 
      #for label, use either word(gsub(",", " ", names(ourData_15[, -c(1:63)])), 1) or ... 
    } else {
      
      ggplot(data = filter(melt_df_14, majOpinAssigner == MOA), aes(x = variable, y = value)) + 
        stat_summary(fun.y = mean, geom = "bar", fill = "#0099CC", color = "black") + 
        labs(x = "Topic", y = "Topic Prop") + theme(axis.text.x = element_text(angle = 90)) +
        scale_x_discrete(labels = c("invention", "writ", "tax", "criminal", "indian", 
                                    "interstate", "lands", "bankruptcy", "the state", 
                                    "program", "vessel", "bonds", "secretary", "employer")) 
    }
    } else if (input$stm_data_bar == "20 topics") {
      
      if (input$justice_dd) {
        
        ggplot(data = filter(melt_df_20, majOpinAssigner == MOA), aes(x = variable, y = value, fill = factor(decisionDirection))) + 
          stat_summary(fun.y = mean, geom = "bar", position = "dodge", color = "black") + labs(x = "Topic", y = "Topic Prop") +
          theme(axis.text.x = element_text(angle = 90)) + scale_fill_manual(values = c("#F8766D", "#619CCF", "#00BA38"), name = "Decision Direction", labels = c("Conservative", "Liberal", "Not Specified")) +
          scale_x_discrete(labels = c("invention", "error", "tax", "habeas", "the united", "interstate", "deed", "suits", "the state", 
                                      "s at", "vessel", "railroad company", "secretary", "the contract", "search", "lands", "employees", "the act", "school", "creditors"))
        
      } else {
        
        ggplot(data = filter(melt_df_20, majOpinAssigner == MOA), aes(x = variable, y = value)) + 
          stat_summary(fun.y = mean, geom = "bar", fill = "#0099CC", color = "black") + 
          labs(x = "Topic", y = "Topic Prop") + theme(axis.text.x = element_text(angle = 90)) + scale_x_discrete(labels = c("invention", "error", "tax", "habeas", "the united", "interstate", "deed", "suits", "the state", 
                                                                                                                            "s at", "vessel", "railroad company", "secretary", "the contract", "search", "lands", "employees", "the act", "school", "creditors"))
        
      }
    }  
  })
  
  output$histogram <- renderPlot({
  
    if (input$stm_data_hist == "5 topics") {
      # use method from topic plot
      topic_names <- names(ourData_5)
      
      topic <- which(topic_names == input$hist_5)
      
      topic <- ourData_5[[topic]]
      
      if (input$hist_log == TRUE & input$hist_density == FALSE) {
        
        ggplot(ourData_5, aes(log(topic))) + geom_histogram(fill = "mediumpurple2", binwidth = .5) 
        
      } else if (input$hist_log == FALSE & input$hist_density == TRUE) {
        
        ggplot(ourData_5, aes(topic)) + geom_density(fill = "mediumpurple1", alpha = .3) 
        
      } else if (input$hist_log == TRUE & input$hist_density == TRUE) {
        
        ggplot(ourData_5, aes(log(topic))) + geom_histogram(aes(y = ..density..), binwidth = .5, fill = "white", color = "black") + 
          geom_density(alpha = .3, fill = "mediumpurple1") 
        
      } else {  
        
        ggplot(ourData_5, aes(topic)) + geom_histogram(fill = "mediumpurple2", binwidth = .05)
        
      }    
      
    } else if (input$stm_data_hist == "10 topics") {
      # use method from topic plot
      topic_names <- names(ourData_10)
      
      topic <- which(topic_names == input$hist_10)
      
      topic <- ourData_10[[topic]]
      
      if (input$hist_log == TRUE & input$hist_density == FALSE) {
        
        ggplot(ourData_10, aes(log(topic))) + geom_histogram(fill = "mediumpurple2", binwidth = .5) 
        
      } else if (input$hist_log == FALSE & input$hist_density == TRUE) {
        
        ggplot(ourData_10, aes(topic)) + geom_density(fill = "mediumpurple1", alpha = .3) 
        
      } else if (input$hist_log == TRUE & input$hist_density == TRUE) {
        
        ggplot(ourData_10, aes(log(topic))) + geom_histogram(aes(y = ..density..), binwidth = .5, fill = "white", color = "black") + 
          geom_density(alpha = .3, fill = "mediumpurple1") 
        
      } else {  
        
        ggplot(ourData_10, aes(topic)) + geom_histogram(fill = "mediumpurple2", binwidth = .05)
        
      }  
      
    } else if (input$stm_data_hist == "14 topics") {
    # use method from topic plot
      topic_names <- names(ourData_14)
      
      topic <- which(topic_names == input$hist_14)
      
      topic <- ourData_14[[topic]]
    
    if (input$hist_log == TRUE & input$hist_density == FALSE) {
      
      ggplot(ourData_14, aes(log(topic))) + geom_histogram(fill = "mediumpurple2", binwidth = .5) 
      
    } else if (input$hist_log == FALSE & input$hist_density == TRUE) {
      
      ggplot(ourData_14, aes(topic)) + geom_density(fill = "mediumpurple1", alpha = .3) 
      
    } else if (input$hist_log == TRUE & input$hist_density == TRUE) {
      
      ggplot(ourData_14, aes(log(topic))) + geom_histogram(aes(y = ..density..), binwidth = .5, fill = "white", color = "black") + 
        geom_density(alpha = .3, fill = "mediumpurple1") 
      
    } else {  
      
      ggplot(ourData_14, aes(topic)) + geom_histogram(fill = "mediumpurple2", binwidth = .05)
    
    }    
    } else if (input$stm_data_hist == "15 topics") {
      # use method from topic plot
      topic_names <- names(ourData_15)
      
      topic <- which(topic_names == input$hist_15)
      
      topic <- ourData_15[[topic]]
      
      if (input$hist_log == TRUE & input$hist_density == FALSE) {
        
        ggplot(ourData_15, aes(log(topic))) + geom_histogram(fill = "mediumpurple2", binwidth = .5) 
        
      } else if (input$hist_log == FALSE & input$hist_density == TRUE) {
        
        ggplot(ourData_15, aes(topic)) + geom_density(fill = "mediumpurple1", alpha = .3) 
        
      } else if (input$hist_log == TRUE & input$hist_density == TRUE) {
        
        ggplot(ourData_15, aes(log(topic))) + geom_histogram(aes(y = ..density..), binwidth = .5, fill = "white", color = "black") + 
          geom_density(alpha = .3, fill = "mediumpurple1") 
        
      } else {  
        
        ggplot(ourData_15, aes(topic)) + geom_histogram(fill = "mediumpurple2", binwidth = .05)
        
      }    
    } else if (input$stm_data_hist == "20 topics") {
      
      topic_names <- names(ourData_20)
      
      topic <- which(topic_names == input$hist_20)
      
      topic <- ourData_20[[topic]]
      
      if (input$hist_log == TRUE & input$hist_density == FALSE) {
        
        ggplot(ourData_20, aes(log(topic))) + geom_histogram(fill = "steelblue2", binwidth = .5) 
        
      } else if (input$hist_log == FALSE & input$hist_density == TRUE) {
        
        ggplot(ourData_20, aes(topic)) + geom_density(fill = "steelblue1", alpha = .3) 
        
      } else if (input$hist_log == TRUE & input$hist_density == TRUE) {
        
        ggplot(ourData_20, aes(log(topic))) + geom_histogram(aes(y = ..density..), binwidth = .5, fill = "white", color = "black") + 
          geom_density(alpha = .3, fill = "steelblue1") 
        
      } else {  
        
        ggplot(ourData_20, aes(topic)) + geom_histogram(fill = "steelblue2", binwidth = .05)
        
      }
      
      } else if (input$stm_data_hist == "25 topics") {
        # use method from topic plot
        topic_names <- names(ourData_25)
        
        topic <- which(topic_names == input$hist_25)
        
        topic <- ourData_25[[topic]]
        
        if (input$hist_log == TRUE & input$hist_density == FALSE) {
          
          ggplot(ourData_25, aes(log(topic))) + geom_histogram(fill = "mediumpurple2", binwidth = .5) 
          
        } else if (input$hist_log == FALSE & input$hist_density == TRUE) {
          
          ggplot(ourData_25, aes(topic)) + geom_density(fill = "mediumpurple1", alpha = .3) 
          
        } else if (input$hist_log == TRUE & input$hist_density == TRUE) {
          
          ggplot(ourData_25, aes(log(topic))) + geom_histogram(aes(y = ..density..), binwidth = .5, fill = "white", color = "black") + 
            geom_density(alpha = .3, fill = "mediumpurple1") 
          
        } else {  
          
          ggplot(ourData_25, aes(topic)) + geom_histogram(fill = "mediumpurple2", binwidth = .05)
          
        } 
        
      } else if (input$stm_data_hist == "50 topics") {
        # use method from topic plot
        topic_names <- names(ourData_50)
        
        topic <- which(topic_names == input$hist_50)
        
        topic <- ourData_50[[topic]]
        
        if (input$hist_log == TRUE & input$hist_density == FALSE) {
          
          ggplot(ourData_50, aes(log(topic))) + geom_histogram(fill = "mediumpurple2", binwidth = .5) 
          
        } else if (input$hist_log == FALSE & input$hist_density == TRUE) {
          
          ggplot(ourData_50, aes(topic)) + geom_density(fill = "mediumpurple1", alpha = .3) 
          
        } else if (input$hist_log == TRUE & input$hist_density == TRUE) {
          
          ggplot(ourData_50, aes(log(topic))) + geom_histogram(aes(y = ..density..), binwidth = .5, fill = "white", color = "black") + 
            geom_density(alpha = .3, fill = "mediumpurple1") 
          
        } else {  
          
          ggplot(ourData_50, aes(topic)) + geom_histogram(fill = "mediumpurple2", binwidth = .05)
          
        }    
      } else if (input$stm_data_hist == "100 topics") {
        # use method from topic plot
        topic_names <- names(ourData_100)
        
        topic <- which(topic_names == input$hist_100)
        
        topic <- ourData_100[[topic]]
        
        if (input$hist_log == TRUE & input$hist_density == FALSE) {
          
          ggplot(ourData_100, aes(log(topic))) + geom_histogram(fill = "mediumpurple2", binwidth = .5) 
          
        } else if (input$hist_log == FALSE & input$hist_density == TRUE) {
          
          ggplot(ourData_100, aes(topic)) + geom_density(fill = "mediumpurple1", alpha = .3) 
          
        } else if (input$hist_log == TRUE & input$hist_density == TRUE) {
          
          ggplot(ourData_100, aes(log(topic))) + geom_histogram(aes(y = ..density..), binwidth = .5, fill = "white", color = "black") + 
            geom_density(alpha = .3, fill = "mediumpurple1") 
          
        } else {  
          
          ggplot(ourData_100, aes(topic)) + geom_histogram(fill = "mediumpurple2", binwidth = .05)
          
        }    
        
    }
  })
  
  
} 

# Run the app ----
shinyApp(ui = ui, server = server)

