insert into patient values (1, 'ricky', 'fonte da vaca');
insert into patient values (2, 'ze', 'almada');
insert into patient values (3, 'tomas', 'alameda');
insert into patient values (4, 'nabais', 'telheiras');
insert into period values ('2015-11-11', '2999-11-11');
insert into period values ('2015-11-10', '2999-11-10');
insert into period values ('2015-11-11', '2015-11-16');
insert into period values ('2015-11-17', '2999-11-17');
insert into period values ('2015-11-10', '2015-11-17');
insert into period values ('2015-11-18', '2999-11-18');

insert into pan values ('pan1', 999);
insert into pan values ('pan2', 999);
insert into pan values ('pan3', 999);

insert into wears values ('2015-11-10', '2999-11-10', 2, 'pan1');	
insert into wears values ('2015-11-11', '2999-11-11', 1, 'pan2');
update wears set wears_start = '2015-11-11', wears_end = '2015-11-16' where wears_patient = 1 and wears_pan = 'pan2';
insert into wears values ('2015-11-17', '2999-11-17', 1, 'pan3');
update wears set wears_start = '2015-11-10', wears_end = '2015-11-17' where wears_patient = 2 and wears_pan = 'pan1';
insert into wears values ('2015-11-18', '2999-11-18', 2, 'pan2');
