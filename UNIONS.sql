-- Databricks notebook source
-- Combine the account holders from both branches into one unique list. Each person should appear only once, even if they hold accounts at both branches.
SELECT account_id, account_holder, 'Sandton' AS city
FROM database.default.branch_sandton_accounts
UNION
SELECT account_id, account_holder, 'Rosebank' AS city
FROM database.default.branch_rosebank_accounts; 

SELECT 


--NexBank offers two product lists — one for savings accounts and one for current accounts. Build a unique product catalogue that shows every product the bank offers, without repeating any product that appears in both lists.

SELECT product_code, product_name, 'Savings' AS product_type
FROM database.default.savings_products
UNION
SELECT product_code, product_name, 'Current' AS product_type
FROM database.default.current_products; 

-- The HR team needs a unique list of all staff who work in either Retail Banking or Corporate Banking. Some staff are assigned to both. Each staff member should appear only once.

SELECT staff_id, staff_name, 'retail@nexbank.co.za' AS email
FROM database.default.retail_banking_staff
UNION
SELECT staff_id, staff_name, 'corporate@nexbank.co.za' AS email
FROM database.default.corporate_banking_staff;

--Marketing needs a unique list of all cities where NexBank serves customers — either through its mobile branches or its digital branch (which serves customers online regardless of city). No city should appear twice.

SELECT city_code, city_name, 'Mobile' AS region
FROM database.default.mobile_branch_cities
UNION
SELECT city_code, city_name, 'Digital' AS region
FROM database.default.digital_branch_cities; 

--The digital marketing team ran two campaigns last month — one via push notification and one via in-app banner. Build a unique list of every customer who was targeted. If a customer received both, they must appear only once.

SELECT  customer_id, customer_name, 'Push Notification' AS segment
FROM database.default.push_notification_targets
UNION
SELECT customer_id, customer_name, 'IN-App Banner'
FROM database.default.inapp_banner_targets;

--The fraud team needs the complete log of all ATM transactions from machine ATM-01 and machine ATM-02. Every transaction must appear — even if the same transaction appears in both logs due to a system sync error

SELECT txn_id, account_id, amount
FROM database.default.atm_01_transactions
UNION ALL
SELECT txn_id, account_id, amount
FROM database.default.atm_02_transactions; 


--The credit team wants a full list of all loan applications received from the Gauteng region and the Western Cape region. Every application must be included — duplicates are allowed because both regions may have captured the same application.

SELECT app_id, customer_id
FROM database.default.gauteng_loan_application
UNION ALL
SELECT app_id, customer_id
FROM database.default.western_cape_loan_applications;


-- The customer experience team needs a full record of every complaint logged this month, whether it came via email or via the mobile app. Every complaint must appear the team needs all of them to calculate total complaint volumes 

SELECT complaint_id, customer_id, 'Email' AS category
FROM database.default.email_complaints
UNION ALL
SELECT complaint_id, customer_id, 'App' AS category
FROM database.default.app_complaints;
 
--The accounting system records debits and credits in two separate tables. Combine all entries into one general ledger for the audit. Every single entry from both tables must appear — no rows should be dropped


SELECT entry_id, account_id, entry_type
FROM database.default.debit_entries
UNION ALL 
SELECT entry_id, account_id, entry_type
FROM database.default.credit_entries;


------------------------------------------------------------------------

--BONUS QUESTION 1
-- UNION: removues duplicates, since the fraud analyst wants a unique list 

--BONUS QUESTION 2
--UNION ALL: keeps all rows without removing duplicates, giving the correct total transaction count

-- BONUS QUESTION 3
--The first SELECT returns 2 columns (account_id, account_holder) but the second SELECT returns 3 columns (account_id, account_holder, city). UNION requires both SELECT statements to have the same number of columns — this mismatch causes an error.

--FIX: SELECT account_id, account_holder, 'Sandton' AS city
--      FROM branch_sandton_accounts
--      UNION
--      SELECT account_id, account_holder, city
--      FROM branch_rosebank_accounts;
