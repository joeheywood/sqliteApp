library(plotly)

lineChart <- function(df) {
    if("x_t" %in% colnames(df) ){
        df$x <- as.POSIXct(df$x_t, origin = "1970-1-1")
    }
    if(! "x" %in% colnames(df) & "y" %in% colnames(df)){
        stop("Need x and y to be in df")
    }
    plot_ly(data = df, x = ~x, y = ~y, type = "scatter", mode = "lines")
}
        
        
        
