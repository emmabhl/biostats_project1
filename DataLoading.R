# Get data from website directly
www = "https://users.stat.ufl.edu/~winner/data/beerhall.dat"
data <- read.delim(www, header = FALSE, sep="")

# The data doesn't load correctly. Let's arrange the table around a little so we get correct columns
## Get number of columns
nc  <- ncol(data)
## For entries where the region name does not have two words, shift the 3rd to last columns to the keft
data[(14:16), 4:nc] <- data[(14:16), 3:nc]
data[(36:40), 4:nc] <- data[(36:40), 3:nc]
## For entries where the region name is one word, put them together in column 2
data[(1:13), 2] <- paste(data[(1:13), 2], data[(1:13), 3])
data[(17:35), 2] <- paste(data[(17:35), 2], data[(17:35), 3])


## Get rid of 3rd column
data <- subset(data, select = -3)

### Column V5 was of type char, we change it for int
data$V5 <- as.integer(data$V5)

## Add corresponding column names 
colnames(data) <- c("county", "region_name", "region_code", "criminals_per_100k", "ale_beer_houses_per_100k", "attendants_public_school_per_10k", "attendants_public_worship_per_2k")
## Saving newly modified object for later use
save(data, file="projectData.RData")
