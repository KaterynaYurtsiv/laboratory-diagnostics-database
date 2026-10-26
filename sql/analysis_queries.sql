-- Laboratory Diagnostics Database System
-- Additional portfolio extension: exploratory SQL analysis (MySQL 8+)
-- Run after schema.sql and sample_data.sql.
-- Uses synthetic demonstration data, not real patient records.
USE laboratory_diagnostics;

-- 1. Overall activity and payments (one payment per analysis in this schema).
SELECT
    COUNT(*) AS total_analyses,
    SUM(a.Status = 'done') AS completed_analyses,
    SUM(a.Status = 'in_progress') AS in_progress_analyses,
    COUNT(p.Payment_ID) AS paid_analyses,
    COALESCE(SUM(p.Amount), 0) AS total_payments_uah
FROM Analysis AS a
LEFT JOIN Payment AS p ON p.Analysis_ID = a.Analysis_ID;

-- 2. Most requested test names.
SELECT a.Name AS test_name, COUNT(*) AS test_count
FROM Analysis AS a
GROUP BY a.Name
ORDER BY test_count DESC, test_name;

-- 3. Completed tests and payments by test type.
SELECT
    a.Type AS test_type,
    COUNT(*) AS total_tests,
    SUM(a.Status = 'done') AS completed_tests,
    COALESCE(SUM(p.Amount), 0) AS payments_uah
FROM Analysis AS a
LEFT JOIN Payment AS p ON p.Analysis_ID = a.Analysis_ID
GROUP BY a.Type
ORDER BY payments_uah DESC;

-- 4. Monthly test volume based on Analysis.Date.
SELECT
    DATE_FORMAT(a.Date, '%Y-%m') AS test_month,
    COUNT(*) AS total_tests,
    SUM(a.Status = 'done') AS completed_tests
FROM Analysis AS a
GROUP BY DATE_FORMAT(a.Date, '%Y-%m')
ORDER BY test_month;

-- 5. Monthly payments based on Payment.Date (not test date).
SELECT
    DATE_FORMAT(p.Date, '%Y-%m') AS payment_month,
    COUNT(*) AS payment_count,
    SUM(p.Amount) AS payments_uah,
    ROUND(AVG(p.Amount), 2) AS average_payment_uah
FROM Payment AS p
GROUP BY DATE_FORMAT(p.Date, '%Y-%m')
ORDER BY payment_month;

-- 6. Average listed price and average execution time by test type.
SELECT
    a.Type AS test_type,
    COUNT(*) AS test_count,
    ROUND(AVG(a.Cost), 2) AS average_listed_price_uah,
    ROUND(AVG(a.ExecutionTime), 2) AS average_execution_minutes
FROM Analysis AS a
GROUP BY a.Type
ORDER BY test_count DESC;

-- 7. Number of referrals and related tests for each doctor.
SELECT
    d.Doctor_ID,
    CONCAT(d.Name, ' ', d.Surname) AS doctor_name,
    COUNT(DISTINCT r.Referral_ID) AS referral_count,
    COUNT(a.Analysis_ID) AS test_count
FROM Doctor AS d
LEFT JOIN Referral AS r ON r.Doctor_ID = d.Doctor_ID
LEFT JOIN Analysis AS a ON a.Referral_ID = r.Referral_ID
GROUP BY d.Doctor_ID, d.Name, d.Surname
ORDER BY test_count DESC, referral_count DESC;
