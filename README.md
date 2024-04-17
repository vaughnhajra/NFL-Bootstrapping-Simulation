# FANTASY FOOTBALL BOOTSTRAPPING & SIMULATION

## Vaughn Hajra and Quang Nguyen
### Stats 226
#### November 2, 2022

## FANTASY FOOTBALL EXPLAINED
- **What Is Fantasy Football?**
  - NFL Players earn points based on real-life stats
  - Fans draft players for their fantasy “team”
  - Goal: score more than your opponent’s team each week

- **Our Data:**
  - 2 Datasets of Interest
    - PPR Week 8 Projections from 6 different sources
    - Weekly Fantasy Data from top 50 Wide Receivers
  - LOTS of data wrangling to combine into datasets 

## BOOTSTRAPPING EXAMPLES
- **Preparing Data for Bootstrapping**
  - Adding Dataset to R
  - pivot_longer()
  - trialNo and names for future compiled data frame

- **Bootstrapping Projections by Sampling**
  - One player at a time
  - 6 for projected values from sources
  - Creating Dataframe for Graphs

## Simulation Examples
- **Predicting Fantasy Points:**
  - Probability of scoring at least 10 fantasy points

- **Predicting Receiving Yards:**
  - Probability of a top 50 WR Gaining at least 75 Yards

- **Predicting Probabilities of Making Catches:**
  - How many targets for 6 receptions?

## Recap / Takeaways
- Kupp and Diggs for Week 8!
- Top 50 WRs usually have 10+ Points
- 75+ Receiving Yards is a GOOD GAME, even for top 50!
- Number of receptions for a player is a good tell!

## Potential Issues / Future Study
- Why no Prediction and Confidence Intervals for Bootstrapping
- Dataset Flaws (only top 50 per week leads to different data than ALL receivers)
- Potential for Over-Fitting of Data
- Looking at prediction models with more data to source
- Looking at multiple positions
- Taking matchup into account when making projections

## THANK YOU! ANY QUESTIONS?

**Sources:**
- Bootstrapping idea from [Fantasy Football Data Pros](https://www.fantasyfootballdatapros.com/blog/intermediate/7)
- Photos all via Google Images
- Negative Binomial Simulation Ideas from [RPubs](https://rpubs.com/mpfoley73/458738)
- Wikipedia used for many of the distribution research
