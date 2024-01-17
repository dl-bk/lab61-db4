SELECT Doctors.name || ' ' || Doctors.surname AS DoctorName, string_agg(Specializations.name, ', ') AS Specialization
FROM Doctors
JOIN doctorsspecializations ON Doctors.id = doctorsspecializations.doctor_id
JOIN Specializations ON doctorsspecializations.specialization_id = Specializations.id
GROUP BY Doctors.Id
