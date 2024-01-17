--доповнення бази даних Specializations, DoctorsSpecializations, Vacations, Donations

CREATE TABLE Specializations(
   id SERIAL PRIMARY KEY,
   name VARCHAR(100) NOT NULL UNIQUE
);
-- Add records to Specializations table
INSERT INTO Specializations (name) VALUES
    ('Cardiologist'),
    ('Pediatrician'),
    ('Orthopedic Surgeon'),
    ('Oncologist'),
    ('Neurologist');
--таблиця, що зв'язує лікарів з їх спеціалізаціями
CREATE TABLE DoctorsSpecializations(
    doctor_id INT,
    specialization_id INT,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors (id),
    FOREIGN KEY (specialization_id) REFERENCES Specializations(id)
);
-- Add some records to DoctorsSpecializations table
INSERT INTO DoctorsSpecializations (doctor_id, specialization_id) VALUES
    (1, 1), -- Dr. John is a Cardiologist
    (2, 2), -- Dr. Emily is a Pediatrician
    (3, 3), -- Dr. Michael is an Orthopedic Surgeon
    (4, 4), -- Dr. Sarah is an Oncologist
    (5, 5), -- Dr. David is a Neurologist
    (1, 3), -- Dr. John is also an Orthopedic Surgeon
    (2, 4), -- Dr. Emily is also an Oncologist
    (3, 1), -- Dr. Michael is also a Cardiologist
    (4, 2), -- Dr. Sarah is also a Pediatrician
    (5, 3); -- Dr. David is also an Orthopedic Surgeon

--відпустки
CREATE TABLE Vacations(
    id SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    doctor_id INT NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES Doctors (id)
);
--індекс для поліпшення швидкості запитів на діапазон дат відпусток
CREATE INDEX idx_vacations_date_range ON Vacations(start_date, end_date);
 -- Add records to Vacations table
INSERT INTO Vacations (start_date, end_date, doctor_id) VALUES
    ('2024-06-01', '2024-06-07', 1), -- Dr. John's vacation
    ('2024-07-15', '2024-07-21', 2), -- Dr. Emily's vacation
    ('2024-08-10', '2024-08-16', 3), -- Dr. Michael's vacation
    ('2024-09-05', '2024-09-11', 4), -- Dr. Sarah's vacation
    ('2024-10-20', '2024-10-26', 5); -- Dr. David's vacation

--спонсори
CREATE TABLE Sponsors(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    --amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
    information TEXT
);
-- Add records to Sponsors table
INSERT INTO Sponsors (name, information) VALUES
    ('XYZ Corporation', 'Sponsorship for medical equipment'),
    ('ABC Foundation', 'Support for research projects'),
    ('HealthTech Ltd', 'Funding for technology upgrades'),
    ('Wellness Group', 'Community health programs'),
    ('Caring Hearts',  'Charitable contribution for patient care');

--Donations

CREATE TABLE Donations(
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL CHECK (date <= CURRENT_DATE),
    amount DECIMAL(10,2) NOT NULL CHECK(amount > 0),
    Department_Id INT NOT NULL REFERENCES Departments(id),
    Sponsor_Id INT NOT NULL REFERENCES Sponsors(id)
);
-- Add records to Donations table
-- Додайте записи до таблиці Donations
INSERT INTO Donations (date, amount, Department_Id, Sponsor_Id) VALUES
    ('2022-12-01', 5000.00, 1, 1), -- Пожертва в кардіологію від XYZ Corporation
    ('2022-06-20', 8000.50, 2, 2), -- Пожертва в педіатрію від ABC Foundation
    ('2022-07-10', 12000.00, 3, 3), -- Пожертва в хірургію від HealthTech Ltd
    ('2022-08-05', 6000.75, 4, 4) -- Пожертва в онкологію від Wellness Group