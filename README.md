# ✈️ British Airways Review Analysis (2016–2023)

> For more of my projects and data journey, visit my [Portfolio](https://www.ashutoshdeulkar.me/).

## Table of Contents

- [Project Background](#project-background)
- [Executive Summary](#executive-summary)
- [Insights Deep-Dive](#insights-deep-dive)
  - [Review Volume and Rating Trends](#review-volume-and-rating-trends)
  - [Aircraft Satisfaction](#aircraft-satisfaction)
  - [Traveler Segments and Seat Types](#traveler-segments-and-seat-types)
  - [Regional Satisfaction](#regional-satisfaction)
  - [Trip Verification and Recommendations](#trip-verification-and-recommendations)
  - [Complaint Clusters](#complaint-clusters)
- [Recommendations](#recommendations)
- [Assumptions and Caveats](#assumptions-and-caveats)

***

## Project Background

This project explores public review data of British Airways from 2016 through 2023. Each review contains details such as aircraft type, traveler type, seat class, rating categories, and review content. The objective is to identify performance trends, uncover root causes of negative feedback, and offer data-driven recommendations to improve customer satisfaction.

The dataset is sourced from Kaggle: [British Airways Passenger Reviews (2016 - 2023)](https://www.kaggle.com/datasets/praveensaik/british-airways-passenger-reviews-2016-2023)

## Executive Summary

An analysis of over 1,200 reviews shows that while British Airways maintains an average rating of **4.2**, specific areas such as **entertainment**, **food**, and **seat comfort** consistently receive scores below 3. Boeing aircraft like the 747 and 787 score the highest, whereas narrow-body Airbus models like the A321 score lower. Regional and traveler-type breakdowns reveal further disparities in satisfaction levels. Entertainment and value-for-money are key service categories requiring attention.

***

## Insights Deep-Dive

### Review Volume and Rating Trends

- Ratings peaked around 2018–2019 and declined post-2020, showing volatility post-pandemic.
- Monthly trendline reflects seasonal variations and service inconsistency in recent years.

### Aircraft Satisfaction

- Top-performing aircraft:
  - Boeing 747-400: 4.7 average rating
  - Boeing 777, 787 models: >4.4 ratings
- Lowest-performing aircraft:
  - Airbus A321, A319: <3.8 average ratings
- Wide-body aircraft show higher satisfaction scores due to better seat configuration and amenities.

### Traveler Segments and Seat Types

- Business and first-class passengers report higher ratings.
- Economy travelers are more likely to rate food, seat comfort, and entertainment below 3.
- Couples and leisure travelers leave more reviews but business travelers rate services more critically.

### Regional Satisfaction

- Reviews most frequently come from the United Kingdom, United States, and Europe.
- Passengers from Europe rate services higher than those from North America and Asia.

### Trip Verification and Recommendations

- Verified reviews average 4.4 vs. 3.9 for unverified.
- Only 22% of reviews are “Recommended”.
- Not-recommended trips correlate strongly with low food, comfort, and entertainment scores.

### Complaint Clusters

- Most frequent complaints (≤2 score):
  - Food/Beverages: 450+ reviews
  - Entertainment: 390+ reviews
  - Seat Comfort: 300+ reviews
- Many low-rated reviews mention poor check-in experience and outdated in-flight systems.

***

## Recommendations

- **Upgrade In-Flight Entertainment**: Modernize systems and offer multilingual content libraries.
- **Revamp Food Services**: Improve catering for long-haul flights and offer regional meal options.
- **Optimize Seat Comfort**: Reconfigure economy seats on older aircraft; add neck/head support.
- **Replace or Refurbish Airbus A321s**: Focus fleet investment on models with historically poor feedback.
- **Loyalty Program Awareness**: Encourage verified passengers to share feedback and reward those who do.

***

## Assumptions and Caveats

- The dataset is user-generated and may carry subjective bias.
- Missing values (-1) were treated as NULL and excluded from category averages.
- The “place” field is used to infer geographic region; may not reflect the true nationality of the traveler.
- Review volumes are not evenly distributed across years or regions.

***

- See SQL exploration: [`ba_reviews_exploration.sql`](ba_reviews_exploration.sql)  
- View Tableau dashboard: [British Airways Dashboard](https://public.tableau.com/views/BritishAirwaysReview_17151923528940/Dashboard1)  
- Raw data: [`ba_reviews.csv`](data/ba_reviews.csv), [`Countries.csv`](data/Countries.csv)
