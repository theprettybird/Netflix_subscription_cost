## Countries with highest cost for basic plan - Switzerland and Lit

SELECT * 
FROM netflix_subscription_cost.netflix_subscription_fee
WHERE `Cost Per Month - Basic ($)` = (SELECT Max(`Cost Per Month - Basic ($)`) FROM netflix_subscription_cost.netflix_subscription_fee)
;

## Countries with lowest cost for basic plan - Turkey

SELECT *
FROM netflix_subscription_cost.netflix_subscription_fee
WHERE `Cost Per Month - Basic ($)` = (SELECT Min(`Cost Per Month - Basic ($)`) FROM netflix_subscription_cost.netflix_subscription_fee)
;

## Countries with highest number of movies - Malaysia

SELECT *
FROM netflix_subscription_cost.netflix_subscription_fee
WHERE `No. of Movies` = (SELECT Max(`No. of Movies`) FROM netflix_subscription_cost.netflix_subscription_fee)
;

## countries with lowest number of movies - San Marino

SELECT *
FROM netflix_subscription_cost.netflix_subscription_fee
WHERE `No. of Movies` = (SELECT Min(`No. of Movies`) AS country_lowest_movies FROM netflix_subscription_cost.netflix_subscription_fee)
;


## countries with largest library - Czechia 

SELECT *
FROM netflix_subscription_cost.netflix_subscription_fee
WHERE `Total Library Size` = (SELECT Max(`Total Library Size`) AS largest_library FROM netflix_subscription_cost.netflix_subscription_fee)
;


## countries with smallest library - Croatia

SELECT *
FROM netflix_subscription_cost.netflix_subscription_fee
WHERE `Total Library Size` = (SELECT Min(`Total Library Size`) AS smallest_library FROM netflix_subscription_cost.netflix_subscription_fee)
;


## countries with same monthly cost for basic plan

SELECT Country, `Cost Per Month - Basic ($)`, `Cost Per Month - Standard ($)`, `Cost Per Month - Premium ($)`
FROM netflix_subscription_cost.netflix_subscription_fee
WHERE `Cost Per Month - Basic ($)` = 9.03
ORDER BY `Cost Per Month - Standard ($)` DESC
;

## average cost for basic plan - 8.37

SELECT ROUND(AVG(`Cost Per Month - Basic ($)`),2) AS avg_basic_cost
FROM netflix_subscription_cost.netflix_subscription_fee
;


## countries that pay higher than average pricev - 37

WITH country_with_higher_cost_than_average AS (
SELECT Country, `Cost Per Month - Basic ($)`
FROM netflix_subscription_cost.netflix_subscription_fee
WHERE `Cost Per Month - Basic ($)` > (SELECT ROUND(AVG(`Cost Per Month - Basic ($)`),2) AS avg_basic_cost
									  FROM netflix_subscription_cost.netflix_subscription_fee)
ORDER BY `Cost Per Month - Basic ($)` DESC
)
SELECT COUNT(Country)
FROM country_with_higher_cost_than_average;


## Percentage of countries that pay higher cost than average - 56.92%

WITH percentage_country_with_higher_cost_than_average AS (
SELECT Country, `Cost Per Month - Basic ($)`
FROM netflix_subscription_cost.netflix_subscription_fee
WHERE `Cost Per Month - Basic ($)` > (SELECT ROUND(AVG(`Cost Per Month - Basic ($)`),2) AS avg_basic_cost
									  FROM netflix_subscription_cost.netflix_subscription_fee)
ORDER BY `Cost Per Month - Basic ($)` DESC
)
SELECT (COUNT(Country))/ (SELECT COUNT(Country) FROM netflix_subscription_cost.netflix_subscription_fee)*100 AS percentage_country_with_higher_cost_than_average
FROM percentage_country_with_higher_cost_than_average;

