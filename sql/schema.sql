-- Laboratory Diagnostics Database System
-- Database schema extracted from academic coursework (2025)
-- MySQL

CREATE DATABASE IF NOT EXISTS laboratory_diagnostics
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE laboratory_diagnostics;

CREATE TABLE Patient (
Patient_ID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100) NOT NULL COMMENT 'Ім’я пацієнта',
Surname VARCHAR(100) NOT NULL COMMENT 'Прізвище пацієнта',
Patronymic VARCHAR(100) NULL COMMENT 'По батькові пацієнта',
DateOfBirth DATE NOT NULL COMMENT 'Дата народження пацієнта',
Phone VARCHAR(20) NOT NULL UNIQUE COMMENT 'Контактний номер телефону пацієнта',
Email VARCHAR(100) NULL COMMENT 'Електронна адреса пацієнта'
) COMMENT='Інформація про пацієнтів лабораторії';

CREATE TABLE PatientCard (
Card_ID INT AUTO_INCREMENT PRIMARY KEY,
Number VARCHAR(30) NOT NULL UNIQUE COMMENT 'Номер картки пацієнта',
Patient_ID INT NOT NULL COMMENT 'Ідентифікатор пацієнта',
CONSTRAINT fk_card_patient FOREIGN KEY (Patient_ID)
REFERENCES Patient(Patient_ID)
ON DELETE RESTRICT
) COMMENT='Картка належить одному пацієнту';

CREATE TABLE Doctor (
Doctor_ID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100) NOT NULL COMMENT 'Ім’я лікаря',
Surname VARCHAR(100) NOT NULL COMMENT 'Прізвище лікаря',
Patronymic VARCHAR(100) NULL COMMENT 'По батькові лікаря'
) COMMENT='Лікарі, що створюють направлення';

CREATE TABLE Administrator (
Admin_ID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100) NOT NULL COMMENT 'Ім’я адміністратора',
Surname VARCHAR(100) NOT NULL COMMENT 'Прізвище адміністратора',
Patronymic VARCHAR(100) NULL COMMENT 'По батькові адміністратора'
) COMMENT='Адміністратори реєстратури, які оформлюють направлення';

CREATE TABLE LabAssistant (
LabAssistant_ID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100) NOT NULL COMMENT 'Ім’я лаборанта',
Surname VARCHAR(100) NOT NULL COMMENT 'Прізвище лаборанта',
Patronymic VARCHAR(100) NULL COMMENT 'По батькові лаборанта',
Schedule VARCHAR(100) NOT NULL COMMENT 'Робочий графік лаборанта'
) COMMENT='Інформація про лаборантів лабораторії';

CREATE TABLE Cabinet (
Cabinet_ID INT AUTO_INCREMENT PRIMARY KEY,
Number VARCHAR(10) NOT NULL UNIQUE COMMENT 'Номер кабінету',
Specialization VARCHAR(100) NOT NULL COMMENT 'Спеціалізація кабінету (біохімія, імунологія тощо)'
) COMMENT='Довідник кабінетів лабораторії';

CREATE TABLE Assignment (
    Assignment_ID INT AUTO_INCREMENT PRIMARY KEY,
    LabAssistant_ID INT NOT NULL COMMENT 'Посилання на лаборанта',
    Cabinet_ID INT NOT NULL COMMENT 'Посилання на кабінет',
    Type VARCHAR(30) NOT NULL COMMENT 'Тип ролі лаборанта',

    CONSTRAINT fk_as_lab
        FOREIGN KEY (LabAssistant_ID)
        REFERENCES LabAssistant(LabAssistant_ID)
        ON DELETE RESTRICT,

    CONSTRAINT fk_as_cab
        FOREIGN KEY (Cabinet_ID)
        REFERENCES Cabinet(Cabinet_ID)
        ON DELETE RESTRICT,

    CONSTRAINT uq_as_pair
        UNIQUE (LabAssistant_ID, Cabinet_ID, Type)
) COMMENT='Закріплення лаборанта за кабінетом і типом ролі';

REFERENCES Cabinet(Cabinet_ID)
ON DELETE RESTRICT,
CONSTRAINT uq_as_pair UNIQUE (LabAssistant_ID, Cabinet_ID, Type)
) COMMENT='Закріплення лаборанта за кабінетом і типом ролі';

CREATE TABLE Referral (
Referral_ID INT AUTO_INCREMENT PRIMARY KEY,
Number VARCHAR(30) NOT NULL UNIQUE COMMENT 'Номер направлення',
Date DATETIME NOT NULL COMMENT 'Дата створення направлення',
Doctor_ID INT NOT NULL COMMENT 'Посилання на лікаря',
Admin_ID INT NOT NULL COMMENT 'Посилання на адміністратора',
Card_ID INT NOT NULL COMMENT 'Посилання на картку пацієнта',
CONSTRAINT fk_ref_doc FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
ON DELETE RESTRICT,
CONSTRAINT fk_ref_admin FOREIGN KEY (Admin_ID) REFERENCES Administrator(Admin_ID)
ON DELETE RESTRICT,
CONSTRAINT fk_ref_card FOREIGN KEY (Card_ID) REFERENCES PatientCard(Card_ID)
ON DELETE RESTRICT
) COMMENT='Направлення на аналіз для конкретної картки пацієнта';

CREATE TABLE Analysis (
Analysis_ID INT AUTO_INCREMENT PRIMARY KEY,
Type ENUM('біохімічний','клінічний','імунологічний') NOT NULL COMMENT 'Тип аналізу',
Name VARCHAR(100) NOT NULL COMMENT 'Назва аналізу',
Cost INT UNSIGNED NOT NULL COMMENT 'Вартість аналізу (грн, ціле число)',
Date DATETIME NOT NULL COMMENT 'Дата проведення аналізу',
Status ENUM('in_progress','done') NOT NULL COMMENT 'Статус виконання аналізу',
ExecutionTime INT UNSIGNED NOT NULL COMMENT 'Тривалість виконання (хв)',
Referral_ID INT NOT NULL COMMENT 'Посилання на направлення',
Assignment_ID INT NOT NULL COMMENT 'Посилання на закріплення (Assignment)',
CONSTRAINT fk_an_ref FOREIGN KEY (Referral_ID) REFERENCES Referral(Referral_ID)
ON DELETE RESTRICT,
CONSTRAINT fk_an_as FOREIGN KEY (Assignment_ID) REFERENCES Assignment(Assignment_ID)
ON DELETE RESTRICT
) COMMENT='Проведені аналізи у межах направлення';

CREATE TABLE AnalysisResult (
AnalysisResult_ID INT AUTO_INCREMENT PRIMARY KEY,
Value VARCHAR(40) NOT NULL COMMENT 'Значення результату аналізу',
Unit VARCHAR(20) NOT NULL COMMENT 'Одиниця вимірювання результату',
Analysis_ID INT NOT NULL COMMENT 'Посилання на аналіз, до якого належить результат',
CONSTRAINT fk_res_an FOREIGN KEY (Analysis_ID) REFERENCES Analysis(Analysis_ID)
ON DELETE CASCADE
) COMMENT='Результати для проведених аналізів';

CREATE TABLE Payment (
Payment_ID INT AUTO_INCREMENT PRIMARY KEY,
Amount INT UNSIGNED NOT NULL COMMENT 'Сума оплати (грн, ціле число)',
Date DATETIME NOT NULL COMMENT 'Дата здійснення оплати',
Type ENUM('cash','card','free') NOT NULL COMMENT 'Тип оплати',
Analysis_ID INT NOT NULL UNIQUE COMMENT 'Посилання на аналіз (1:1)',
CONSTRAINT fk_pay_an FOREIGN KEY (Analysis_ID) REFERENCES Analysis(Analysis_ID)
ON DELETE RESTRICT
) COMMENT='Оплата за проведений аналіз';
