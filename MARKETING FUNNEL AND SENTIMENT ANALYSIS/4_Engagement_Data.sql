select * from engagement_data

-- Clean Engagement Data

-- Finding the uique Content Types
select distinct contenttype from engagement_Data
-- Socialmedia, newsletter, Blog, Video, NEWSLETTER, SOCIALMEDIA,
-- Newsletter, blog, VIDEO, socialmedia, BLOG, video

SELECT engagementid, contentid,
campaignid, productid,
CASE
	WHEN LOWER("contenttype") IN ('socialmedia', 'social media') THEN 'Social Media'
	WHEN LOWER("contenttype") IN ('blog') THEN 'Blog'
	WHEN LOWER("contenttype") IN ('newsletter') THEN ('Newsletter')
	WHEN LOWER("contenttype") IN ('video') THEN ('Video')
	ELSE 'Other'
END AS Content_Type,
split_part(viewsclickscombined, '-', 1) AS views,
split_part(viewsclickscombined, '-', 2) AS clicks,
likes,
TO_CHAR(engagementdate, 'dd-mm-yyyy') AS Engagement_Date
FROM engagement_data

