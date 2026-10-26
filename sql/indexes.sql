-- Laboratory Diagnostics Database
-- Indexes and query plan example from coursework, section 3.7.
-- Run after schema.sql. Do not rerun CREATE INDEX on the same database without dropping existing indexes.

CREATE INDEX idx_analysis_cost ON Analysis(Cost);
CREATE INDEX idx_analysis_type ON Analysis(Type);
CREATE INDEX idx_patient_surname ON Patient(Surname);
CREATE INDEX idx_analysis_referral ON Analysis(Referral_ID);
CREATE INDEX idx_referral_card ON Referral(Card_ID);
CREATE INDEX idx_pc_patient ON PatientCard(Patient_ID);

-- Original coursework example: inspect execution plan for a multi-table JOIN.
-- The surname filter is retained from the original coursework and may return no rows
-- if the sample dataset contains no surnames beginning with this letter.
EXPLAIN SELECT
    a.Analysis_ID,
    a.Name AS AnalysisName,
    a.Cost,
    a.Type,
    r.Number AS ReferralNumber,
    r.Date AS ReferralDate,
    p.Surname AS PatientSurname
FROM Analysis a
JOIN Referral r ON a.Referral_ID = r.Referral_ID
JOIN PatientCard pc ON r.Card_ID = pc.Card_ID
JOIN Patient p ON pc.Patient_ID = p.Patient_ID
WHERE a.Cost > 300
  AND p.Surname LIKE 'Ю%';
