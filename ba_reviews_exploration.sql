-- British Airways Review SQL Analysis

-- Monthly Trends of Ratings (time series)
SELECT
  DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%Y'), '%Y-%m') AS review_month,
  ROUND(AVG(rating), 2) AS avg_rating,
  COUNT(*) AS total_reviews
FROM ba_reviews
GROUP BY review_month
ORDER BY review_month;

-- Average Ratings by Aircraft
SELECT
  aircraft,
  COUNT(*) AS total_reviews,
  ROUND(AVG(rating), 2) AS avg_rating
FROM ba_reviews
GROUP BY aircraft
ORDER BY avg_rating DESC;

-- Average Ratings by Seat Type and Traveller Type
SELECT
  seat_type,
  traveller_type,
  COUNT(*) AS total_reviews,
  ROUND(AVG(rating), 2) AS avg_rating
FROM ba_reviews
GROUP BY seat_type, traveller_type
ORDER BY avg_rating DESC;

-- Recommended vs Not Recommended Breakdown
SELECT
  recommended,
  COUNT(*) AS review_count,
  ROUND(AVG(rating), 2) AS avg_rating
FROM ba_reviews
GROUP BY recommended;

-- Verified vs Not Verified Trip Comparison
SELECT
  trip_verified,
  COUNT(*) AS review_count,
  ROUND(AVG(rating), 2) AS avg_rating
FROM ba_reviews
GROUP BY trip_verified;

-- Category-Specific Averages
SELECT
  ROUND(AVG(seat_comfort), 2) AS avg_seat_comfort,
  ROUND(AVG(cabin_staff_service), 2) AS avg_cabin_service,
  ROUND(AVG(food_beverages), 2) AS avg_food,
  ROUND(AVG(ground_service), 2) AS avg_ground_service,
  ROUND(AVG(entertainment), 2) AS avg_entertainment,
  ROUND(AVG(value_for_money), 2) AS avg_value
FROM ba_reviews
WHERE entertainment != -1;

-- Region-Based Feedback (by 'place' field)
SELECT
  place,
  COUNT(*) AS review_count,
  ROUND(AVG(rating), 2) AS avg_rating
FROM ba_reviews
GROUP BY place
ORDER BY avg_rating DESC;

-- Top 10 Routes with Lowest Ratings
SELECT
  route,
  COUNT(*) AS total_reviews,
  ROUND(AVG(rating), 2) AS avg_rating
FROM ba_reviews
GROUP BY route
HAVING total_reviews > 5
ORDER BY avg_rating ASC
LIMIT 10;

-- Time Lag Between Flight Date and Review Date
SELECT
  ROUND(AVG(DATEDIFF(STR_TO_DATE(date, '%d/%m/%Y'), STR_TO_DATE(date_flown, '%d/%m/%Y'))), 2) AS avg_days_between_flight_and_review
FROM ba_reviews
WHERE date_flown IS NOT NULL;

-- Ratings over time by recommended flag
SELECT
  DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%Y'), '%Y-%m') AS review_month,
  recommended,
  COUNT(*) AS review_count,
  ROUND(AVG(rating), 2) AS avg_rating
FROM ba_reviews
GROUP BY review_month, recommended
ORDER BY review_month, recommended;

-- Lowest Rated Reviews by Aircraft and Seat Type
WITH ranked_reviews AS (
  SELECT
    aircraft,
    seat_type,
    rating,
    content,
    ROW_NUMBER() OVER (PARTITION BY aircraft ORDER BY rating ASC) AS rating_rank
  FROM ba_reviews
  WHERE rating IS NOT NULL
)
SELECT
  aircraft,
  seat_type,
  rating,
  content
FROM ranked_reviews
WHERE rating_rank = 1
ORDER BY rating ASC;

-- Top Aircrafts by Volume and Consistency
SELECT
  aircraft,
  COUNT(*) AS total_reviews,
  ROUND(AVG(rating), 2) AS avg_rating,
  ROUND(STDDEV(rating), 2) AS rating_volatility
FROM ba_reviews
GROUP BY aircraft
HAVING total_reviews > 20
ORDER BY avg_rating DESC, rating_volatility ASC;

-- Verified vs Non-Verified by Route (with Ratio)
SELECT
  route,
  COUNT(*) AS total_reviews,
  SUM(CASE WHEN trip_verified = 'Verified' THEN 1 ELSE 0 END) AS verified_count,
  SUM(CASE WHEN trip_verified = 'Not Verified' THEN 1 ELSE 0 END) AS not_verified_count,
  ROUND(SUM(CASE WHEN trip_verified = 'Verified' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS verified_ratio
FROM ba_reviews
GROUP BY route
HAVING total_reviews > 10
ORDER BY verified_ratio DESC;

-- Join BA Reviews with Country Regions
SELECT
  r.place,
  c.continent,
  c.region,
  COUNT(*) AS review_count,
  ROUND(AVG(r.rating), 2) AS avg_rating
FROM ba_reviews r
LEFT JOIN country_metadata c
  ON r.place = c.Country
GROUP BY r.place, c.continent, c.region
ORDER BY avg_rating DESC;

-- Identify Common Themes in Lowest Rated Reviews
SELECT
  r.rating,
  r.content,
  r.aircraft,
  r.seat_type,
  r.traveller_type,
  r.recommended
FROM ba_reviews r
WHERE rating <= 2
ORDER BY rating ASC
LIMIT 100;

-- Top 5 Most Common Complaints by Category
SELECT
  'food_beverages' AS category,
  ROUND(AVG(food_beverages), 2) AS avg_score,
  COUNT(*) AS total
FROM ba_reviews WHERE food_beverages <= 2
UNION
SELECT
  'seat_comfort', ROUND(AVG(seat_comfort), 2), COUNT(*)
FROM ba_reviews WHERE seat_comfort <= 2
UNION
SELECT
  'cabin_staff_service', ROUND(AVG(cabin_staff_service), 2), COUNT(*)
FROM ba_reviews WHERE cabin_staff_service <= 2
UNION
SELECT
  'ground_service', ROUND(AVG(ground_service), 2), COUNT(*)
FROM ba_reviews WHERE ground_service <= 2
UNION
SELECT
  'entertainment', ROUND(AVG(entertainment), 2), COUNT(*)
FROM ba_reviews WHERE entertainment <= 2
ORDER BY total DESC;
