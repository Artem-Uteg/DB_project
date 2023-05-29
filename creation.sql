CREATE TABLE Patient (
    id				SERIAL			PRIMARY KEY,
    name			VARCHAR(50)		NOT NULL,
    birthdate		DATE			NOT NULL,
    address			VARCHAR(100)	NOT NULL,
    phone_number	VARCHAR(17)		NOT NULL,
    doc_number		VARCHAR(19)		NOT NULL
);

CREATE TABLE Doctor (
    id				SERIAL			PRIMARY KEY,
    name			VARCHAR(50)		NOT NULL,
    specialization	VARCHAR(50)		NOT NULL,
    phone			VARCHAR(20)		NOT NULL,
    is_working		BOOLEAN			NOT NULL DEFAULT TRUE,
    schedule		VARCHAR(500)	NOT NULL
);

CREATE TABLE Prescription (
    id 				SERIAL 			PRIMARY KEY,
    cond_descr 		VARCHAR(200)	NOT NULL,
    diagnosis 		VARCHAR(50)		NOT NULL,
    recommendations	VARCHAR(500)	NOT NULL,
    valid_from 		TIMESTAMP		NOT NULL CHECK (valid_from <= CURRENT_DATE),
    valid_to 		TIMESTAMP		CHECK (valid_to >= valid_from) 
);

CREATE TABLE Appointment (
    id 				SERIAL 			PRIMARY KEY,
    patient_id 		INT				NOT NULL,
    doctor_id 		INT				NOT NULL,
    prescription_id	INT 			NOT NULL,
    date 			DATE			NOT NULL,
    time 			TIME			NOT NULL,
    
    FOREIGN KEY (patient_id) REFERENCES Patient(id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(id),
    FOREIGN KEY (prescription_id) REFERENCES Prescription(id)
);


CREATE TABLE Analysis (
    id 				SERIAL 			PRIMARY KEY,
    patient_id		INT 			NOT NULL,
    type 			VARCHAR(50) 	NOT NULL,
    result 			VARCHAR(300)	NOT NULL,
    date 			DATE 			NOT NULL,
    
    FOREIGN KEY (patient_id) REFERENCES Patient(id)
);

	