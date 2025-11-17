Create database my_project;
-- Demographic Insights (examples) 
-- a. Who prefers energy drink more?  (male/female/non-binary?) 
select dr.gender,
COUNT(*) as preference_count
from dim_repondents dr
join fact_survey_responses fs 
on dr.respondent_id = fs.respondent_id
group by dr.gender
order by preference_count DESC;
-- b. Which age group prefers energy drinks more? 
use my_project;
select dr.age
from dim_repondents as dr join fact_survey_responses as fs
order by dr.age desc;

-- c. Which type of marketing reaches the most Youth (15-30)?
select fs.marketing_channels,
COUNT(*) as youth_count
from dim_repondents dr
inner join fact_survey_responses fs 
on dr.respondent_id = fs.respondent_id
where dr.age between 15 and 30
group by fs.marketing_channels
order by youth_count desc
limit 1;

-- Consumer Preferences: 
-- a.What are the preferred ingredients of energy drinks among respondents? 
select ingredients_expected,
count(*) as Ingredients_pref
from fact_survey_responses group by ingredients_expected order by ingredients_pref desc;

-- b. What packaging preferences do respondents have for energy drinks? 
select packaging_preference,
count(*) as by_respondents
from fact_survey_responses group by packaging_preference order by by_respondents desc;

-- 3. Competition Analysis:
-- a. Who are the current market leaders?
select current_brands,
count(*) as total_users from fact_survey_responses group by current_brands order by total_users;

-- b. What are the primary reasons consumers prefer those brands over ours? 
select current_brands, reasons_for_choosing_brands,
count(*) as primary_reasons from fact_survey_responses
group by current_brands,reasons_for_choosing_brands;

-- 4. Marketing Channels and Brand Awareness: 
-- a. Which marketing channel can be used to reach more customers?
select marketing_channels,
count(*) as total_reach
from fact_survey_responses group by marketing_channels order by total_reach desc limit 1;

-- b. How effective are different marketing strategies and channels in reaching our customers?
select marketing_channels,
COUNT(*) as total_reach,
SUM(case when heard_before = 'Yes' then 1 else 0 end) as awareness_reach,
SUM(case when tried_before = 'Yes' then 1 else 0 end) as trial_reach,
SUM(case when consume_frequency IN ('Daily','Weekly') THEN 1 ELSE 0 end) as engaged_consumers,
SUM(case when brand_perception = 'Positive' then 1 else 0 end) as positive_perception
from fact_survey_responses
group by marketing_channels
order by total_reach desc;

-- Brand Penetration: 
-- a. What do people think about our brand? (overall rating) 
select brand_perception,
count(*) as total_responses 
from fact_survey_responses
group by brand_perception
order by total_responses desc;

-- b. Which cities do we need to focus more on? 
select city,dc.city_id,
COUNT(*) as total_customers
from dim_cities as dc
inner join dim_repondents as dr 
ON dc.city_id = dr.city_id
GROUP BY city,dc.city_id
ORDER BY total_customers;

-- 6. Purchase Behavior: 
-- a. Where do respondents prefer to purchase energy drinks? 
select purchase_location,
count(*) as resp_purchase
from fact_survey_responses
group by purchase_location
order by resp_purchase desc limit 1;

-- b. What are the typical consumption situations for energy drinks among respondents?
select typical_consumption_situations,
count(*) as count_among_respondents
from fact_survey_responses
group by typical_consumption_situations
order by count_among_respondents;

-- c. What factors influence respondents' purchase decisions, such as price range and limited edition packaging? 
select price_range, limited_edition_packaging,
COUNT(*) as total_responses
from fact_survey_responses
group by price_range, limited_edition_packaging
order by total_responses desc;

-- 7. Product Development 
-- a. Which area of business should we focus more on our product development? (Branding/taste/availability) 
select improvements_desired,
COUNT(*) as response_count
from fact_survey_responses
group by improvements_desired
order by response_count desc;



