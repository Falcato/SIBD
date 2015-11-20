insert into patient values (1, 'ricky', 'fonte da vaca');
insert into patient values (2, 'ze', 'almada');
insert into patient values (3, 'tomas', 'alameda');
insert into patient values (4, 'nabais', 'telheiras');

insert into device values (11, 'philips', 'aaaa');
insert into device values (11, 'nokia', 'aaaa');

insert into period values ('2015-11-11', '2999-11-11');
insert into period values ('2015-11-12', '2999-11-12');
insert into period values ('2015-11-11', '2015-11-17');
insert into period values ('2015-11-12', '2015-11-17');
insert into period values ('2015-11-18', '2999-11-18');
insert into period values ('2015-11-19', '2999-11-19');

insert into pan values ('pan1', 999);
insert into pan values ('pan2', 999);
insert into pan values ('pan3', 999);

insert into wears values ('2015-11-11', '2999-11-11', 1, 'pan1');	
insert into wears values ('2015-11-12', '2999-11-12', 2, 'pan2');
update wears set wears_end = '2015-11-17' where wears_patient = 1 and wears_pan = 'pan1' and wears_start = '2015-11-11';
/*insert into wears values ('2015-11-18', '2999-11-18', 1, 'pan2');*/

insert into connects values ('2015-11-11', '2999-11-11', 11, 'philips', 'pan1');	
insert into connects values ('2015-11-12', '2999-11-12', 11, 'nokia', 'pan2');
update connects set connects_end = '2015-11-17' where connects_snum = 11 and connects_manuf = 'philips' and connects_pan = 'pan1' and connects_start = '2015-11-11';
update connects set connects_end = '2015-11-17' where connects_snum = 11 and connects_manuf = 'nokia' and connects_pan = 'pan2' and connects_start = '2015-11-12';
insert into connects values ('2015-11-18', '2999-11-18', 11, 'philips', 'pan2');
insert into connects values ('2015-11-19', '2999-11-19', 11, 'nokia', 'pan2');