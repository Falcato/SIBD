insert into patient values (1, 'ricardo miranda', 'rua das vacas');
insert into patient values (2, 'ze', 'rua do barnabe');
insert into patient values (3, 'tomas', 'rua da alameda');
insert into patient values (4, 'ricardo', 'rua de telheiras');
insert into patient values (5, 'catarina', 'aveiro');

insert into municipality values (11111, 'lisboa');
insert into municipality values (22222, 'almada');
insert into municipality values (33333, 'peniche');
insert into municipality values (44444, 'nazare');
insert into municipality values (55555, 'fonte da vaca');
insert into period values ('2010-01-01', '2010-12-31');
insert into period values ('2011-01-01', '2011-12-31');
insert into period values ('2012-01-01', '2999-12-31');
insert into lives values ('2010-01-01', '2010-12-31',1,11111); 
insert into lives values ('2011-01-01', '2011-12-31',1,33333); 
insert into lives values ('2012-01-01', '2999-12-31',1,55555); 
insert into lives values ('2012-01-01', '2999-12-31',2,22222); 
insert into lives values ('2012-01-01', '2999-12-31',3,11111);	
insert into lives values ('2012-01-01', '2999-12-31',4,11111);	

insert into period values ('2014-11-21', '2014-11-25');		 
insert into period values ('2015-11-10', '2015-11-12');
insert into device values (11,'siemens', 'blood pressure');
insert into device values (77,'philips', 'blood pressure');
insert into device values (22,'electrolux', 'insulin pump');
insert into device values (33,'philips', 'insulin pump');
insert into device values (44,'philips', 'insulin pump');
insert into device values (55,'nokia', 'blood pressure');
insert into device values (66,'philips', 'insulin pump');
insert into sensor values (11,'siemens', 'mm Hg');
insert into sensor values (33,'philips', 'mm Hg');
insert into sensor values (55,'nokia', 'mm Hg');
insert into sensor values (77,'philips', 'mm Hg');
insert into actuator values (44,'philips', 'rpm');

insert into pan values ('pan1', 999);
insert into pan values ('pan2', 999);
insert into pan values ('pan3', 999);
insert into pan values ('pan4', 999);
insert into pan values ('pan5', 999);


insert into period values ('2012-01-01', '2015-03-30');
insert into period values ('2015-03-30', '2999-12-31');
insert into period values ('2015-03-30', '2015-05-30');
insert into period values ('2015-05-31', '2999-05-31');


insert into period values ('2012-01-01', '2015-11-17');
insert into period values ('2015-11-17', '2999-12-31');

insert into connects values ('2012-01-01', '2999-12-31', 55, 'nokia', 'pan3');
insert into connects values ('2012-01-01', '2999-12-31', 77, 'philips', 'pan3'); 
insert into connects values ('2012-01-01', '2999-12-31', 44, 'philips', 'pan3');
insert into connects values ('2012-01-01', '2999-12-31', 33, 'philips', 'pan3');
insert into connects values ('2012-01-01', '2999-12-31', 11, 'siemens', 'pan5');
update connects set connects.end = '2015-11-17' where connects.snum = 55 and connects.manuf = 'nokia'; 
insert into connects values ('2015-11-17', '2999-12-31', 55, 'nokia', 'pan2');


insert into wears values ('2012-01-01', '2999-12-31', 3, 'pan1');
insert into wears values ('2012-01-01', '2999-12-31', 2, 'pan3');
insert into wears values ('2012-01-01', '2999-12-31', 4, 'pan2');
insert into wears values ('2012-01-01', '2999-12-31', 1, 'pan5');


insert into period values ('2015-06-30', '2999-05-31');



update wears set wears.end = '2015-03-30' where wears.patient = 2 and wears.pan = 'pan3';
update wears set wears.end = '2015-03-30' where wears.patient = 4 and wears.pan = 'pan2';
insert into wears values ('2015-03-30', '2999-12-31', 4, 'pan3');
update wears set wears.end = '2015-05-30' where wears.patient = 4 and wears.pan = 'pan3';


/*EXEMPLO 1*/

insert into wears values ('2015-05-31', '2999-05-31', 2, 'pan3');
insert into connects values ('2015-05-31', '2999-05-31', 66, 'philips', 'pan3');



/*EXEMPLO 2*/
insert into period values ('2012-01-01', '2015-06-10');
insert into period values ('2015-06-11', '2999-12-31');
update connects set connects.end = '2015-06-10' where connects.snum = 33 and connects.manuf = 'philips' and connects.start = '2012-01-01'; 
insert into connects values ('2015-06-11', '2999-12-31', 33, 'philips', 'pan1'); /*COMENTAR PARA O 33 NAO SER TRANSFERIDO E APARECER NO QUERY*/
/*FIM DO EXEMPLO 2*/


insert into period values ('2015-05-31', '2015-06-15');

update wears set wears.end = '2015-06-15' where wears.patient = 2 and wears.pan = 'pan3' and wears.start = '2015-05-31';

/*FIM DO EXEMPLO 1*/

insert into wears values ('2015-06-30', '2999-05-31', 4, 'pan2');

insert into reading values (11, 'siemens','2014-11-23 15:00:00' , '100');
insert into reading values (11, 'siemens','2015-11-11 00:00:01' , '10');
insert into reading values (11, 'siemens','2015-11-11 00:30:00' , '11');
insert into reading values (11, 'siemens','2015-11-11 01:00:00' , '12');
insert into reading values (11, 'siemens','2015-11-11 06:00:00' , '9'); 
insert into reading values (33, 'philips','2014-01-01 15:00:00' , '1000');
insert into reading values (55, 'nokia','2012-07-05 00:00:01' , '1');
insert into reading values (55, 'nokia','2013-05-05 00:00:01' , '2');
insert into reading values (55, 'nokia','2015-11-18 00:00:01' , '50');
insert into reading values (55, 'nokia','2015-11-18 00:00:02' , '51'); 

insert into reading values (77, 'philips','2015-04-18 00:00:01' , '700');
insert into reading values (77, 'philips','2015-11-18 00:00:01' , '701');
insert into setting values (44, 'philips','2012-07-05 00:00:01' , '2000');