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
    address varchar(255),
    primary key(patient_number));

create table pan
   (pan_domain varchar(255),
    phone numeric(20),
    primary key(pan_domain));

create table device
   (serialnum numeric(20),
    manufacturer varchar(255),
    description varchar(255),
    primary key(serialnum, manufacturer));

create table sensor
   (serialnum numeric(20),
    manufacturer varchar(255),
    units varchar(255),
    primary key(serialnum, manufacturer),
    foreign key(serialnum, manufacturer) references device(serialnum, manufacturer));

create table actuator
   (serialnum numeric(20),
    manufacturer varchar(255),
    units varchar(255),
    primary key(serialnum, manufacturer),
    foreign key(serialnum, manufacturer) references device(serialnum, manufacturer));

create table municipality
   (nut4code numeric(20),
    municipality_name varchar(255),
    primary key(nut4code));

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
    foreign key(reading_snum, reading_manuf) references sensor(serialnum, manufacturer));

create table setting
   (serialnum numeric(20),
    anufacturer varchar(255),
    setting_datetime timestamp,
    setting_value numeric(20,2),
    primary key(serialnum, manufacturer, setting_datetime),
    foreign key(setting_snum, setting_manuf) references actuator(serialnum, manufacturer));

create table wears
   (wears_start date,
    wears_end date,
    wears_patient numeric(20),
    wears_pan varchar(255),
    primary key(wears_start, wears_end, wears_patient),
    foreign key(wears_start, wears_end) references period(period_start, period_end),
    foreign key(patient_number) references patient(patient_number),
    foreign key(wears_pan) references pan(pan_domain));

create table lives
   (lives_start date,
    lives_end date,
    lives_patient numeric(20),
    nut4code numeric(20),
    primary key(lives_start, lives_end, lives_patient),
    foreign key(lives_start, lives_end) references period(period_start, period_end),
    foreign key(lives_patient) references patient(patient_number),
    foreign key(note4code) references municipality(nut4code));

create table connects
   (connects_start date,
    connects_end date,
    serialnum numeric(20),
    manufacturer varchar(255),
	pan_domain varchar(255),
    primary key(connects_start, connects_end, serialnum, manufacturer),
    foreign key(connects_start, connects_end) references period(period_start, period_end),
    foreign key(serialnum, manufacturer) references device(serialnum, manufacturer),
    foreign key(pan_domain) references pan(pan_domain));



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
insert into patient values (3, 'tomas', 'alameda');
insert into patient values (4, 'nabais', 'telheiras');
insert into period values ('2014-11-21', '2014-11-25');
insert into period values ('2015-11-10', '2015-11-12');
insert into device values (11,'rip curl', 'blood pressure');
insert into device values (22,'billabong', 'insulin pump');
insert into device values (33,'quicksilver', 'prancha de surf');
insert into sensor values (11,'rip curl', 'mm Hg');

/* Criei o ze ligado ao pan1, pan1 ligado ao blood_pressure.*/
/*insert into period values ('2015-11-17', '2015-11-20');*/
insert into pan values ('pan1', 999);
insert into pan values ('pan2', 999);
insert into wears values ('2014-11-21', '2014-11-25', 1, 'pan2');
insert into wears values ('2015-11-10', '2015-11-12', 2, 'pan1');
insert into connects values ('2015-11-10', '2015-11-12', 11, 'rip curl', 'pan1');
insert into connects values ('2014-11-21', '2014-11-25', 11, 'rip curl', 'pan2');
insert into reading values (11, 'rip curl','2015-11-11 00:00:01' , '10');
insert into reading values (11, 'rip curl','2015-11-11 00:30:00' , '11',);
insert into reading values (11, 'rip curl','2015-11-11 01:00:00' , '12');
insert into reading values (11, 'rip curl','2015-11-11 06:00:00' , '9');
insert into reading values (11, 'rip curl','2014-11-23 15:00:00' , '100');
/*insert into wears values ('2015-11-17', '2015-11-20', 2, 'pan1');*/

select *
from reading
where (select patient_number from patient where patient_number=2) 
and (select 
and (select description from device where device.description='blood pressure')
and (select device_serialnum from device,sensor where device.device_serialnum = sensor.device_snum);
