-- Laboratory Diagnostics Database System
-- Synthetic demonstration data adapted from coursework. No real patient records.
-- Run after sql/schema.sql on an empty database.
USE laboratory_diagnostics;

INSERT INTO Patient (Name, Surname, Patronymic, DateOfBirth, Phone, Email)
VALUES 
('Олександр', 'Тестовий', 'Іванович', '1998-06-14', '+380670000001', 'patient1@example.com'),
('Марина', 'Коваль', 'Ігорівна', '2001-03-22', '+380670000002', 'patient2@example.com'),
('Петро', 'Сидоренко', 'Миколайович', '1987-09-01', '+380670000003', 'patient3@example.com');

INSERT INTO PatientCard (Number, Patient_ID)
VALUES
('PC-001', 1),
('PC-002', 2),
('PC-003', 3);

INSERT INTO Doctor (Name, Surname, Patronymic)
VALUES
('Ірина', 'Павлюк', 'Олександрівна'),
('Олег', 'Шевченко', 'Петрович'),
('Марія', 'Добрянська', 'Ігорівна');

INSERT INTO Administrator (Name, Surname, Patronymic)
VALUES
('Марія', 'Коваленко', 'Степанівна'),
('Ганна', 'Литвин', 'Петрівна'),
('Юлія', 'Гринчук', 'Анатоліївна');

INSERT INTO LabAssistant (Name, Surname, Patronymic, Schedule)
VALUES
('Ігор', 'Мельник', 'Олегович', 'Пн-Пт, 08:00-16:00'),
('Світлана', 'Романюк', 'Василівна', 'Пн-Ср, 10:00-18:00'),
('Тарас', 'Бойко', 'Юрійович', 'Вт-Чт, 09:00-17:00');

INSERT INTO Cabinet (Number, Specialization)
VALUES
('101', 'Біохімія'),
('202', 'Імунологія'),
('303', 'Клінічні дослідження');

INSERT INTO Assignment (LabAssistant_ID, Cabinet_ID, Type)
VALUES
(1, 1, 'основний'),
(2, 2, 'черговий'),
(3, 3, 'основний');

INSERT INTO Referral (Number, Date, Doctor_ID, Admin_ID, Card_ID)
VALUES
('R-001', NOW(), 1, 1, 1),
('R-002', NOW(), 2, 2, 2),
('R-003', NOW(), 3, 3, 3);

INSERT INTO Analysis (Type, Name, Cost, Date, Status, ExecutionTime, Referral_ID, Assignment_ID)
VALUES
('біохімічний', 'Загальний аналіз крові', 450, NOW(), 'in_progress', 30, 1, 1),
('клінічний', 'Аналіз сечі', 200, NOW(), 'in_progress', 20, 2, 2),
('імунологічний', 'Антитіла IgG', 600, NOW(), 'in_progress', 45, 3, 3);

UPDATE Analysis SET Status = 'done' WHERE Analysis_ID IN (1,2,3);

INSERT INTO AnalysisResult (Value, Unit, Analysis_ID)
VALUES
('5.1', 'ммоль/л', 1),
('7.8', 'pH', 2),
('12.4', 'од./мл', 3);

INSERT INTO Payment (Amount, Date, Type, Analysis_ID)
VALUES
(450, NOW(), 'card', 1),
(200, NOW(), 'cash', 2),
(600, NOW(), 'card', 3);

