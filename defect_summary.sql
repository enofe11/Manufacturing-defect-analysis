SELECT *
FROM defects.defects_data;

-- Changing Defect date column to right sql date format YYYY-MM-DD and the right data type
SELECT defect_date,
STR_TO_DATE(defect_date, '%m/%d/%Y')
FROM defects_data;

UPDATE defects_data
SET defect_date = STR_TO_DATE(defect_date, '%m/%d/%Y');

ALTER TABLE defects_data 
MODIFY COLUMN defect_date DATE;

-- EDA
-- 1.Total defects Cost
SELECT SUM(repair_cost) AS total_repair_cost
FROM defects_data;

-- 2. Average Repair cost
SELECT AVG(repair_cost) AS average_repair_cost
FROM defects_data;

-- 3. Highest cost by defect type 
SELECT defect_type,
	COUNT(*) AS total_defects,
	SUM(repair_cost) AS total_cost
FROM defects_data
GROUP BY defect_type
ORDER BY total_cost DESC;

-- 4. Monthly Trends 
Select DATE_FORMAT(defect_date, '%Y/%m') AS `months`,
	COUNT(*) AS total_defects,
	SUM(repair_cost) AS total_cost
FROM defects_data
GROUP BY `months`
ORDER BY `months`;

-- 5. Defect Hotspot by location
SELECT defect_location,
	COUNT(*) AS total_defects,
	SUM(repair_cost) AS total_cost
FROM defects_data
GROUP BY defect_location
ORDER BY total_cost DESC;

-- 6. Severity Vs Cost
SELECT severity, 
	AVG(repair_cost)  AS  average_repair_cost,
    COUNT(*) AS defect_count
FROM defects_data
GROUP BY severity
ORDER BY average_repair_cost DESC;

