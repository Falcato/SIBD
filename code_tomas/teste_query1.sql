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
insert into pan values ('pan1', 999);
insert into pan values ('pan2', 999);
insert into wears values ('2014-11-21', '2014-11-25', 1, 'pan2');
insert into wears values ('2015-11-10', '2015-11-12', 2, 'pan1');
insert into connects values ('2014-11-21', '2014-11-25', 11, 'rip curl', 'pan2');
insert into connects values ('2015-11-10', '2015-11-12', 11, 'rip curl', 'pan1');
insert into reading values (11, 'rip curl','2014-11-23 15:00:00' , '100');
insert into reading values (11, 'rip curl','2015-11-11 00:00:01' , '10');
insert into reading values (11, 'rip curl','2015-11-11 00:30:00' , '11');
insert into reading values (11, 'rip curl','2015-11-11 01:00:00' , '12');
insert into reading values (11, 'rip curl','2015-11-11 06:00:00' , '9');
insert into reading values (11, 'rip curl','2015-11-11 06:30:00' , '12');


/* Query a): Ultimas leituras de um paciente c/ descrição 'blood pressure' nos ultimos 6 meses*/
select distinct reading_value, reading_datetime, patient_name
from reading, device, patient, connects, wears, pan, period
where description='blood pressure' /*like not =*/
and device_serialnum =reading_snum
and connects_snum = device_serialnum
and pan_domain = wears_pan
and wears_patient = patient_number
and reading_manuf=connects_manuf
and period_start=wears_start
and period_end=wears_end
and date(reading_datetime) between period_start and period_end
and date(reading_datetime) > DATE_SUB(now(), INTERVAL 6 MONTH)
/*and connects_pan=pan_domain*/

