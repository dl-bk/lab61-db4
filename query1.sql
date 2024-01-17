SELECT W.name AS WardName
From Wards W
JOIN Departments D ON W.Building = D.Building
WHERE D.Name = 'Oncology'