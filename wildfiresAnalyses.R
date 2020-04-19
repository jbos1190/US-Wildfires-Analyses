# install.packages("RSQLite")
library("RSQLite")

con <- dbConnect(SQLite(), "FPA_FOD_20170508.sqlite")
fireData <- dbGetQuery(con, paste("SELECT OBJECTID id, ",
				  "DATETIME(DISCOVERY_DATE) discoveryDate, ",
				  "DISCOVERY_TIME discoveryTime, ",
				  "CONT_DATE containmentDate, ",
				  "CONT_TIME containmentTime, ",
				  "FIRE_SIZE fireSize, ",
				  "LATITUDE latitude, ",
				  "LONGITUDE longitude, ",
				  "STATE state, ",
				  "STAT_CAUSE_DESCR cause",
				  "FROM Fires"))
fireData$discoveryDate[1:3]
fireData$discoveryTime[1:3]
dateTimes <- dbGetQuery(con, "SELECT OBJECTID id, STRFTIME('%Y-%m-%d', DISCOVERY_DATE) || ' ' || SUBSTR(DISCOVERY_TIME, 1, 2) || ':' || SUBSTR(DISCOVERY_TIME, 3, 2) || ':00' AS discoveryTime FROM Fires")
dateTimes$discoveryTime[1:3]
ids <- fireData$id
ids <- sort.list(ids)
for (i in 1:(length(ids)-1))
	if (ids[i] >= ids[i+1])
		print("oops")
nullDiscoveryDate <- dbGetQuery(con, paste("SELECT OBJECTID",
					   "FROM Fires",
					   "WHERE DISCOVERY_DATE IS NULL"))
nrow(nullDiscoveryDate)
nullDiscoveryTime <- dbGetQuery(con, paste("SELECT OBJECTID id",
					   "FROM Fires",
					   "WHERE DISCOVERY_TIME IS NULL"))
nrow(nullDiscoveryTime)
nullContainmentDate <- dbGetQuery(con, paste("SELECT OBJECTID id",
					     "FROM Fires",
					     "WHERE CONT_DATE IS NULL"));
nrow(nullContainmentDate)
nullContainmentTime <- dbGetQuery(con, paste("SELECT OBJECTID id",
					 "FROM Fires",
					 "WHERE CONT_TIME IS NULL"))
nrow(nullContainmentTime)
dbDisconnect(con)
