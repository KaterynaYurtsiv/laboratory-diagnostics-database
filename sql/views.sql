-- Views from section 3.5 of the original Database Systems coursework.
USE laboratory_diagnostics;

-- Analysis and referral details
CREATE VIEW v_analysis_info AS
SELECT 
    a.Analysis_ID,
    a.Name AS AnalysisName,
    a.Type AS AnalysisType,
    a.Cost,
    a.Date AS AnalysisDate,
    a.Status,
    r.Number AS ReferralNumber,
    r.Date AS ReferralDate,
    r.Card_ID
FROM Analysis a
JOIN Referral r ON a.Referral_ID = r.Referral_ID;

-- Analysis counts grouped by type
CREATE VIEW v_analysis_count_by_type AS
SELECT 
    Type AS AnalysisType,
    COUNT(*) AS TotalAnalysis
FROM Analysis
GROUP BY Type
HAVING COUNT(*) >= 1;   -- фільтрація після групування

-- Referrals including those without analyses
CREATE VIEW v_referral_analysis AS
SELECT
    r.Referral_ID,
    r.Number AS ReferralNumber,
    r.Date AS ReferralDate,
    r.Card_ID,
    d.Name AS DoctorName,
    a.Analysis_ID,
    a.Name AS AnalysisName,
    a.Type AS AnalysisType,
    a.Status AS AnalysisStatus,
    a.Cost
FROM Referral r
LEFT JOIN Analysis a ON r.Referral_ID = a.Referral_ID
LEFT JOIN Doctor d ON r.Doctor_ID = d.Doctor_ID;
