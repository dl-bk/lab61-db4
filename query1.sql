-- Add a relationship between wards and departments

ALTER TABLE Wards
ADD COLUMN Department_Id INT REFERENCES Departments(Id);

-- Add bonus to doctors

ALTER TABLE Doctors
ADD COLUMN Bonus DECIMAL(10, 2) NOT NULL DEFAULT 0 CHECK (Bonus >= 0);