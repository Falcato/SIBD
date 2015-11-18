/* Base para query */
insert into patient values (1, 'ricky', 'fonte da vaca');
insert into patient values (2, 'ze', 'almada');
insert into patient values (3, 'tomas', 'alameda');
insert into patient values (4, 'nabais', 'telheiras');
insert into period values ('2014-11-21', '2014-11-25');
insert into period values ('2015-10-10', '2015-10-12');
insert into device values (11,'Philips', 'scale');
insert into device values (15,'Deeply', 'fato de surf');
insert into device values (16,'VS', 'scale');
insert into device values (22,'billabong', 'insulin pump');
insert into device values (33,'Quick Silver', 'scale');
insert into sensor values (11,'Philips', 'mm Hg');


insert into pan values ('pan1', 991);
insert into pan values ('pan2', 992);
insert into wears values ('2014-11-21', '2014-11-25', 1, 'pan2');
insert into wears values ('2015-10-10', '2015-10-12', 2, 'pan1');
insert into connects values ('2014-11-21', '2014-11-25', 15, 'Deeply', 'pan2');
insert into connects values ('2015-10-10', '2015-10-12', 16, 'VS', 'pan1');

insert into device values (44,'Philips', 'prancha de bodyboard');
insert into device values (12,'Philips', 'prancha de bodyboard2');
insert into device values (13,'Siemens', 'scale');
insert into pan values ('pan3', 993);
insert into pan values ('pan4', 994);
insert into period values ('2015-11-02', '2999-11-12');
insert into period values ('2015-11-01', '2999-11-12');
insert into period values ('2015-11-03', '2999-11-12');
insert into period values ('2015-11-04', '2999-11-12');
insert into municipality values (1111, 'Palmela');
insert into municipality values (2222, 'Almada');
insert into municipality values (3333, 'Lisboa');
insert into lives values ('2015-11-01', '2999-11-12', 1, 1111);
insert into lives values ('2015-11-02', '2999-11-12', 2, 2222);
insert into lives values ('2015-11-03', '2999-11-12', 3, 3333);
insert into lives values ('2015-11-04', '2999-11-12', 4, 3333);
insert into connects values ('2015-11-01', '2999-11-12', 11, 'Philips', 'pan1');
insert into connects values ('2015-11-01', '2999-11-12', 12, 'Philips', 'pan1');
insert into connects values ('2015-11-01', '2999-11-12', 13, 'Siemens', 'pan1');
insert into connects values ('2015-11-02', '2999-11-12', 22, 'billabong', 'pan2');
insert into connects values ('2015-11-03', '2999-11-12', 33, 'Quick Silver', 'pan3');
insert into connects values ('2015-11-04', '2999-11-12', 44, 'Philips', 'pan4');
insert into wears values ('2015-11-01', '2999-11-12', 1, 'pan1');
insert into wears values ('2015-11-02', '2999-11-12', 2, 'pan2');
insert into wears values ('2015-11-03', '2999-11-12', 3, 'pan3');
insert into wears values ('2015-11-04', '2999-11-12', 4, 'pan4');

/* Query a): Ultimas leituras de um paciente c/ descrição 'blood pressure' nos ultimos 6 meses*/
select distinct reading_value, reading_datetime, patient_name
from reading, device, patient, connects,wears, pan, period
where description='blood pressure'
and device_serialnum =reading_snum
and connects_snum = device_serialnum
and pan_domain = wears_pan
and wears_patient = patient_number
and reading_snum=connects_snum
and reading_manuf=connects_manuf
and period_start=wears_start
and period_end=wears_end
and date(reading_datetime) between period_start and period_end
and date(reading_datetime) > DATE_SUB(now(), INTERVAL 6 MONTH);

