# install.packages("RSQLite")
library(RSQLite)

con <- dbConnect(dbDriver(RSQLite), "FPA_FOD_20170508.sqlite")
fireData <- dbGetQuery(con, paste("SELECT ",
				  " ",
				  "FROM  ",)
