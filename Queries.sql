use powerbi;

CREATE TABLE applestore (
    id INT PRIMARY KEY,
    track_name VARCHAR(255),
    size_bytes BIGINT,
    currency VARCHAR(10),
    price DECIMAL(10, 2),
    rating_count_tot INT,
    rating_count_ver INT,
    user_rating DECIMAL(2, 1),
    user_rating_ver DECIMAL(2, 1),
    ver VARCHAR(20),
    cont_rating VARCHAR(10),
    prime_genre VARCHAR(50),
    sup_devices_num INT,
    ipadSc_urls_num INT,
    lang_num INT,
    vpp_lic TINYINT
);

-- Top-rated Apps by Category
SELECT prime_genre AS Category, 
       track_name AS AppName,
       user_rating AS UserRating
FROM applestore
WHERE (prime_genre, user_rating) IN (
    SELECT prime_genre, MAX(user_rating) 
    FROM applestore
    GROUP BY prime_genre
)
ORDER BY prime_genre, user_rating DESC;

-- App Distribution by Content Rating
SELECT cont_rating AS ContentRating, COUNT(*) AS AppCount
FROM applestore
GROUP BY cont_rating;

-- Price Distribution of Apps Rating 
SELECT user_rating AS UserRating,
       MIN(price) AS MinPrice,
       MAX(price) AS MaxPrice,
       AVG(price) AS AvgPrice
FROM applestore
GROUP BY user_rating;

-- Number of Apps per Genre Rating
SELECT prime_genre AS Genre,
       COUNT(*) AS NumberOfApps
FROM applestore
GROUP BY prime_genre; 

-- App Size vs. User Rating
SELECT size_bytes AS AppSize,
       user_rating AS UserRating
FROM applestore;

-- App Rating over Time (Version) 
SELECT ver AS AppVersion,
       user_rating AS UserRating
FROM applestore
ORDER BY ver, user_rating DESC;

-- Average Rating by Category
SELECT prime_genre AS Category,
       AVG(user_rating) AS AverageRating
FROM applestore
GROUP BY prime_genre;

-- App Popularity vs. Price
SELECT rating_count_tot AS Popularity,
       price AS Price
FROM applestore;

-- Language Support for Apps: 
SELECT lang_num AS LanguageSupport,
       COUNT(*) AS NumberOfApps
FROM applestore
GROUP BY lang_num;

-- App Size Distribution by Genre:
SELECT prime_genre AS Genre,
       MIN(size_bytes) AS MinSize,
       MAX(size_bytes) AS MaxSize,
       AVG(size_bytes) AS AvgSize
FROM applestore
GROUP BY prime_genre;

Select * from applestore;
ALTER DATABASE powerbi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

ALTER TABLE your_table_name MODIFY column_name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Top 10 Largest Apps by Size
SELECT track_name AS AppName,size_bytes AS AppSizeBytes
FROM applestore
ORDER BY size_bytes DESC
LIMIT 10;

-- Average User Rating by Content Rating
SELECT cont_rating AS ContentRating ,avg(user_rating) AS AvgUserRating
FROM applestore
GROUP BY cont_rating;

-- Most Popular Genres by Number of Downloads
SELECT prime_genre AS Genre , sum(rating_count_tot) AS TotalDownloads
FROM applestore
GROUP BY prime_genre
ORDER BY TotalDownloads DESC;

-- User Ratings vs. Version
SELECT ver AS AppVersion, AVG(user_rating) AS AvgUserRating
FROM applestore
GROUP BY ver;

-- Language Support for Apps 
SELECT lang_num AS LanguageSupport, COUNT(*) AS AppCount
FROM applestore
GROUP BY lang_num;

-- Percentage of Free vs. Paid Apps
SELECT IF(price = 0, 'Free', 'Paid') AS AppType, COUNT(*) AS AppCount,
       COUNT(*) * 100 / (SELECT COUNT(*) FROM applestore) AS Percentage
FROM applestore
GROUP BY AppType;

-- App Distribution by Device Compatibility 
SELECT sup_devices_num AS DeviceCompatibility, COUNT(*) AS AppCount
FROM applestore
GROUP BY sup_devices_num;

-- Ratings Distribution by Category
SELECT prime_genre AS Category, user_rating AS UserRating, COUNT(*) AS RatingCount
FROM applestore
GROUP BY prime_genre, user_rating
ORDER BY prime_genre, user_rating;

-- Number of Apps with In-App Purchases
SELECT COUNT(*) AS AppsCountWithInAppPurchases
FROM applestore
WHERE vpp_lic = 1;

-- Popularity of iPad and iPhone Apps
SELECT CASE 
           WHEN sup_devices_num = 1 THEN 'iPhone'
           WHEN sup_devices_num > 1 THEN 'iPad'
           ELSE 'Other'
       END AS DeviceType,
       COUNT(*) AS AppCount
FROM applestore
GROUP BY DeviceType;

-- Trend of App Sizes over Time
SELECT ver AS AppVersion, AVG(size_bytes) AS AvgAppSizeBytes
FROM applestore
GROUP BY ver
ORDER BY ver;










