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
   (patient_number numeric(20),
    patient_name varchar(255),
    patient_address varchar(255),
    primary key(patient_number));

create table pan
   (pan_domain varchar(255),
    pan_phone numeric(20),
    primary key(pan_domain));

create table device
   (device_serialnum numeric(20),
    device_manufacturer varchar(255),
    description varchar(255),
    primary key(device_serialnum, device_manufacturer));

create table sensor
   (sensor_snum numeric(20),
    sensor_manuf varchar(255),
    sensor_units varchar(255),
    primary key(sensor_snum, sensor_manuf),
    foreign key(sensor_snum, sensor_manuf) references device(device_serialnum, device_manufacturer));

create table actuator
   (actuator_snum numeric(20),
    actuator_manuf varchar(255),
    actuator_units varchar(255),
    primary key(actuator_snum, actuator_manuf),
    foreign key(actuator_snum, actuator_manuf) references device(device_serialnum, device_manufacturer));

create table municipality
   (municipality_nut4code numeric(20),
    municipality_name varchar(255),
    primary key(municipality_nut4code));

create table period
   (period_start date,
    period_end date,
    primary key(period_start, period_end));

create table reading
   (reading_snum numeric(20),
    reading_manuf varchar(255),
    reading_datetime timestamp,
    reading_value numeric(20,2),
    primary key(reading_snum, reading_manuf, reading_datetime),
    foreign key(reading_snum, reading_manuf) references sensor(sensor_snum, sensor_manuf));

create table setting
   (setting_snum numeric(20),
    setting_manuf varchar(255),
    setting_datetime timestamp,
    setting_value numeric(20,2),
    primary key(setting_snum, setting_manuf, setting_datetime),
    foreign key(setting_snum, setting_manuf) references actuator(actuator_snum, actuator_manuf));

create table wears
   (wears_start date,
    wears_end date,
    wears_patient numeric(20),
    wears_pan varchar(255),
    primary key(wears_start, wears_end, wears_patient),
    foreign key(wears_start, wears_end) references period(period_start, period_end),
    foreign key(wears_patient) references patient(patient_number),
    foreign key(wears_pan) references pan(pan_domain));

create table lives
   (lives_start date,
    lives_end date,
    lives_patient numeric(20),
    lives_muni numeric(20),
    primary key(lives_start, lives_end, lives_patient),
    foreign key(lives_start, lives_end) references period(period_start, period_end),
    foreign key(lives_patient) references patient(patient_number),
    foreign key(lives_muni) references municipality(municipality_nut4code));

create table connects
   (connects_start date,
    connects_end date,
    connects_snum numeric(20),
    connects_manuf varchar(255),
    connects_pan varchar(255),
    primary key(connects_start, connects_end, connects_snum, connects_manuf),
    foreign key(connects_start, connects_end) references period(period_start, period_end),
    foreign key(connects_snum, connects_manuf) references device(device_serialnum, device_manufacturer),
    foreign key(connects_pan) references pan(pan_domain));



delimiter $$

create trigger check_overlapping_periods_wears_insert before insert on wears
for each row
begin

	if new.wears_pan in (select wears_pan from wears where new.wears_pan = wears_pan)
	 and new.wears_start < some (select wears_end from wears
	 where new.wears_pan = wears_pan) then
		
		call pan_already_in_use();
		
	end if;

end$$

create trigger check_overlapping_periods_wears_update before update on wears
for each row
begin

	if new.wears_start < some (select wears_end from wears
	 where wears_pan = new.wears_pan) then
		
		call pan_already_in_use();
		
	end if;

end$$

create trigger check_overlapping_periods_connects_insert before insert on connects
for each row
begin

	if new.connects_pan in (select connects_pan from connects where new.connects_pan = connects_pan)
	 and new.connects_start < some (select connects_end from connects
	 where new.connects_pan = connects_pan) then
		
		call pan_already_in_use();
		
	end if;

end$$

create trigger check_overlapping_periods_connects_update before update on connects
for each row
begin

	if new.connects_pan = (select connects_pan from connects) and new.connects_start < (select connects_end from connects) then
		
		call pan_already_in_use();
		
	end if;

end$$

delimiter ;

insert into patient values (1, 'ricky', 'fonte da vaca');
insert into patient values (2, 'ze', 'almada');
insert into period values ('2015-11-21', '2015-11-25');
insert into period values ('2015-11-22', '2015-11-26');
/*insert into period values ('2015-11-17', '2015-11-20');*/
insert into pan values ('pan1', 999);
insert into pan values ('pan2', 999);
insert into wears values ('2015-11-21', '2015-11-25', 1, 'pan2');
insert into wears values ('2015-11-22', '2015-11-26', 2, 'pan1');
/*insert into wears values ('2015-11-17', '2015-11-20', 2, 'pan1');*/
