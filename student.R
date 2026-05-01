# 1. DEPENDENCY MANAGEMENT
if (!require("pacman")) install.packages("pacman")
pacman::p_load(shiny, shinydashboard, tidyverse, plotly, DT, shinycssloaders)

# --- 2. DATA SYNTHESIS (Based on 2026 Student AI Surveys) ---
# Adoption Trends (2024-2026)
trend_data <- data.frame(
  Year = c(2024, 2025, 2026),
  Usage_Pct = c(66, 92, 95),
  Assessment_Pct = c(53, 88, 94)
)

# Use Cases (2026)
use_cases <- data.frame(
  Task = c("Explaining Concepts", "Summarizing Content", "Structuring Ideas", 
           "Grammar/Editing", "Generating Drafts", "Wellbeing/Advice"),
  Value = c(72, 68, 64, 55, 56, 15)
)

# Sentiment Data
sentiment_data <- data.frame(
  Category = c("Improved Experience", "Saves Time", "Fear of False Accusation", 
               "Lack of Institutional Training", "AI Dependency Risk"),
  Percentage = c(49, 74, 53, 64, 30),
  Type = c("Positive", "Positive", "Negative", "Negative", "Negative")
)

# --- 3. USER INTERFACE ---
ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Student AI Insights 2026"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Executive Summary", tabName = "summary", icon = icon("university")),
      menuItem("Usage Patterns", tabName = "usage", icon = icon("laptop-code")),
      menuItem("Risks & Ethics", tabName = "ethics", icon = icon("shield-alt"))
    ),
    hr(),
    helpText("Analysis based on HEPI and UNESCO 2026 Student Life Reports.", 
             style = "padding: 10px; color: #abb2b9;")
  ),
  
  dashboardBody(
    tags$head(tags$style(HTML("
      .content-wrapper { background-color: #f8f9fa !important; }
      .box { border-top: 3px solid #605ca8 !important; border-radius: 10px; }
    "))),
    
    tabItems(
      # TAB 1: EXECUTIVE SUMMARY
      tabItem(tabName = "summary",
              fluidRow(
                valueBox("95%", "Universal Adoption", icon = icon("users"), color = "purple", width = 4),
                valueBox("74%", "Time Efficiency Gain", icon = icon("clock"), color = "green", width = 4),
                valueBox("36%", "Formal Training Rate", icon = icon("graduation-cap"), color = "orange", width = 4)
              ),
              fluidRow(
                box(title = "The Exponential Rise of Student AI Usage", status = "primary", solidHeader = TRUE,
                    plotlyOutput("adoption_plot") %>% withSpinner(), width = 8),
                box(title = "Daily Sentiment", status = "primary", solidHeader = TRUE,
                    plotlyOutput("sentiment_donut"), width = 4)
              )
      ),
      
      # TAB 2: USAGE PATTERNS
      tabItem(tabName = "usage",
              fluidRow(
                box(title = "Primary AI Use Cases in 2026", status = "info", solidHeader = TRUE,
                    plotlyOutput("use_case_bar"), width = 12)
              ),
              fluidRow(
                box(title = "Top 5 Emerging AI Wellbeing Tools", status = "info",
                    HTML("<ul>
                     <li><b>Companion Bots:</b> Addressing loneliness (15% usage)</li>
                     <li><b>Draft Outliners:</b> Reducing cognitive load</li>
                     <li><b>24/7 Tutors:</b> Spaced repetition and active recall</li>
                     <li><b>Transcription Bots:</b> Freeing lecture time for engagement</li>
                     <li><b>Ethics Checkers:</b> Verifying AI disclosure statements</li>
                   </ul>"), width = 6),
                box(title = "Impact Metrics", status = "info",
                    plotlyOutput("impact_radar"), width = 6)
              )
      ),
      
      # TAB 3: RISKS & ETHICS
      tabItem(tabName = "ethics",
              fluidRow(
                box(title = "The 'Shadow Literacy' Divide", status = "danger", solidHeader = TRUE,
                    p("A critical gap has emerged in 2026: Students from higher socio-economic backgrounds use AI for high-level 
                research strategy, while others primarily use it for surface-level task completion."),
                    plotlyOutput("risk_plot"), width = 7),
                box(title = "Institutional Policy Gaps", status = "warning",
                    p("While 95% of students use AI, institutional policy remains reactive:"),
                    tags$ul(
                      tags$li("71% of U.S. teachers lack formal AI training."),
                      tags$li("53% of students fear 'false plagiarism' accusations."),
                      tags$li("Only 10% of global institutions have binding guidelines.")
                    ), width = 5)
              )
      )
    )
  )
)

# --- 4. SERVER LOGIC ---
server <- function(input, output) {
  
  # Adoption Line Chart
  output$adoption_plot <- renderPlotly({
    p <- plot_ly(trend_data, x = ~Year) %>%
      add_lines(y = ~Usage_Pct, name = 'General Usage', line = list(color = '#605ca8', width = 4)) %>%
      add_lines(y = ~Assessment_Pct, name = 'Use in Assessments', line = list(dash = 'dot', color = '#28b463')) %>%
      layout(yaxis = list(title = "Percentage (%)"), xaxis = list(title = "Academic Year"))
    p
  })
  
  # Use Case Bar Chart
  output$use_case_bar <- renderPlotly({
    p <- ggplot(use_cases, aes(x = reorder(Task, Value), y = Value, fill = Value)) +
      geom_col() + coord_flip() + theme_minimal() +
      scale_fill_gradient(low = "#d1d0e8", high = "#605ca8") +
      labs(x = "", y = "% of Students Reporting Use")
    ggplotly(p)
  })
  
  # Sentiment Donut
  output$sentiment_donut <- renderPlotly({
    plot_ly(sentiment_data[1:2,], labels = ~Category, values = ~Percentage, type = 'pie', hole = 0.6) %>%
      layout(showlegend = FALSE, margin = list(t=0, b=0, l=0, r=0))
  })
  
  # Risk Assessment Plot
  output$risk_plot <- renderPlotly({
    negatives <- sentiment_data %>% filter(Type == "Negative")
    plot_ly(negatives, x = ~Category, y = ~Percentage, type = 'bar', 
            marker = list(color = '#e74c3c')) %>%
      layout(yaxis = list(title = "Student Concern Level (%)"))
  })
  
  # Impact Radar (Dummy values representing qualitative impact)
  output$impact_radar <- renderPlotly({
    plot_ly(
      type = 'scatterpolar',
      r = c(90, 85, 40, 70, 95),
      theta = c('Time Saving','Accessibility','Critical Thinking','Creativity','Research Speed'),
      fill = 'toself',
      marker = list(color = '#17a2b8')
    ) %>%
      layout(polar = list(radialaxis = list(visible = T, range = c(0,100))), showlegend = F)
  })
}

# --- 5. EXECUTION ---
shinyApp(ui, server)
