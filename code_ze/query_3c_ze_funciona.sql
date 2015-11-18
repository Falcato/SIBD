/* Base para query c) */
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
insert into period values ('2013-11-03', '2013-11-04');
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
insert into wears values ('2013-11-03', '2013-11-04', 3, 'pan3');
insert into wears values ('2015-11-04', '2999-11-12', 4, 'pan4');

select * from connects;
select * from pan;
select * from wears;
select * from device;

/* Query c): Que fabricantes tiveram dispositivos, balanças, utilizados no ultimo ano?*/

select distinct device_manufacturer /* DIstinct porque para uma marca existem aparelhos diferentes com wears_end dates diferentes no ultimo ano */
from device
	join connects
	join pan
		on pan_domain = connects_pan
	join wears
		on wears_pan = pan_domain
where description = 'scale'
and connects_manuf = device_manufacturer
and connects_snum = device_serialnum
and wears_end > DATE_SUB(CURDATE(), INTERVAL 12 MONTH)

