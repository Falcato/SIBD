drop table if exists connects;
drop table if exists lives;
drop table if exists wears;
drop table if exists setting;
drop table if exists reading;
drop table if exists sensor;
drop table if exists actuator;
drop table if exists municipality;
drop table if exists period;
drop table if exists device;
drop table if exists pan;
drop table if exists patient;

create table patient
   (patient_number numeric(20,2),
    patient_name varchar(255),
    patient_address varchar(255),
    primary key(patient_number));

create table pan
   (pan_domain varchar(255),
    pan_phone numeric(20,2),
    primary key(pan_domain));

create table device
   (device_serialnum numeric(20,2),
    device_manufacturer varchar(255),
    description varchar(255),
    primary key(device_serialnum, device_manufacturer));

create table sensor
   (sensor_snum numeric(20,2),
    sensor_manuf varchar(255),
    sensor_units varchar(255),
    primary key(sensor_snum, sensor_manuf),
    foreign key(sensor_snum, sensor_manuf) references device(device_serialnum, device_manufacturer));

create table actuator
   (actuator_snum numeric(20,2),
    actuator_manuf varchar(255),
    actuator_units varchar(255),
    primary key(actuator_snum, actuator_manuf),
    foreign key(actuator_snum, actuator_manuf) references device(device_serialnum, device_manufacturer));

create table municipality
   (municipality_nut4code numeric(20,2),
    municipality_name varchar(255),
    primary key(municipality_nut4code));

create table period
   (period_start date,
    period_end date,
    primary key(period_start, period_end));

create table reading
   (reading_snum numeric(20,2),
    reading_manuf varchar(255),
    reading_datetime timestamp,
    reading_value numeric(20,2),
    primary key(reading_snum, reading_manuf, reading_datetime),
    foreign key(reading_snum, reading_manuf) references sensor(sensor_snum, sensor_manuf));

create table setting
   (setting_snum numeric(20,2),
    setting_manuf varchar(255),
    setting_datetime timestamp,
    setting_value numeric(20,2),
    primary key(setting_snum, setting_manuf, setting_datetime),
    foreign key(setting_snum, setting_manuf) references actuator(actuator_snum, actuator_manuf));

create table wears
   (wears_start date,
    wears_end date,
    wears_patient numeric(20,2),
    wears_pan varchar(255),
    primary key(wears_start, wears_end, wears_patient, wears_pan),
    foreign key(wears_start, wears_end) references period(period_start, period_end),
    foreign key(wears_patient) references patient(patient_number),
    foreign key(wears_pan) references pan(pan_domain));

create table lives
   (lives_start date,
    lives_end date,
    lives_patient numeric(20,2),
    lives_muni numeric(20,2),
    primary key(lives_start, lives_end, lives_patient, lives_muni),
    foreign key(lives_start, lives_end) references period(period_start, period_end),
    foreign key(lives_patient) references patient(patient_number),
    foreign key(lives_muni) references municipality(municipality_nut4code));

create table connects
   (connects_start date,
    connects_end date,
    connects_snum numeric(20,2),
    connects_manuf varchar(255),
    connects_pan varchar(255),
    primary key(connects_start, connects_end, connects_snum, connects_manuf, connects_pan),
    foreign key(connects_start, connects_end) references period(period_start, period_end),
    foreign key(connects_snum, connects_manuf) references device(device_serialnum, device_manufacturer),
    foreign key(connects_pan) references pan(pan_domain));
