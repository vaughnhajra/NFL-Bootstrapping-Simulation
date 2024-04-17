library(tidyverse)
library(mdsr)
library(ggplot2)
library(mosaic)
library(fitdistrplus)

##########   BOOTSTRAP   ##########

###Load file and pivot longer to reorganize data frame
bootstrapDataOriginal <- read.csv("~/Downloads/Copy of Fantasy Football Projections Edited - DataForBootStrapping.csv", header = TRUE)
bootstrapData <- bootstrapDataOriginal %>%
  pivot_longer(FantasyData:FFToday, names_to = "Fantasy Website", values_to = "Projected Points")
bootstrapData <- bootstrapData %>%
  select(-Mean)


### Trial number and names for later data frame
trialNo <- c(1:100000)
names <- c("Kupp", "Hill", "Jefferson", "Diggs", "Adams")


##Cooper Kupp
bootstrapKupp <- bootstrapData %>%
  filter(Name == "Cooper Kupp")

bootmeansKupp=NULL
for(i in 1:100000) {
  boot <- sample(bootstrapKupp$`Projected Points`, 6, replace=TRUE)
  bootmeansKupp[i] <- mean(boot)
}
hist(bootmeansKupp)
mean(bootmeansKupp)


##Tyreek Hill
bootstrapHill <- bootstrapData %>%
  filter(Name == "Tyreek Hill")

bootmeansHill=NULL
for(i in 1:100000) {
  boot <- sample(bootstrapHill$`Projected Points`, 6, replace=TRUE)
  bootmeansHill[i] <- mean(boot)
}
hist(bootmeansHill)
mean(bootmeansHill)


##Justin Jefferson
bootstrapJefferson <- bootstrapData %>%
  filter(Name == "Justin Jefferson")

bootmeansJefferson=NULL
for(i in 1:100000) {
  boot <- sample(bootstrapJefferson$`Projected Points`, 6, replace=TRUE)
  bootmeansJefferson[i] <- mean(boot)
}
hist(bootmeansJefferson)
mean(bootmeansJefferson)


##Stefon Diggs
bootstrapDiggs <- bootstrapData %>%
  filter(Name == "Stefon Diggs")

bootmeansDiggs=NULL
for(i in 1:100000) {
  boot <- sample(bootstrapDiggs$`Projected Points`, 6, replace=TRUE)
  bootmeansDiggs[i] <- mean(boot)
}
hist(bootmeansDiggs)
mean(bootmeansDiggs)
margin <- qt(0.975,df=100000-1)*s/sqrt(100000)


##Davante Adams
bootstrapAdams <- bootstrapData %>%
  filter(Name == "Davante Adams")

bootmeansAdams=NULL
for(i in 1:100000) {
  boot <- sample(bootstrapAdams$`Projected Points`, 6, replace=TRUE)
  bootmeansAdams[i] <- mean(boot)
}
hist(bootmeansAdams)
mean(bootmeansAdams)


##Creating the data frame for geom_density()
bootmeans <- c(bootmeansAdams, bootmeansDiggs, bootmeansHill, bootmeansJefferson, bootmeansKupp)
dfAdams <- data.frame(bootmeans = bootmeansAdams, trialNo, names ="Adams")
dfDiggs <- data.frame(bootmeans = bootmeansDiggs, trialNo, names ="Diggs")
dfKupp <- data.frame(bootmeans = bootmeansKupp, trialNo, names ="Kupp")
dfJefferson <- data.frame(bootmeans = bootmeansJefferson, trialNo, names ="Jefferson")
dfHill <- data.frame(bootmeans = bootmeansHill, trialNo, names ="Hill")

##Combining into one data frame
totalSimulated <- rbind(dfDiggs, dfAdams, dfKupp, dfJefferson, dfHill)

## geom_density() for top 5 WRs with bootstrapped values 
ggplot(totalSimulated, aes(x=bootmeans, color = names)) + 
  geom_density() +
  theme_light()

## Boxplot for prediction comparisons
ggplot(totalSimulated, aes(x=names, y=bootmeans)) +
  geom_boxplot() +
  theme_light()

########## GAMMA DISTRIBUTION ###########

## Choosing receiving yards above x yards to be a good WR
recYards <- fantasy %>%
  filter(YDS.2 >= 75)

newfantasy <- fantasy %>%
  filter(YDS.2 > 0)

favstats(recYards$YDS.2)

## Gamma distribution

fitGamma <- fitdist(newfantasy$YDS.2, distr = "gamma", method = "mle") ##mle = maximum likelihood estimation

summary(fitGamma) #Parameters: Shape = 4.94713168, Rate = 0.06736476

plot(fitGamma)

WRyards <- rgamma(100000, 5, rate = 0.07)
histogram(WRyards)
histogram(fantasy$YDS.2)

# Creating rgamma with 100,000 Simulations
# Shape and Rate from rounded parameters
WRyards <- rgamma(100000, 5, rate = 0.07) 

# Counts when WRyards is at least 75
count <- 0
for(j in 100000){
  for(i in 1:100000){
    if((WRyards[i]>=75)){
      count <- count + 1
    }
  }
  propYards <- count/100000
}
mean(propYards) #Value = 0.39664

favstats(fantasy$YDS.2)
favstats(~YDS.2, data = filter(fantasy, YDS.2 >= 75))
138/350


## NEGATIVE BINOMIAL DISTRIBUTION
favstats(fantasy$REC) #n = 350
favstats(fantasy$TAR) #n = 350
favstats(~REC, data = filter(fantasy, REC>=6)) # n = 147
favstats(~TAR, data = filter(fantasy, TAR>=6, TAR<=12)) # n = 228

receptions = 6 

p = (228/350)*(147/350)

targets = c(12:6) #Expecting 6 to 12 targets to get 6 receptions

sum(dnbinom(x = targets, size = 6, prob = p)) #Value = 0.3150445

# Simulating 100,000 trials
WRreceptions <- rnbinom(100000, size = receptions, prob = p)

hist(WRreceptions)

count <- 0
for(i in 1:100000){
  if((WRreceptions[i]>=6) && (WRreceptions[i]<=12)){
      count <- count + 1
  }
}
prop = count/100000
prop #Value = 0.3152

## url = https://rpubs.com/mpfoley73/458738
