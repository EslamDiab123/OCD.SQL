-- Main SELECT statement to retrieve all columns from the dataset
SELECT 
    [Patient_ID],
    [Age],
    [Gender],
    [Ethnicity],
    [Marital_Status],
    [Education_Level],
    [OCD_Diagnosis_Date],
    [Duration_of_Symptoms_months],
    [Previous_Diagnoses],
    [Family_History_of_OCD],
    [Obsession_Type],
    [Compulsion_Type],
    [Y_BOCS_Score_Obsessions],
    [Y_BOCS_Score_Compulsions],
    [Depression_Diagnosis],
    [Anxiety_Diagnosis],
    [Medications]
FROM [OCD].[dbo].[ocd_patient_dataset];

WITH data AS (
    SELECT
        [Gender],
        COUNT([Patient_ID]) AS [patient_count],
        ROUND(AVG([Y_BOCS_Score_Obsessions]), 2) AS [avg_obs_score]
    FROM [OCD].[dbo].[ocd_patient_dataset]
    GROUP BY [Gender]
)
SELECT
    SUM(CASE WHEN [Gender] = 'Female' THEN [patient_count] ELSE 0 END) AS [count_female],
    SUM(CASE WHEN [Gender] = 'Male' THEN [patient_count] ELSE 0 END) AS [count_male],
    ROUND(SUM(CASE WHEN [Gender] = 'Female' THEN [patient_count] ELSE 0 END) /
        (SUM(CASE WHEN [Gender] = 'Female' THEN [patient_count] ELSE 0 END) + SUM(CASE WHEN [Gender] = 'Male' THEN [patient_count] ELSE 0 END)) * 100, 2) AS [pct_female],
    ROUND(SUM(CASE WHEN [Gender] = 'Male' THEN [patient_count] ELSE 0 END) /
        (SUM(CASE WHEN [Gender] = 'Female' THEN [patient_count] ELSE 0 END) + SUM(CASE WHEN [Gender] = 'Male' THEN [patient_count] ELSE 0 END)) * 100, 2) AS [pct_male]
FROM data;

-- that calculates the count of patients and the average Y-BOCS Score (Obsessions) for each gender.
SELECT
    [Ethnicity],
    COUNT([Patient_ID]) AS [patient_count],
    ROUND(AVG([Y_BOCS_Score_Obsessions]), 2) AS [obs_score]
FROM [OCD].[dbo].[ocd_patient_dataset]
GROUP BY [Ethnicity]
ORDER BY [patient_count];

--This query groups the data by Ethnicity, counts the number of patients for each ethnicity, and calculates the average Y-BOCS Score (Obsessions). The results are ordered by the patient count.



SELECT
    FORMAT([OCD_Diagnosis_Date], 'yyyy-MM-01 00:00:00') AS [month],
    COUNT([Patient_ID]) AS [patient_count]
FROM [OCD].[dbo].[ocd_patient_dataset]
GROUP BY FORMAT([OCD_Diagnosis_Date], 'yyyy-MM-01 00:00:00')
ORDER BY [month];
-- This query is counts the number of patients diagnosed in each month. 

SELECT
    [Obsession_Type],
    COUNT([Patient_ID]) AS [patient_count],
    ROUND(AVG([Y_BOCS_Score_Obsessions]), 2) AS [obs_score]
FROM [OCD].[dbo].[ocd_patient_dataset]
GROUP BY [Obsession_Type]
ORDER BY [patient_count] DESC;

-- This query counts the number of patients for each obsession type and calculates the average Y-BOCS Score (Obsessions) for each type
SELECT
    [Compulsion_Type],
    COUNT([Patient_ID]) AS [patient_count],
    ROUND(AVG([Y_BOCS_Score_Obsessions]), 2) AS [obs_score]
FROM [OCD].[dbo].[ocd_patient_dataset]
GROUP BY [Compulsion_Type]
ORDER BY [patient_count] DESC;
-- this query counts the number of patients for each compulsion type and calculates the average Y-BOCS Score (Obsessions) for each type. The results are ordered by patient count in descending order to find the most common compulsion type.
-- Each query provides specific insights into the patient dataset, such as gender distribution, ethnicity statistics, diagnosis trends over time, and common types of obsessions and compulsions.
