-- Hospital Management System (MySQL)
-- Run this file from top to bottom.

SHOW DATABASES;

-- Create the database
CREATE DATABASE IF NOT EXISTS Hospital_Management_System;

SHOW DATABASES;

-- Use the database
USE Hospital_Management_System;

-- ===== TABLES =====
-- Patients table
CREATE TABLE Patients(
	patient_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
    dob DATE,
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('Male', 'Female', 'Other')),
    phone_number CHAR(10),
    email VARCHAR(50) UNIQUE,
    address VARCHAR(100),
    registration_date DATE NOT NULL
);

-- Doctors table
CREATE TABLE Doctors(
	doctor_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
    specialization VARCHAR(20) NOT NULL,
    phone_number CHAR(10),
    email VARCHAR(50) UNIQUE,
    available_days VARCHAR(10),
    consultation_fee INT
);

-- Appointments table (links patients and doctors)
CREATE TABLE Appointments(
	appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL, 
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
	status VARCHAR(20) NOT NULL CHECK (status IN ('Scheduled', 'Completed', 'Cancelled')),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- Medical records table
CREATE TABLE Medical_Records(
	record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL, 
    doctor_id INT NOT NULL,
    diagnosis VARCHAR(200) NOT NULL,
    prescription VARCHAR(500) NOT NULL,
    treatment_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- Billing table (one invoice per appointment)
CREATE TABLE Billing(
	invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    appointment_id INT NOT NULL,
    amount DECIMAL(10,2),
    payment_status VARCHAR(10) NOT NULL CHECK (payment_status IN ('Paid','Pending','Cancelled')),
    payment_date DATE NOT NULL,
	FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
	FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- Departments table
CREATE TABLE Departments(
	department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL
);

-- Mapping table: doctors <-> departments
CREATE TABLE Doctor_Department(
	doctor_id INT NOT NULL,
    department_id INT NOT NULL,
    PRIMARY KEY (doctor_id, department_id),
	FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE,
	FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE CASCADE
);

-- ===== SAMPLE DATA =====
-- Task 1: insert patients
INSERT INTO Patients (name, dob, gender, phone_number, email, address, registration_date) VALUES
('Ravi Sharma','1990-05-12','Male','9876543210','ravi.sharma@example.com','Delhi','2026-01-01'),
('Priya Patel','1985-08-20','Female',NULL,'priya.patel@example.com','Mumbai','2026-01-02'),
('Amit Verma','1978-03-15','Male','9123456789','amit.verma@example.com','Ahmedabad','2026-01-03'),
('Sneha Rao','1992-07-10','Female',NULL,'sneha.rao@example.com','Surat','2026-01-04'),
('Karan Mehta','1988-11-25','Male','9988776655','karan.mehta@example.com','Pune','2026-01-05'),
('Neha Joshi','1995-02-14','Female','9876504321','neha.joshi@example.com','Nagpur','2026-01-06'),
('Vikas Singh','1982-09-30','Male',NULL,'vikas.singh@example.com','Lucknow','2026-01-07'),
('Anjali Desai','1991-12-05','Female','9123409876','anjali.desai@example.com','Vadodara','2026-01-08'),
('Suresh Kumar','1975-04-18','Male','9988123450','suresh.kumar@example.com','Chennai','2026-01-09'),
('Meena Shah','1987-06-22','Female',NULL,'meena.shah@example.com','Hyderabad','2026-01-10'),
('Rohit Nair','1993-11-11','Male','9876123459','rohit.nair@example.com','Kochi','2026-01-11'),
('Pooja Iyer','1989-03-07','Female','9123456781','pooja.iyer@example.com','Bangalore','2026-01-12'),
('Deepak Yadav','1984-07-19','Male',NULL,'deepak.yadav@example.com','Patna','2026-01-13'),
('Shalini Reddy','1996-01-25','Female','9988771234','shalini.reddy@example.com','Secunderabad','2026-01-14'),
('Manish Jain','1979-08-09','Male','9876543211','manish.jain@example.com','Indore','2026-01-15'),
('Kavita Kapoor','1990-10-30','Female',NULL,'kavita.kapoor@example.com','Delhi','2026-01-16'),
('Arun Mishra','1983-05-05','Male','9123456782','arun.mishra@example.com','Kanpur','2026-01-17'),
('Divya Bhatt','1994-09-12','Female','9988776656','divya.bhatt@example.com','Jaipur','2026-01-18'),
('Sanjay Chauhan','1981-02-28','Male',NULL,'sanjay.chauhan@example.com','Bhopal','2026-01-19'),
('Ritika Malhotra','1992-07-21','Female','9876509876','ritika.malhotra@example.com','Delhi','2026-01-20'),
('Ashok Menon','1977-01-10','Male','9123456783','ashok.menon@example.com','Trivandrum','2026-01-21'),
('Geeta Pillai','1986-04-22','Female',NULL,'geeta.pillai@example.com','Kochi','2026-01-22'),
('Nikhil Saxena','1991-09-09','Male','9988776657','nikhil.saxena@example.com','Noida','2026-01-23'),
('Renu Bhatia','1988-12-30','Female','9876501234','renu.bhatia@example.com','Delhi','2026-01-24'),
('Ajay Thakur','1980-06-18','Male',NULL,'ajay.thakur@example.com','Shimla','2026-01-25'),
('Sunita Agarwal','1987-03-14','Female','9123456784','sunita.agarwal@example.com','Delhi','2026-01-26'),
('Ramesh Joshi','1976-07-22','Male',NULL,'ramesh.joshi@example.com','Mumbai','2026-01-27'),
('Alok Pandey','1982-11-05','Male','9988776658','alok.pandey@example.com','Varanasi','2026-01-28'),
('Seema Kulkarni','1990-09-18','Female','9876505678','seema.kulkarni@example.com','Pune','2026-01-29'),
('Harish Chandra','1984-01-30','Male',NULL,'harish.chandra@example.com','Lucknow','2026-01-30'),
('Jyoti Sinha','1993-06-12','Female','9123456785','jyoti.sinha@example.com','Patna','2026-01-31'),
('Mukesh Patel','1979-08-25','Male','9988776659','mukesh.patel@example.com','Ahmedabad','2026-02-01'),
('Shweta Ghosh','1988-02-19','Female',NULL,'shweta.ghosh@example.com','Kolkata','2026-02-02'),
('Anand Rao','1991-05-07','Male','9876506789','anand.rao@example.com','Hyderabad','2026-02-03'),
('Pallavi Deshmukh','1985-12-23','Female','9123456786','pallavi.deshmukh@example.com','Nagpur','2026-02-04'),
('Vinod Yadav','1977-04-11','Male',NULL,'vinod.yadav@example.com','Kanpur','2026-02-05'),
('Rekha Sharma','1992-08-29','Female','9988776660','rekha.sharma@example.com','Delhi','2026-02-06'),
('Ashwin Nair','1980-10-16','Male','9876507890','ashwin.nair@example.com','Kochi','2026-02-07'),
('Lata Rani','1989-01-03','Female',NULL,'lata.rani@example.com','Jaipur','2026-02-08'),
('Gaurav Saxena','1983-09-21','Male','9123456787','gaurav.saxena@example.com','Noida','2026-02-09'),
('Nisha Kapoor','1994-07-15','Female','9988776661','nisha.kapoor@example.com','Delhi','2026-02-10'),
('Rajeev Malhotra','1978-05-28','Male',NULL,'rajeev.malhotra@example.com','Chandigarh','2026-02-11'),
('Anita Verma','1986-11-09','Female','9876508901','anita.verma@example.com','Lucknow','2026-02-12'),
('Siddharth Gupta','1990-02-17','Male','9123456788','siddharth.gupta@example.com','Indore','2026-02-13'),
('Poonam Reddy','1982-06-30','Female',NULL,'poonam.reddy@example.com','Hyderabad','2026-02-14'),
('Mahesh Kumar','1975-12-12','Male','9988776662','mahesh.kumar@example.com','Delhi','2026-02-15'),
('Kiran Joshi','1991-03-08','Female','9876509012','kiran.joshi@example.com','Mumbai','2026-02-16'),
('Suraj Singh','1987-09-27','Male',NULL,'suraj.singh@example.com','Varanasi','2026-02-17'),
('Radhika Pillai','1995-04-20','Female','9123456789','radhika.pillai@example.com','Kochi','2026-02-18'),
('Naveen Chauhan','1981-07-02','Male','9988776663','naveen.chauhan@example.com','Bhopal','2026-02-19');

-- Task 1: insert doctors
INSERT INTO Doctors (name, specialization, phone_number, email, available_days, consultation_fee) VALUES
('Dr. Arjun Mehta','Cardiology','9988776655','arjun.mehta@hospital.com','Mon-Fri',500),
('Dr. Sneha Rao','Neurology','9876501234','sneha.rao@hospital.com','Tue-Thu',2000),
('Dr. Rajesh Gupta','Orthopedics','9123456780','rajesh.gupta@hospital.com','Mon-Wed',750),
('Dr. Neha Sharma','Dermatology','9988123456','neha.sharma@hospital.com','Fri-Sat',400),
('Dr. Vivek Patel','Pediatrics','9876123450','vivek.patel@hospital.com','Mon-Fri',1500),
('Dr. Kavita Iyer','Oncology','9123456790','kavita.iyer@hospital.com','Tue-Fri',3000),
('Dr. Sanjay Menon','ENT','9988771122','sanjay.menon@hospital.com','Mon-Thu',600),
('Dr. Ritu Kapoor','Gynecology','9876504322','ritu.kapoor@hospital.com','Wed-Sat',1200),
('Dr. Anil Deshmukh','Psychiatry','9123456701','anil.deshmukh@hospital.com','Mon-Fri',2500),
('Dr. Pooja Nair','General Medicine','9988772233','pooja.nair@hospital.com','Mon-Sun',450),
('Dr. Harish Chandra','Cardiology','9876506781','harish.chandra@hospital.com','Tue-Fri',1000),
('Dr. Shalini Verma','Neurology','9123456712','shalini.verma@hospital.com','Mon-Wed',1800),
('Dr. Mohan Joshi','Orthopedics','9988773344','mohan.joshi@hospital.com','Thu-Sat',2200),
('Dr. Anita Reddy','Dermatology','9876507891','anita.reddy@hospital.com','Mon-Fri',800),
('Dr. Nikhil Saxena','Pediatrics','9123456723','nikhil.saxena@hospital.com','Tue-Thu',3000);

-- Task 1: insert appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(5,1,'2026-05-22','Completed'),
(2,3,'2026-02-02','Completed'),
(47,9,'2026-05-15','Scheduled'),
(31,1,'2026-03-03','Scheduled'),
(14,14,'2026-02-14','Scheduled'),
(25,7,'2026-05-13','Completed'),
(33,8,'2026-05-14','Cancelled'),
(19,2,'2026-05-23','Scheduled'),
(41,11,'2026-03-13','Scheduled'),
(7,7,'2026-02-07','Cancelled'),
(50,10,'2026-05-16','Completed'),
(36,4,'2026-05-25','Scheduled'),
(11,11,'2026-06-01','Completed'),
(27,13,'2026-06-03','Cancelled'),
(9,11,'2026-05-17','Scheduled'),
(20,5,'2026-02-20','Scheduled'),
(48,3,'2026-03-20','Scheduled'),
(16,1,'2026-02-16','Scheduled'),
(22,13,'2026-05-19','Scheduled'),
(3,5,'2026-02-03','Cancelled'),
(34,14,'2026-06-04','Scheduled'),
(18,12,'2026-05-18','Completed'),
(44,15,'2026-05-21','Scheduled'),
(23,8,'2026-02-23','Cancelled'),
(28,3,'2026-05-24','Cancelled'),
(1,1,'2026-02-01','Scheduled'),
(45,15,'2026-06-05','Completed'),
(39,9,'2026-05-30','Cancelled'),
(10,10,'2026-02-10','Scheduled'),
(12,6,'2026-05-12','Scheduled'),
(29,14,'2026-03-01','Scheduled'),
(6,6,'2026-02-06','Scheduled'),
(50,5,'2026-03-22','Scheduled'),
(13,13,'2026-02-13','Cancelled'),
(42,12,'2026-03-14','Completed'),
(15,15,'2026-02-15','Completed'),
(8,8,'2026-02-08','Scheduled'),
(46,1,'2026-03-18','Scheduled'),
(30,15,'2026-03-02','Completed'),
(4,2,'2026-02-04','Scheduled'),
(21,6,'2026-02-21','Completed'),
(32,2,'2026-03-04','Cancelled'),
(43,13,'2026-03-15','Cancelled'),
(24,9,'2026-02-24','Scheduled'),
(35,5,'2026-03-07','Scheduled'),
(40,10,'2026-03-12','Completed'),
(17,2,'2026-02-17','Completed'),
(49,4,'2026-03-21','Cancelled'),
(26,11,'2026-02-26','Scheduled'),
(37,7,'2026-03-09','Scheduled'),
(38,8,'2026-03-10','Cancelled'),
(46,12,'2026-06-06','Scheduled'),
(29,5,'2026-06-07','Completed'),
(8,14,'2026-06-08','Scheduled'),
(17,9,'2026-06-09','Cancelled'),
(21,3,'2026-06-10','Scheduled'),
(37,14,'2026-07-17','Completed'),
(4,8,'2026-06-14','Scheduled'),
(15,13,'2026-06-25','Cancelled'),
(25,3,'2026-07-05','Completed'),
(46,2,'2026-07-26','Scheduled'),
(9,1,'2026-06-19','Completed'),
(28,9,'2026-07-08','Scheduled'),
(40,3,'2026-07-20','Scheduled'),
(2,4,'2026-06-12','Scheduled'),
(44,11,'2026-07-24','Scheduled'),
(11,5,'2026-06-21','Cancelled'),
(31,2,'2026-07-11','Cancelled'),
(20,10,'2026-06-30','Scheduled'),
(7,14,'2026-06-17','Cancelled'),
(48,6,'2026-07-28','Scheduled'),
(13,9,'2026-06-23','Completed'),
(35,10,'2026-07-15','Cancelled'),
(22,14,'2026-07-02','Scheduled'),
(6,12,'2026-06-16','Scheduled'),
(42,7,'2026-07-22','Scheduled'),
(17,4,'2026-06-27','Completed'),
(33,6,'2026-07-13','Completed'),
(1,2,'2026-06-11','Completed'),
(49,8,'2026-07-29','Completed'),
(19,8,'2026-06-29','Cancelled'),
(29,11,'2026-07-09','Completed'),
(10,3,'2026-06-20','Scheduled'),
(23,15,'2026-07-03','Cancelled'),
(36,12,'2026-07-16','Scheduled'),
(5,10,'2026-06-15','Completed'),
(41,5,'2026-07-21','Completed'),
(14,11,'2026-06-24','Scheduled'),
(26,5,'2026-07-06','Scheduled'),
(8,15,'2026-06-18','Scheduled'),
(32,4,'2026-07-12','Scheduled'),
(18,6,'2026-06-28','Scheduled'),
(43,9,'2026-07-23','Cancelled'),
(12,7,'2026-06-22','Scheduled'),
(30,13,'2026-07-10','Scheduled'),
(3,6,'2026-06-13','Cancelled'),
(45,13,'2026-07-25','Completed'),
(16,2,'2026-06-26','Scheduled'),
(34,8,'2026-07-14','Scheduled'),
(21,12,'2026-07-01','Completed'),
(39,1,'2026-07-19','Cancelled'),
(27,7,'2026-07-07','Cancelled'),
(24,1,'2026-07-04','Scheduled'),
(38,15,'2026-07-18','Scheduled'),
(47,4,'2026-07-27','Cancelled'),
(50,10,'2026-07-30','Scheduled');

-- Insert medical records
INSERT INTO Medical_Records (record_id, patient_id, doctor_id, diagnosis, prescription, treatment_date) VALUES
(87,13,7,'Thyroid Disorder','Levothyroxine 125mcg daily','2026-07-19'),
(12,36,4,'Thyroid Disorder','Levothyroxine 50mcg daily','2026-05-25'),
(45,35,5,'Asthma','Ipratropium nebulizer','2026-03-07'),
(3,47,3,'Fracture','Calcium supplements','2026-02-03'),
(91,26,11,'Hypertension','Losartan 25mg daily','2026-07-23'),
(18,16,1,'Migraine','Propranolol 40mg daily','2026-02-16'),
(62,44,12,'Thyroid Disorder','Levothyroxine 100mcg daily','2026-06-27'),
(29,10,10,'Diabetes Type 2','Insulin glargine','2026-02-10'),
(77,29,12,'Migraine','Sumatriptan 100mg as needed','2026-07-25'),
(5,14,14,'Skin Allergy','Cetirizine 10mg daily','2026-02-14'),
(33,50,5,'Ear Infection','Ciprofloxacin drops','2026-03-22'),
(54,25,4,'Diabetes Type 2','Metformin 500mg twice daily','2026-07-05'),
(20,3,5,'Asthma','Budesonide nebulizer','2026-02-03'),
(84,35,4,'Fever','Paracetamol 500mg','2026-07-16'),
(41,21,6,'Hypertension','Atenolol 25mg daily','2026-02-21'),
(7,33,8,'Depression','Sertraline 50mg daily','2026-05-14'),
(99,13,4,'Back Pain','Naproxen 250mg twice daily','2026-07-31'),
(26,1,1,'Hypertension','Ramipril 5mg daily','2026-02-01'),
(64,19,14,'Pregnancy Checkup','Folic acid + iron','2026-06-11'),
(15,9,11,'Cancer Screening','No prescription','2026-05-17'),
(36,15,15,'Anemia','Iron tablets','2026-02-15'),
(70,23,5,'Asthma','Levosalbutamol nebulizer','2026-06-17'),
(49,26,11,'Back Pain','Muscle relaxant','2026-02-26'),
(2,2,2,'Migraine','Sumatriptan 50mg as needed','2026-02-02'),
(82,43,2,'Depression','Sertraline 100mg daily','2026-07-14'),
(11,50,10,'Anemia','Ferrous sulfate 325mg daily','2026-05-16'),
(39,30,15,'Pregnancy Checkup','Calcium + Vitamin D','2026-03-02'),
(66,36,1,'Hypertension','Hydrochlorothiazide 25mg daily','2026-06-29'),
(23,44,15,'Fever','Paracetamol 650mg','2026-05-21'),
(58,9,8,'Ear Infection','Ofloxacin drops','2026-06-23'),
(31,29,14,'Asthma','Formoterol inhaler','2026-03-01'),
(93,49,13,'Migraine','Propranolol 40mg daily','2026-07-25'),
(8,19,2,'Ear Infection','Amoxicillin 500mg thrice daily','2026-05-23'),
(47,17,2,'Ear Wax','No prescription','2026-02-17'),
(21,34,14,'Depression','Escitalopram 10mg daily','2026-06-04'),
(60,22,10,'Back Pain','Ibuprofen 400mg','2026-06-16'),
(1,5,1,'Hypertension','Amlodipine 5mg daily','2026-02-01'),
(74,20,9,'Back Pain','Muscle relaxant','2026-06-22'),
(42,32,2,'Diabetes Type 1','Insulin lispro','2026-03-04'),
(95,12,15,'Asthma','Budesonide nebulizer','2026-07-27'),
(17,48,3,'Diabetes Type 1','Insulin injection','2026-03-20'),
(28,39,9,'Fracture','Vitamin D supplements','2026-05-30'),
(52,1,2,'Migraine','Naproxen 250mg twice daily','2026-06-14'),
(34,13,13,'Fever','Paracetamol 500mg','2026-02-13'),
(88,42,8,'Arthritis','Indomethacin 25mg','2026-07-20'),
(6,25,7,'Asthma','Salbutamol inhaler','2026-05-13'),
(46,40,10,'Depression','Venlafaxine 75mg daily','2026-03-12'),
(13,11,11,'Arthritis','Diclofenac gel','2026-06-01'),
(72,11,7,'Ear Wax','No prescription','2026-06-21'),
(40,4,2,'Cancer Screening','No prescription','2026-02-04'),
(9,41,11,'Fever','Paracetamol 500mg as needed','2026-03-13'),
(57,50,7,'Depression','Escitalopram 10mg daily','2026-07-28'),
(27,45,15,'Migraine','Ibuprofen 400mg as needed','2026-06-05'),
(86,15,6,'Anemia','Iron tablets','2026-07-18'),
(19,22,13,'Skin Rash','Hydrocortisone cream','2026-05-19'),
(51,38,8,'Hypertension','Telmisartan 40mg daily','2026-07-17'),
(30,12,6,'Skin Infection','Cefalexin 500mg thrice daily','2026-05-12'),
(48,49,4,'Fever','Paracetamol 650mg','2026-03-21'),
(80,21,15,'Skin Infection','Clindamycin 300mg','2026-07-12'),
(25,28,3,'Anemia','Iron tablets','2026-05-24'),
(68,7,3,'Migraine','Amitriptyline 10mg daily','2026-06-20'),
(35,42,12,'Back Pain','Diclofenac 50mg twice daily','2026-03-14'),
(63,5,13,'Arthritis','Naproxen 250mg twice daily','2026-07-13'),
(4,31,1,'Diabetes Type 2','Metformin 500mg twice daily','2026-03-03'),
(81,32,1,'Asthma','Fluticasone inhaler','2026-07-13'),
(14,27,13,'Pregnancy Checkup','Folic acid 5mg daily','2026-06-03'),
(22,18,12,'Ear Wax','No prescription','2026-05-18'),
(90,4,10,'Cancer Screening','No prescription','2026-07-22'),
(37,8,8,'Thyroid Disorder','Levothyroxine 75mcg daily','2026-02-08'),
(55,33,5,'Skin Allergy','Cetirizine 10mg daily','2026-07-26'),
(50,37,7,'Anemia','Iron + folic acid tablets','2026-03-09'),
(97,6,2,'Ear Wax','No prescription','2026-07-29'),
(24,23,8,'Back Pain','Naproxen 250mg twice daily','2026-02-23'),
(76,46,11,'Hypertension','Amlodipine 10mg daily','2026-06-13'),
(32,6,6,'Depression','Fluoxetine 20mg daily','2026-02-06'),
(10,7,7,'Back Pain','Ibuprofen 400mg as needed','2026-02-07'),
(65,28,15,'Cancer Screening','No prescription','2026-07-29'),
(56,47,6,'Asthma','Budesonide inhaler','2026-06-19'),
(16,20,5,'Hypertension','Losartan 50mg daily','2026-02-20'),
(78,8,13,'Fracture','Calcium supplements','2026-06-26'),
(83,24,3,'Ear Infection','Amoxicillin drops','2026-07-15'),
(94,10,14,'Skin Rash','Hydrocortisone cream','2026-07-26'),
(67,41,2,'Diabetes Type 1','Insulin regular','2026-07-09'),
(73,27,8,'Fever','Paracetamol 650mg','2026-07-24'),
(85,40,5,'Back Pain','Diclofenac gel','2026-07-17'),
(44,24,9,'Skin Rash','Clobetasol cream','2026-02-24'),
(100,42,5,'Anemia','Iron tablets','2026-08-01'),
(79,17,14,'Diabetes Type 1','Insulin detemir','2026-07-11'),
(89,30,9,'Pregnancy Checkup','Calcium supplements','2026-07-21'),
(53,12,3,'Fracture','Calcium + Vitamin D','2026-06-25'),
(96,29,1,'Depression','Venlafaxine 75mg daily','2026-07-28'),
(75,48,10,'Anemia','Iron + folic acid tablets','2026-07-10'),
(38,46,1,'Arthritis','Naproxen 250mg twice daily','2026-03-18'),
(71,34,6,'Depression','Paroxetine 20mg daily','2026-07-02'),
(59,18,9,'Fever','Paracetamol 500mg','2026-07-15'),
(98,50,3,'Fever','Paracetamol 650mg','2026-07-30'),
(43,43,13,'Migraine','Topiramate 25mg daily','2026-03-15'),
(92,37,12,'Diabetes Type 1','Insulin injection','2026-07-24');

-- Insert billing records
INSERT INTO Billing (patient_id, appointment_id, amount, payment_status, payment_date) VALUES
(5,1,600,'Paid','2026-02-01'),
(2,2,2200,'Paid','2026-02-02'),
(47,3,800,'Pending','2026-02-03'),
(31,4,500,'Paid','2026-02-04'),
(14,5,1600,'Paid','2026-02-05'),
(25,6,3200,'Paid','2026-02-06'),
(33,7,650,'Cancelled','2026-02-07'),
(19,8,1300,'Paid','2026-02-08'),
(41,9,2700,'Paid','2026-02-09'),
(7,10,500,'Pending','2026-02-10'),
(50,11,600,'Paid','2026-02-11'),
(36,12,1600,'Paid','2026-02-12'),
(11,13,2300,'Paid','2026-02-13'),
(27,14,900,'Cancelled','2026-02-14'),
(9,15,3200,'Paid','2026-02-15'),
(20,16,550,'Paid','2026-02-16'),
(48,17,2100,'Paid','2026-02-17'),
(16,18,800,'Pending','2026-02-18'),
(22,19,450,'Paid','2026-02-19'),
(3,20,1600,'Paid','2026-02-20'),
(34,21,3100,'Paid','2026-02-21'),
(18,22,700,'Cancelled','2026-02-22'),
(44,23,1300,'Paid','2026-02-23'),
(23,24,2600,'Paid','2026-02-24'),
(28,25,500,'Paid','2026-02-25'),
(1,26,600,'Paid','2026-02-26'),
(45,27,1600,'Paid','2026-02-27'),
(39,28,2300,'Pending','2026-02-28'),
(10,29,850,'Paid','2026-03-01'),
(12,30,3100,'Paid','2026-03-02'),
(29,31,550,'Paid','2026-03-03'),
(6,32,2100,'Cancelled','2026-03-04'),
(50,33,800,'Paid','2026-03-05'),
(13,34,500,'Paid','2026-03-06'),
(42,35,1600,'Paid','2026-03-07'),
(15,36,2300,'Paid','2026-03-08'),
(8,37,900,'Cancelled','2026-03-09'),
(46,38,3200,'Paid','2026-03-10'),
(30,39,600,'Paid','2026-03-11'),
(4,40,2000,'Paid','2026-03-12'),
(21,41,750,'Pending','2026-03-13'),
(32,42,1300,'Paid','2026-03-14'),
(43,43,2600,'Paid','2026-03-15'),
(24,44,500,'Paid','2026-03-16'),
(35,45,1600,'Paid','2026-03-17'),
(40,46,2300,'Cancelled','2026-03-18'),
(17,47,900,'Paid','2026-03-19'),
(49,48,3200,'Paid','2026-03-20'),
(26,49,600,'Paid','2026-03-21'),
(37,50,2000,'Paid','2026-03-22'),
(38,51,750,'Paid','2026-03-23'),
(1,52,1300,'Pending','2026-03-24'),
(12,53,2600,'Paid','2026-03-25'),
(25,54,500,'Paid','2026-03-26'),
(33,55,1600,'Paid','2026-03-27'),
(47,56,2300,'Cancelled','2026-03-28'),
(50,57,900,'Paid','2026-03-29'),
(9,58,3200,'Paid','2026-03-30'),
(18,59,600,'Paid','2026-03-31'),
(22,60,2000,'Paid','2026-04-01'),
(31,61,750,'Pending','2026-04-02'),
(44,62,1300,'Paid','2026-04-03'),
(5,63,2600,'Paid','2026-04-04'),
(19,64,500,'Paid','2026-04-05'),
(28,65,1600,'Paid','2026-04-06'),
(36,66,2300,'Cancelled','2026-04-07'),
(41,67,900,'Paid','2026-04-08'),
(7,68,3200,'Paid','2026-04-09'),
(16,69,600,'Paid','2026-04-10'),
(23,70,2000,'Paid','2026-04-11'),
(34,71,750,'Pending','2026-04-12'),
(11,72,1300,'Paid','2026-04-13'),
(27,73,2600,'Paid','2026-04-14'),
(20,74,500,'Paid','2026-04-15'),
(48,75,1600,'Paid','2026-04-16'),
(46,76,2300,'Cancelled','2026-04-17'),
(29,77,900,'Paid','2026-04-18'),
(8,78,3200,'Paid','2026-04-19'),
(17,79,600,'Paid','2026-04-20'),
(21,80,2000,'Paid','2026-04-21'),
(32,81,750,'Pending','2026-04-22'),
(43,82,1300,'Paid','2026-04-23'),
(24,83,2600,'Paid','2026-04-24'),
(35,84,500,'Paid','2026-04-25'),
(40,85,1600,'Paid','2026-04-26'),
(15,86,2300,'Cancelled','2026-04-27'),
(13,87,900,'Paid','2026-04-28'),
(42,88,3200,'Paid','2026-04-29'),
(30,89,600,'Paid','2026-04-30'),
(4,90,2000,'Paid','2026-05-01'),
(26,91,750,'Pending','2026-05-02'),
(37,92,1300,'Paid','2026-05-03'),
(49,93,2600,'Paid','2026-05-04'),
(10,94,500,'Paid','2026-05-05'),
(12,95,1600,'Paid','2026-05-06'),
(29,96,2300,'Cancelled','2026-05-07'),
(6,97,900,'Paid','2026-05-08'),
(50,98,3200,'Paid','2026-05-09'),
(13,99,600,'Paid','2026-05-10'),
(42,100,2000,'Paid','2026-05-11');

-- Insert departments
INSERT INTO Departments (department_id, department_name) VALUES
(1,'Cardiology'),
(2,'Neurology'),
(3,'Orthopedics'),
(4,'Dermatology'),
(5,'Pediatrics'),
(6,'Oncology'),
(7,'ENT'),
(8,'Gynecology'),
(9,'Psychiatry'),
(10,'General Medicine');

-- Assign doctors to departments
INSERT INTO Doctor_Department (doctor_id, department_id) VALUES
(1,1),   -- Dr. Arjun Mehta → Cardiology
(2,2),   -- Dr. Sneha Rao → Neurology
(3,3),   -- Dr. Rajesh Gupta → Orthopedics
(4,4),   -- Dr. Neha Sharma → Dermatology
(5,5),   -- Dr. Vivek Patel → Pediatrics
(6,6),   -- Dr. Kavita Iyer → Oncology
(7,7),   -- Dr. Sanjay Menon → ENT
(8,8),   -- Dr. Ritu Kapoor → Gynecology
(9,9),   -- Dr. Anil Deshmukh → Psychiatry
(10,10), -- Dr. Pooja Nair → General Medicine
(11,1),  -- Dr. Harish Chandra → Cardiology
(12,2),  -- Dr. Shalini Verma → Neurology
(13,3),  -- Dr. Mohan Joshi → Orthopedics
(14,4),  -- Dr. Anita Reddy → Dermatology
(15,5);  -- Dr. Nikhil Saxena → Pediatrics

-- ===== QUERIES =====

-- Task 1: Update a patient's address
UPDATE Patients
SET address = 'Ahmedabad'
WHERE patient_id = 1;
-- (Task 1 DELETE is at the end of the file, because it removes data)

-- Task 2: Patients registered in the last year
SELECT *
FROM Patients
WHERE registration_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- Task 2: Top 5 highest-paying patients
SELECT p.patient_id, p.name, SUM(b.amount) AS total_paid
FROM Billing b
JOIN Patients p ON b.patient_id = p.patient_id
WHERE b.payment_status = 'Paid'
GROUP BY p.patient_id, p.name
HAVING total_paid > 0
ORDER BY total_paid DESC
LIMIT 5;

-- Task 2: Doctors who charge more than 1000
SELECT doctor_id, name AS doctor_name, consultation_fee
FROM Doctors
WHERE consultation_fee > 1000;

-- Task 3: Scheduled appointments of doctor 3 (AND)
SELECT *
FROM Appointments
WHERE status = 'Scheduled' AND doctor_id = 3;

-- Task 3: Cardiology or Neurology doctors (OR)
SELECT *
FROM Doctors
WHERE specialization = 'Cardiology' OR specialization = 'Neurology';

-- Task 3: Patients with no visit in the past year (NOT)
SELECT *
FROM Patients
WHERE patient_id NOT IN (
    SELECT patient_id
    FROM Appointments
    WHERE appointment_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);

-- Task 4: Doctors sorted by specialization
SELECT doctor_id, name AS doctor_name, specialization
FROM Doctors
ORDER BY specialization;

-- Task 4: Number of patients per doctor
SELECT d.doctor_id, d.name AS doctor_name, COUNT(DISTINCT a.patient_id) AS patient_count
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.name;

-- Task 4: Total revenue per department (paid invoices only)
SELECT dep.department_id, dep.department_name, SUM(b.amount) AS total_revenue
FROM Billing b
JOIN Appointments a ON b.appointment_id = a.appointment_id
JOIN Doctor_Department dd ON a.doctor_id = dd.doctor_id
JOIN Departments dep ON dd.department_id = dep.department_id
WHERE b.payment_status = 'Paid'
GROUP BY dep.department_id, dep.department_name;

-- Task 5: Total revenue collected (paid invoices only)
SELECT SUM(amount) AS total_revenue
FROM Billing
WHERE payment_status = 'Paid';

-- Task 5: Most visited doctor
SELECT d.doctor_id, d.name AS doctor_name, COUNT(*) AS visit_count
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id, d.name
ORDER BY visit_count DESC
LIMIT 1;

-- Task 5: Average, highest and lowest consultation fee
SELECT AVG(consultation_fee) AS avg_fee,
       MAX(consultation_fee) AS max_fee,
       MIN(consultation_fee) AS min_fee
FROM Doctors;

-- Task 6: Check the foreign keys (they are already created in CREATE TABLE)
SELECT TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'Hospital_Management_System'
  AND REFERENCED_TABLE_NAME IS NOT NULL;

-- Task 7: Doctors with department names (INNER JOIN)
SELECT d.doctor_id, d.name AS doctor_name, dep.department_name
FROM Doctors d
INNER JOIN Doctor_Department dd ON d.doctor_id = dd.doctor_id
INNER JOIN Departments dep ON dd.department_id = dep.department_id;

-- Task 7: Patients with completed appointments (LEFT JOIN)
SELECT DISTINCT p.patient_id, p.name
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
WHERE a.status = 'Completed';

-- Task 7: Appointments with no payment (RIGHT JOIN)
SELECT a.appointment_id, a.patient_id, a.appointment_date
FROM Billing b
RIGHT JOIN Appointments a ON b.appointment_id = a.appointment_id
WHERE b.invoice_id IS NULL;

-- Task 7: Patients who never booked an appointment
-- (MySQL has no FULL OUTER JOIN, so LEFT JOIN UNION RIGHT JOIN is used)
SELECT *
FROM (
    SELECT p.patient_id, p.name, a.appointment_id
    FROM Patients p
    LEFT JOIN Appointments a ON p.patient_id = a.patient_id
    UNION
    SELECT p.patient_id, p.name, a.appointment_id
    FROM Patients p
    RIGHT JOIN Appointments a ON p.patient_id = a.patient_id
) AS full_join
WHERE appointment_id IS NULL;

-- Task 8: Doctors who handled more than 50 patients
-- (the sample data is small, so change 50 to 5 to see rows)
SELECT doctor_id, name
FROM Doctors
WHERE doctor_id IN (
    SELECT doctor_id
    FROM Appointments
    GROUP BY doctor_id
    HAVING COUNT(DISTINCT patient_id) > 50
);

-- Task 8: Patient who spent the most (paid invoices only)
SELECT patient_id, name
FROM Patients
WHERE patient_id = (
    SELECT patient_id
    FROM Billing
    WHERE payment_status = 'Paid'
    GROUP BY patient_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

-- Task 8: Appointments with Dermatology doctors
SELECT *
FROM Appointments
WHERE doctor_id IN (
    SELECT doctor_id
    FROM Doctors
    WHERE specialization = 'Dermatology'
);

-- Task 9: Visits per month
SELECT YEAR(appointment_date) AS year, MONTH(appointment_date) AS month, COUNT(*) AS visits
FROM Appointments
GROUP BY YEAR(appointment_date), MONTH(appointment_date)
ORDER BY year, month;

-- Task 9: Add admission and discharge dates (needed for hospital stay)
ALTER TABLE Medical_Records
ADD COLUMN admission_date DATE,
ADD COLUMN discharge_date DATE;

-- Task 9: Fill sample dates (admission = treatment date, stay of 1 to 5 days)
UPDATE Medical_Records
SET admission_date = treatment_date,
    discharge_date = DATE_ADD(treatment_date, INTERVAL (record_id MOD 5) + 1 DAY)
WHERE record_id > 0;

-- Task 9: Hospital stay duration in days
SELECT record_id, patient_id, DATEDIFF(discharge_date, admission_date) AS stay_days
FROM Medical_Records;

-- Task 9: Format treatment_date as DD-MM-YYYY
SELECT record_id, DATE_FORMAT(treatment_date, '%d-%m-%Y') AS formatted_date
FROM Medical_Records;

-- Task 10: Patient names in uppercase
SELECT patient_id, UPPER(name) AS patient_name_upper
FROM Patients;

-- Task 10: Trim whitespace from doctor names
SELECT doctor_id, TRIM(name) AS clean_doctor_name
FROM Doctors;

-- Task 10: Replace missing phone numbers
SELECT patient_id, COALESCE(NULLIF(TRIM(phone_number), ''), 'Not Available') AS phone_number
FROM Patients;

-- Task 11: Rank doctors by number of patients treated (completed appointments)
SELECT d.doctor_id, d.name AS doctor_name,
       COUNT(DISTINCT a.patient_id) AS patients_treated,
       RANK() OVER (ORDER BY COUNT(DISTINCT a.patient_id) DESC) AS doc_rank
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id AND a.status = 'Completed'
GROUP BY d.doctor_id, d.name;

-- Task 11: Cumulative revenue per month (paid invoices only)
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
       SUM(amount) AS monthly_revenue,
       SUM(SUM(amount)) OVER (ORDER BY DATE_FORMAT(payment_date, '%Y-%m')) AS cumulative_revenue
FROM Billing
WHERE payment_status = 'Paid'
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY month;

-- Task 11: Running total of appointments
SELECT appointment_id, appointment_date,
       COUNT(*) OVER (ORDER BY appointment_date, appointment_id
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM Appointments;

-- Task 12: Patient risk level (patients with no records count as Low)
SELECT p.patient_id, p.name, COUNT(m.record_id) AS record_count,
       CASE
           WHEN COUNT(m.record_id) > 5 THEN 'High'
           WHEN COUNT(m.record_id) BETWEEN 3 AND 5 THEN 'Medium'
           ELSE 'Low'
       END AS Patient_Risk_Level
FROM Patients p
LEFT JOIN Medical_Records m ON p.patient_id = m.patient_id
GROUP BY p.patient_id, p.name;

-- Task 12: Add years of experience to doctors
ALTER TABLE Doctors
ADD COLUMN years_of_experience INT NOT NULL DEFAULT 0;

-- Task 12: Fill sample experience values
UPDATE Doctors
SET years_of_experience = CASE doctor_id
    WHEN 1 THEN 18  WHEN 2 THEN 12  WHEN 3 THEN 8   WHEN 4 THEN 3   WHEN 5 THEN 16
    WHEN 6 THEN 20  WHEN 7 THEN 6   WHEN 8 THEN 10  WHEN 9 THEN 14  WHEN 10 THEN 4
    WHEN 11 THEN 22 WHEN 12 THEN 9  WHEN 13 THEN 5  WHEN 14 THEN 2  WHEN 15 THEN 15
END
WHERE doctor_id > 0;

-- Task 12: Categorize doctors by experience
SELECT doctor_id, name AS doctor_name, years_of_experience,
       CASE
           WHEN years_of_experience > 15 THEN 'Senior'
           WHEN years_of_experience BETWEEN 5 AND 15 THEN 'Mid-Level'
           ELSE 'Junior'
       END AS Experience_Level
FROM Doctors;

-- Task 1: Delete cancelled appointments older than 6 months
-- (run last: this also deletes their invoices because of ON DELETE CASCADE)
DELETE FROM Appointments
WHERE status = 'Cancelled'
  AND appointment_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
