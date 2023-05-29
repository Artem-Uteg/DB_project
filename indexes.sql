CREATE INDEX p_id
ON analysis (patient_id);

CREATE INDEX p_appointments
ON appointment (patient_id);


CREATE INDEX d_appointments
ON appointment (doctor_id);
