SELECT * FROM bank_loan_data;

-- Total Loan Applications
SELECT COUNT(id) AS Total_Loan_Applications
FROM bank_loan_data

-- Total Loan Applications - Month-to-Date (MTD)
SELECT COUNT(id) AS MTD_Total_Loan_Applications
FROM bank_loan_data
WHERE MONTH (issue_date) = 12 AND YEAR(issue_date) = 2021;

-- Total Loan Applications - Previous_Month-to-Date (MTD)
SELECT COUNT(id) AS PMTD_Total_Loan_Applications
FROM bank_loan_data
WHERE MONTH (issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Total Loan Applications - Month-over-Month (MoM)
SELECT DATENAME(MONTH, id) AS Month_Name, COUNT(DISTINCT id) AS Applications
FROM bank_loan_data
GROUP BY DATENAME(MONTH, id)
ORDER BY Month_Name 

-- Total Funded Amount - Month-over-Month (MoM)
SELECT DATENAME(MONTH, loan_amount) AS Month_Name, COUNT(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
GROUP BY DATENAME(MONTH, loan_amount)
ORDER BY Month_Name DESC;

-- Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data

-- Total Amount Received - Current Month-to-Date (MTD)
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = '2021'

-- Total Amount Received -  Month-over-Month (MoM)
SELECT DATENAME(MONTH, total_payment) AS Month_Name, COUNT(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY DATENAME(MONTH, total_payment)
ORDER BY Month_Name DESC;

-- Average Interest Rate
SELECT ROUND(AVG(int_rate), 4) * 100 AS Average_Interest_Rate FROM bank_loan_data;

-- Average Interest Rate - Month on Month (MOM)
SELECT DATENAME(MONTH, AVG(int_rate) * 100) AS Month_Name, COUNT(int_rate) AS Average_Interest_Rate 
FROM bank_loan_data
GROUP BY DATENAME(MONTH, int_rate)
ORDER BY Month_Name DESC

SELECT 
    DATENAME(MONTH, int_rate) AS Month_Name,
    YEAR(int_rate) AS Year,
    AVG(int_rate * 100) AS Average_Interest_Rate 
FROM 
    bank_loan_data
GROUP BY 
    DATENAME(MONTH, int_rate), YEAR(int_rate)
ORDER BY 
    Year, DATENAME(MONTH, int_rate);



-- Average Interest Rate - Month to Date(MTD)
SELECT ROUND(AVG(int_rate), 4) * 100 AS Average_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Average Debt-to-Income Ratio
SELECT ROUND(AVG(dti), 4) * 100 AS Average_DTI FROM bank_loan_data

-- Good Loan Application Percentage
SELECT
	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)* 100)
	/ COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data

-- Good Loan Application
SELECT COUNT(id) AS Good_Loan_Application FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Funded Amount 
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Total Received Amount
SELECT SUM(total_payment) AS Good_Loan_Total_Amount_Received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'\

-- Bad Loan Application Percentage
SELECT 
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) *100)
	/ COUNT(id) AS Bad_Loan_Percentage FROM bank_loan_data;

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Application FROM bank_loan_data
WHERE loan_status = 'Charged off';

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded FROM bank_loan_data
WHERE loan_status = 'Charged Off'

-- Bad Loan Total Received Amount
SELECT SUM(total_payment) AS Bad_Loan_Total_Received_Amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'

-- Loan Status Grid View
SELECT
	loan_status,
	COUNT(id) AS Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	ROUND(AVG(int_rate * 100), 2) AS Interest_Rate,
	ROUND(Avg(dti * 100), 2) AS DTI
	FROM bank_loan_data
	GROUP BY loan_status;

SELECT
	loan_status,
	SUM(total_payment) AS MTD_Total_Amount_Received,
	SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;

-- DASHBOARD 2: OVERVIEW

-- Monthly Trends by Issue Date
SELECT
	MONTH(issue_date) AS Month_Number,
	DATENAME(MONTH, issue_date) AS Month_Name,
	COUNT(id) AS Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);

-- Regional Analysis by State 
SELECT
	address_state,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC;

--  Loan Term Analysis
SELECT
	term AS Loan_Term,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- Employee Length Analysis
SELECT
	emp_length AS Employee_Length,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length DESC;


-- Loan Purpose Breakdown
SELECT
	purpose AS Loan_Purpose,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC;


-- Home Ownership Analysis
SELECT
	home_ownership AS Home_Ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;