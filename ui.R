#adopted a script I found online to help with marketing analysis

vars <- setdiff(names(df), "month")

pageWithSidebar(
    headerPanel('Client data k-means clustering'),
    sidebarPanel(
        selectInput('xcol', 'X Variable', vars),
        selectInput('ycol', 'Y Variable', vars, selected = vars[[2]]),
        numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
    ),
    mainPanel(
        plotOutput('plot1')
    )
)