insert into patient values (1, 'Ricardo Miranda', 'Rua da Fnte da Vaca');
insert into patient values (2, 'Jose Dias', 'Largo de Almada');
insert into patient values (3, 'Tomas Costa', 'Largo da Alameda');
insert into patient values (4, 'Bernardo', 'Praceta de Telheiras');
insert into patient values (5, 'Andre Martins', 'Largo da Alameda');
insert into patient values (6, 'Pedro Delgado', 'Rua de Benfica');
insert into patient values (7, 'Filipa Martins', 'Rua do Areeiro');
insert into patient values (8, 'Andre Moreira', 'Rua da Estefânia');
insert into patient values (9, 'Kishan Rama', 'Rua de Chelas');
insert into patient values (10, 'Diogo Ferreira', 'Rua de Fernão Ferro');
insert into patient values (11, 'Ricardo Dias', 'Rua de Sintra');
insert into patient values (12, 'Diogo Martins', 'Praceta de Oeiras');
insert into patient values (13, 'Joao', 'Rua do Seixal');

insert into period values ('2005-01-02', '2999-01-01');
insert into period values ('2005-01-02', '2005-02-01');
insert into period values ('2005-02-02', '2005-03-01');
insert into period values ('2005-03-02', '2005-04-01');
insert into period values ('2005-04-02', '2005-05-01');
insert into period values ('2005-05-02', '2005-06-01');
insert into period values ('2005-06-02', '2005-07-01');
insert into period values ('2005-07-02', '2005-08-01');
insert into period values ('2005-08-02', '2005-09-01');
insert into period values ('2005-09-02', '2005-10-01');
insert into period values ('2005-10-02', '2005-11-01');
insert into period values ('2005-10-02', '2015-01-01');
insert into period values ('2015-01-02', '2999-01-01');

insert into period values ('2015-01-02', '2015-09-01');
insert into period values ('2015-01-02', '2015-03-01');
insert into period values ('2015-01-02', '2015-02-01');
insert into period values ('2015-02-02', '2015-03-01');
insert into period values ('2015-03-02', '2015-04-01');
insert into period values ('2015-04-02', '2015-05-01');
insert into period values ('2015-05-02', '2015-06-01');
insert into period values ('2015-06-02', '2015-07-01');
insert into period values ('2015-06-02', '2015-11-01');
insert into period values ('2015-07-02', '2015-10-01');
insert into period values ('2015-08-02', '2015-11-01');
insert into period values ('2015-10-02', '2999-01-01');
insert into period values ('2015-10-02', '2015-11-01');
insert into period values ('2012-01-02', '2999-01-01');

insert into device values (111,'Siemens', 'blood pressure');
insert into device values (111,'Olympus', 'blood pressure');
insert into device values (111,'Philips', 'blood pressure');
insert into device values (222,'Philips', 'blood pressure');
insert into device values (222,'Olympus', 'blood pressure');
insert into device values (333,'Philips', 'scale');
insert into device values (333,'Olympus', 'scale');
insert into device values (444,'Philips', 'scale');
insert into device values (555,'Medtronic', 'scale');
insert into device values (666,'Philips', 'insulin pump');
insert into device values (667,'Philips', 'insulin pump');
insert into device values (666,'Siemens', 'insulin pump');
insert into device values (777,'Philips', 'Electronic thermometer');
insert into device values (888,'Siemens', 'Electronic thermometer');
insert into device values (889,'Siemens', 'Electronic thermometer');
insert into device values (890,'Medtronic', 'Electronic thermometer');

insert into sensor values (111,'Siemens', 'mm Hg');
insert into sensor values (111,'Olympus', 'mm Hg');
insert into sensor values (111,'Philips', 'mm Hg');
insert into sensor values (222,'Philips', 'cm Hg');
insert into sensor values (222,'Olympus', 'cm Hg');
insert into sensor values (333,'Philips', 'g');
insert into sensor values (333,'Olympus', 'kg');
insert into sensor values (444,'Philips', 'kg');
insert into sensor values (555,'Medtronic', 'kg');
insert into actuator values (666,'Philips', 'mL/h');
insert into actuator values (667,'Philips', 'mL/day');
insert into actuator values (666,'Siemens', 'mL/day');
insert into sensor values (777,'Philips', 'ºF');
insert into sensor values (888,'Siemens', 'ºF');
insert into sensor values (889,'Siemens', 'ºC');
insert into sensor values (890,'Medtronic', 'ºK');

insert into pan values ('pan1', 919999);
insert into pan values ('pan2', 919999);
insert into pan values ('pan3', 919999);
insert into pan values ('pan4', 919999);
insert into pan values ('pan5', 919999);
insert into pan values ('pan6', 919999);
insert into pan values ('pan7', 919999);
insert into pan values ('pan8', 919999);
insert into pan values ('pan9', 919999);
insert into pan values ('pan10', 919999);
insert into pan values ('pan11', 919999);
insert into pan values ('pan12', 919999);
insert into pan values ('pan13', 919999);
insert into pan values ('pan14', 919999);
insert into pan values ('pan15', 919999);
insert into pan values ('pan16', 919999);

insert into wears values ('2005-01-02', '2005-02-01',1,'pan9');
insert into wears values ('2005-02-02', '2005-03-01',2,'pan8');
insert into wears values ('2005-03-02', '2005-04-01',3,'pan7');
insert into wears values ('2005-04-02', '2005-05-01',4,'pan6');
insert into wears values ('2005-05-02', '2005-06-01',5,'pan5');
insert into wears values ('2005-01-02', '2005-02-01',5,'pan5');
insert into wears values ('2005-02-02', '2005-03-01',4,'pan6');
insert into wears values ('2005-01-02', '2999-01-01',9,'pan16');
insert into wears values ('2012-01-02', '2999-01-01',11,'pan5');
insert into wears values ('2012-01-02', '2999-01-01',12,'pan10');
insert into wears values ('2015-01-02', '2015-09-01',1,'pan1');
insert into wears values ('2015-01-02', '2015-09-01',2,'pan2');
insert into wears values ('2015-01-02', '2015-03-01',4,'pan3');
insert into wears values ('2015-10-02', '2015-11-01',6,'pan4');
insert into wears values ('2015-08-02', '2015-11-01',8,'pan3');
insert into wears values ('2015-03-02', '2015-04-01',10,'pan4');
insert into wears values ('2015-10-02', '2999-01-01',1,'pan1');



insert into connects values ('2005-01-02', '2999-01-01',111,'Philips','pan16');
insert into connects values ('2005-01-02', '2999-01-01',333,'Philips','pan16');
insert into connects values ('2005-10-02', '2015-01-01',888,'Siemens','pan16');
insert into connects values ('2015-01-02', '2015-09-01',889,'Siemens','pan16');

insert into connects values ('2015-01-02', '2015-09-01',888,'Siemens','pan1');
insert into connects values ('2015-01-02', '2015-09-01',555,'Medtronic','pan1');
insert into connects values ('2015-01-02', '2015-02-01',667,'Philips','pan1');
insert into connects values ('2015-01-02', '2015-09-01',777,'Philips','pan1');

insert into connects values ('2015-10-02', '2999-01-01',222,'Olympus','pan5');

insert into reading values (111,'Philips','2015-11-11 00:00:01' , '20');
insert into reading values (111,'Philips','2015-11-11 00:30:00' , '19');
insert into reading values (111,'Philips','2015-11-11 01:00:00' , '18');
insert into reading values (111,'Philips','2015-11-11 06:00:00' , '17');
insert into reading values (111,'Philips','2015-01-01 15:00:00' , '50');

insert into reading values (333,'Philips','2015-11-11 00:00:01' , '200');
insert into reading values (333,'Philips','2015-11-11 00:30:00' , '190');
insert into reading values (333,'Philips','2015-11-11 01:00:00' , '180');
insert into reading values (333,'Philips','2015-11-11 06:00:00' , '170');
insert into reading values (333,'Philips','2015-01-01 15:00:00' , '500');

insert into setting values (667,'Philips','2015-01-11 03:00:01' , '2000');
insert into setting values (667,'Philips','2015-01-12 04:30:00' , '1900');

insert into reading values (888,'Siemens','2014-01-11 15:00:01' , '20000');
insert into reading values (888,'Siemens','2014-01-12 16:30:00' , '19000');
insert into reading values (888,'Siemens','2014-11-13 17:00:00' , '18000');

insert into reading values (555,'Medtronic','2015-08-01 17:00:00' , '1');
insert into reading values (555,'Medtronic','2015-08-02 18:00:00' , '2');
insert into reading values (777,'Philips','2015-08-01 17:00:00' , '3');	

