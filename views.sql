CREATE VIEW patient_list AS
SELECT name, birthdate, phone_number, concat('**** **** **** ', right(doc_number, 4)) as hidden_doc_num
FROM patient;


CREATE VIEW actual_doctor_list AS
SELECT name, specialization, phone, schedule
FROM doctor
where is_working is true;

create view appointment_info as
select d.name as doctor_name,
	   p.name as patien_name,
	   a.date, a.time,
	   p2.cond_descr, 
	   p2.diagnosis,
	   p2.recommendations 
from appointment a left join doctor d on a.doctor_id = d.id
				   left join patient p on a.patient_id = p.id
				   left join prescription p2 on a.prescription_id = p2.id
where p2.valid_to is null;
				  
create view patient_analysis as
select p."name", p.phone_number, a."type", a."result", a."date" 
from patient p right join analysis a on a.patient_id = p.id;

create view current_doctor_patient_links as
select distinct d."name" as doctor_name, d.specialization, p."name" as patient_name
from doctor d full join appointment a on d.id = a.doctor_id 
			  left join patient p on a.patient_id = p.id

CREATE VIEW appointment_count AS
SELECT d.name AS doctor_name, COUNT(*) AS appointment_count
FROM appointment a
INNER JOIN doctor d ON a.doctor_id = d.id
GROUP BY d.name;
