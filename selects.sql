
// Смотрим сколько пациентов было у врачей на приеме после 1 мая 2022
select (select name from doctor d2 where d2.id = a.doctor_id), count(a.patient_id)
from (appointment a left join doctor d on a.doctor_id = d.id) left join patient p on a.patient_id = p.id
group by a.doctor_id, a.patient_id, a.date
having a.date > '2022-05-01';

// Имена пациентов, кто хоть раз сдавал анализ на витамин D в лексикографическом порядке
select distinct p.name
from patient p left join analysis a on a.patient_id = p.id
where a."type" = 'Определение витамина D'
order by p.name;

// Количество анализов, которые сдал пациент
select distinct p.name, count(a.id) over (partition by p.id) as a_count
from patient p full join analysis a on p.id = a.patient_id 
order by a_count desc;

// Какие рекомендации в данный момент актуальны для пациентов
select p.name, p2.recommendations 
from (patient p full join appointment a on p.id = a.patient_id) full join prescription p2 on a.prescription_id = p2.id
where p2.valid_to is null;

// Последний прием для каждого пациента
SELECT p.name, MAX(a.date) OVER(PARTITION BY p.id) AS last_appointment_date
FROM Patient p
INNER JOIN Appointment a ON p.id = a.patient_id
ORDER BY last_appointment_date ASC;

// топ-5 самых старых пациентов с их возрастом
select  rank() over(order by birthdate), name, EXTRACT(YEAR FROM AGE(CURRENT_DATE, birthdate)) as age
from patient
limit 5;



