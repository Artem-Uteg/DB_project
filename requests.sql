UPDATE appointment 
SET "time" = '12:00'
WHERE "date" = '2022-12-30';

INSERT INTO Patient(name, birthdate, address, phone_number, doc_number)
VALUES	('Трофимов Мирон Данилович', '2001-03-30', 'ул. Остоженка, 1/9', '+7 995 637-10-82', '5555 8536 1456 9643');

DELETE FROM patient 
WHERE birthdate = '2001-03-30';

SELECT name
FROM doctor
WHERE schedule LIKE '%Вт выходной%';

UPDATE analysis  
SET "date" = '2019-11-17'
WHERE patient_id = 9;

UPDATE doctor 
SET is_working = FALSE
WHERE "name" = 'Кузнецова Алина Даниэльевна';

SELECT name
FROM doctor
WHERE is_working = TRUE;

INSERT INTO Analysis(patient_id, type, result, date)
VALUES	(1,	'Определение витамина D', '77 нмоль/л', '2022-05-21');

DELETE FROM analysis  
WHERE "type" = 'Определение липазы';

SELECT date
FROM appointment
WHERE doctor_id = 8;
