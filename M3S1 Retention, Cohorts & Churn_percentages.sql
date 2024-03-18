```
--Main Data
WITH 
CTE_week AS (
  SELECT 
    subs.user_pseudo_id,
    DATE_TRUNC(subs.subscription_start, WEEK) AS start_week,
    subs.subscription_end
  FROM `turing_data_analytics.subscriptions` subs), 

--CTE that counts subscriptions
CTE_subscribers AS (
  SELECT 
    CTE_week.start_week,
    COUNT(user_pseudo_id) AS week_zero,
    SUM(CASE WHEN subscription_end IS NULL OR subscription_end > DATE_ADD(CTE_week.start_week, INTERVAL 1 WEEK) THEN 1 ELSE 0 END) AS week_one,
    SUM(CASE WHEN subscription_end IS NULL OR subscription_end > DATE_ADD(CTE_week.start_week, INTERVAL 2 WEEK) THEN 1 ELSE 0 END) AS week_two,
    SUM(CASE WHEN subscription_end IS NULL OR subscription_end > DATE_ADD(CTE_week.start_week, INTERVAL 3 WEEK) THEN 1 ELSE 0 END) AS week_three,
    SUM(CASE WHEN subscription_end IS NULL OR subscription_end > DATE_ADD(CTE_week.start_week, INTERVAL 4 WEEK) THEN 1 ELSE 0 END) AS week_four,
    SUM(CASE WHEN subscription_end IS NULL OR subscription_end > DATE_ADD(CTE_week.start_week, INTERVAL 5 WEEK) THEN 1 ELSE 0 END) AS week_five,
    SUM(CASE WHEN subscription_end IS NULL OR subscription_end > DATE_ADD(CTE_week.start_week, INTERVAL 6 WEEK) THEN 1 ELSE 0 END) AS week_six
  FROM CTE_week
  GROUP BY CTE_week.start_week)

--Query which shows percentages
SELECT start_week,
  ROUND((week_zero / week_zero * 100), 2) AS percentage_week_zero,
  ROUND((week_one / week_zero * 100), 2) AS percentage_week_one,
  ROUND((week_two / week_zero * 100), 2) AS percentage_week_two,
  ROUND((week_three / week_zero * 100), 2) AS percentage_week_three,
  ROUND((week_four / week_zero * 100), 2) AS percentage_week_four,
  ROUND((week_five / week_zero * 100), 2) AS percentage_week_five,
  ROUND((week_six / week_zero * 100), 2) AS percentage_week_six
FROM CTE_subscribers;
```
