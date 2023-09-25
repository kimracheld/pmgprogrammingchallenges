# 1. Write a query to get the sum of impressions by day.
SELECT date, SUM(impressions) AS total_impressions
FROM marketing_performance
GROUP BY date;

# 2. Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?
# The third best state, Ohio, generated $37577 in revenue.
SELECT state, SUM(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 3;

# 3. Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.
SELECT c.name AS campaign_name,
  SUM(m.cost) AS total_cost,
  SUM(m.impressions) AS total_impressions,
  SUM(m.clicks) AS total_clicks,
  SUM(w.revenue) AS total_revenue
FROM campaign_info AS c
JOIN marketing_performance AS m
ON c.id = m.campaign_id
LEFT JOIN website_revenue AS w
ON c.id = w.campaign_id
GROUP BY c.name
ORDER BY c.name;
  
# 4. Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?
# Georgia generated the most conversions for Campaign5, with a total of 672 conversions. 
SELECT m.geo AS state,
  SUM(m.conversions) AS total_conversions
FROM marketing_performance AS m
JOIN campaign_info AS c,
ON m.campaign_id = c.id
WHERE c.name = "Campaign5"
GROUP BY m.geo;
  
# 5. In your opinion, which campaign was the most efficient, and why?
# Campaign5 was the most efficient because it generated the most impressions, clicks, and conversions per dollar of profit (revenue - cost).

# 6. Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
# Thursday is the best day of the week to run ads, with the highest average of impressions, clicks, and conversions. 
# Disclaimer: I believe there is an easier way to determine the day of the week of the date, but my sqlite only allowed for this case. 
SELECT 
  CASE
    WHEN date = "2023-07-24 0:00:00" THEN "Monday" 
    WHEN date = "2023-08-14 0:00:00" THEN "Monday"
    WHEN date = "2023-07-26 0:00:00" THEN "Wednesday"
    WHEN date = "2023-08-02 0:00:00" THEN "Wednesday"
    WHEN date = "2023-07-27 0:00:00" THEN "Thursday"
    WHEN date = "2023-08-03 0:00:00" THEN "Thursday"
    WHEN date = "2023-08-10 0:00:00" THEN "Thursday"
    WHEN date = "2023-08-17 0:00:00" THEN "Thursday"
    WHEN date = "2023-07-28 0:00:00" THEN "Friday"
    WHEN date = "2023-08-04 0:00:00" THEN "Friday"
    WHEN date = "2023-08-11 0:00:00" THEN "Friday" 
    WHEN date = "2023-07-29 0:00:00" THEN "Saturday"
    WHEN date = "2023-08-05 0:00:00" THEN "Saturday"
    WHEN date = "2023-08-12 0:00:00" THEN "Saturday"
    WHEN date = "2023-08-19 0:00:00" THEN "Saturday"
    WHEN date = "2023-07-30 0:00:00" THEN "Sunday"
    WHEN date = "2023-08-13 0:00:00" THEN "Sunday"
  END AS day_of_week,
  AVG(impressions) AS avg_impressions,
  AVG(clicks) AS avg_clicks,
  AVG(conversions) AS avg_conversions
FROM marketing_performance
GROUP BY day_of_week
ORDER BY avg_impressions DESC;
