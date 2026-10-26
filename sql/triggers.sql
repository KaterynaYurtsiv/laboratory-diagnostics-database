-- MySQL triggers from coursework section 3.6
-- Execute after schema.sql

DELIMITER //
CREATE TRIGGER trg_payment_only_done
BEFORE INSERT ON Payment
FOR EACH ROW
BEGIN
  IF (SELECT Status FROM Analysis WHERE Analysis_ID = NEW.Analysis_ID) <> 'done' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Оплата можлива лише для завершених аналізів (Status = done)';
  END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_no_analysis_change_if_paid
BEFORE UPDATE ON Analysis
FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM Payment WHERE Analysis_ID = OLD.Analysis_ID)
     AND (NEW.Assignment_ID <> OLD.Assignment_ID OR NEW.Referral_ID <> OLD.Referral_ID) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Неможливо змінювати зв’язки аналізу після здійснення оплати';
  END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_result_only_done
BEFORE INSERT ON AnalysisResult
FOR EACH ROW
BEGIN
    IF (SELECT Status FROM Analysis WHERE Analysis_ID = NEW.Analysis_ID) <> 'done' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Результат можна додати лише для завершеного аналізу (status = done)';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_no_delete_paid_analysis
BEFORE DELETE ON Analysis
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Payment WHERE Analysis_ID = OLD.Analysis_ID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Аналіз не можна видалити, оскільки за нього проведено оплату';
    END IF;
END //
DELIMITER ;
