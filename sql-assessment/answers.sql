# Write a query to get the sum of impressions by day.
SELECT date, SUM(impressions)
FROM marketing_performance
GROUP BY date;

# Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?
# The third best state generated $ in revenue.
SELECT state, SUM(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 3;

# Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.
SELECT c.name,
  SUM(c.revenue),
  m.id,
  SUM(m.cost),
  SUM(m.impressions),
  SUM(m.clicks)
FROM marketing_performance AS m
JOIN campaign_info AS c
ON m.campaign_id = c.id
GROUP BY c.name, m.campaign_id;
  
# Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?
# # generated the most conversions for Campaign5. 
SELECT m.geo, 
  SUM(m.conversions)
FROM marketing_performance AS m
JOIN campaign_info as c
ON m.campaign_id = c.id
WHERE c.name = "Campaign5"
GROUP BY m.geo;
  
# In your opinion, which campaign was the most efficient, and why?
