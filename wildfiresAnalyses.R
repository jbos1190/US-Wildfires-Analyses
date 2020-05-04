# install.packages("RSQLite")
library("RSQLite")

con <- dbConnect(SQLite(), "FPA_FOD_20170508.sqlite")
fireData <- dbGetQuery(con, paste("SELECT OBJECTID id,",
				  "STRFTIME('%Y-%m-%d', DISCOVERY_DATE)",
				     "discoveryDate,",
				  "SUBSTR(DISCOVERY_TIME, 1, 2) || ':'",
				     "|| SUBSTR(DISCOVERY_TIME, 3, 2) || ':00'",
				     "discoveryTime,",
				  "STRFTIME('%Y-%m-%d', DISCOVERY_DATE) || ' '",
				     "|| SUBSTR(DISCOVERY_TIME, 1, 2) || ':'",
				     "|| SUBSTR(DISCOVERY_TIME, 3, 2) || ':00'",
				     "discoveryDatetime,",
				  "STRFTIME('%Y-%m-%d', CONT_DATE)",
				     "containmentDate,",
				  "SUBSTR(CONT_TIME, 1, 2) || ':'",
				     "|| SUBSTR(CONT_TIME, 3, 2) || ':00'",
				     "containmentTime,",
				  "STRFTIME('%Y-%m-%d', CONT_DATE) || ' '",
				     "|| SUBSTR(CONT_TIME, 1, 2) || ':'",
				     "|| SUBSTR(CONT_TIME, 3, 2) || ':00'",
				     "containmentDatetime,",
				  "FIRE_SIZE fireSize,",
				  "LATITUDE latitude,",
				  "LONGITUDE longitude,",
				  "STATE state,",
				  "STAT_CAUSE_DESCR cause",
				  "FROM Fires"))
fireData$discoveryDate <- as.POSIXct(fireData$discoveryDate)
fireData$discoveryDatetime <- as.POSIXct(fireData$discoveryDatetime)
fireData$containmentDate <- as.POSIXct(fireData$containmentDate)
fireData$containmentDatetime <- as.POSIXct(fireData$containmentDatetime)

## confirm that id is a suitable primary key
#nullId <- dbGetQuery(con, "SELECT OBJECTID FROM Fires WHERE OBJECTID IS NULL")
#nrow(nullId)
#ids <- fireData$id
#ids <- sort.list(ids)
#for (i in 1:(length(ids)-1))
#	if (ids[i] >= ids[i+1])
#		print("oops")
#
#naDiscoveryDatetime <- which(is.na(fireData$discoveryDatetime))
#length(naDiscoveryDatetime)
#
## Find the ids that correspond to null values
#nullDiscoveryDate <- dbGetQuery(con, paste("SELECT OBJECTID",
#					   "FROM Fires",
#					   "WHERE DISCOVERY_DATE IS NULL"))
#nrow(nullDiscoveryDate)
#nullDiscoveryTime <- dbGetQuery(con, paste("SELECT OBJECTID id",
#					   "FROM Fires",
#					   "WHERE DISCOVERY_TIME IS NULL"))
#nrow(nullDiscoveryTime)
#nullContainmentDate <- dbGetQuery(con, paste("SELECT OBJECTID id",
#					     "FROM Fires",
#					     "WHERE CONT_DATE IS NULL"));
#nrow(nullContainmentDate)
#nullContainmentTime <- dbGetQuery(con, paste("SELECT OBJECTID id",
#					     "FROM Fires",
#					     "WHERE CONT_TIME IS NULL"))
#nrow(nullContainmentTime)
#nullContainmentDateOnly <- dbGetQuery(con,paste("SELECT OBJECTID id",
#						"FROM Fires",
#						"WHERE CONT_TIME IS NOT NULL",
#						"AND CONT_DATE IS NULL"))
#nrow(nullContainmentDateOnly)
#nullFireSize <- dbGetQuery(con, paste("SELECT OBJECTID id",
#				      "FROM Fires",
#				      "WHERE FIRE_SIZE IS NULL"))
#nrow(nullFireSize)
#nullLatitude <- dbGetQuery(con, paste("SELECT OBJECTID id",
#				      "FROM Fires",
#				      "WHERE LATITUDE IS NULL"))
#nrow(nullLatitude)
#nullLongitude <- dbGetQuery(con, paste("SELECT OBJECTID id",
#				       "FROM Fires",
#				       "WHERE LONGITUDE IS NULL"))
#nrow(nullLongitude)
#nullState <- dbGetQuery(con, paste("SELECT OBJECTID id",
#				   "FROM Fires",
#				   "WHERE STATE IS NULL"))
#nrow(nullState)
#nullCause <- dbGetQuery(con, paste("SELECT OBJECTID id",
#				   "FROM Fires",
#				   "WHERE STAT_CAUSE_DESCR IS NULL")) 
#nrow(nullCause)

# Create the AppEEARS data-request files
#for (i in c(2011:2015)){
#	as.character(i)
#	write.table(fireData[format(fireData$discoveryDate, "%Y") == as.character(i),
#		  c("id", "latitude", "longitude")],
#		  file = paste("AppEEARS_request_", i-1, ".csv", sep=""),
#		  sep = " ")
#}

dbDisconnect(con)
