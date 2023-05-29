create or replace function check_doctor_schedule() returns trigger as $$
begin
    if not exists (
        select id from doctor 
        where id = new.doctor_id and is_working = true 
              and new.time between substring(schedule from '^\d{2}:\d{2}')::time
              and substring(schedule from '\d{2}:\d{2}$')::time
    ) then
        raise exception 'doctor is not working at the specified time';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger check_doctor_schedule_on_appointment
before insert on appointment
for each row
execute function check_doctor_schedule();

create or replace function delete_patient_appointments_and_analyses() returns trigger as $$
begin
    delete from appointment where patient_id = old.id;
    delete from analysis where patient_id = old.id;
    return old;
end;
$$ language plpgsql;

create trigger delete_patient_appointments_and_analyses_on_delete
after delete on patient
for each row
execute function delete_patient_appointments_and_analyses();
