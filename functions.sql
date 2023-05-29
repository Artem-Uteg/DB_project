create or replace function get_patients_without_recent_analysis()
returns table (
	patient_id int,
	name varchar(50),
	last_analysis_date date
) as $$
	begin
		return query
		select p.id as patient_id,
			   p.name,
			   max(a.date) as last_analysis_date
		from patient p left join analysis a on p.id = a.patient_id
		group by p.id
		having max(a.date) < current_date - interval '1 month';
	end;
$$ language plpgsql;


create or replace function get_patient_appointments(pat_id int) 
returns table (
    appointment_id int,
    doctor_name varchar(50),
    prescription_cond_descr varchar(200),
    prescription_diagnosis varchar(50),
    prescription_descr varchar(500),
    appointment_date date
) as $$
begin
    return query 
    select appointment.id as appointment_id,
    	   doctor.name as doctor_name,
		   prescription.cond_descr,
		   prescription.diagnosis,
           prescription.recommendations as prescription_descr, 
           appointment.date as appointment_date
    from appointment join doctor on appointment.doctor_id = doctor.id
    				 join prescription on appointment.prescription_id = prescription.id
    where appointment.patient_id = pat_id;
end; $$
language plpgsql;
 