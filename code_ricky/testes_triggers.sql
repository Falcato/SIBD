insert into patient values (1, 'ricky', 'fonte da vaca');
insert into patient values (2, 'ze', 'almada');
insert into patient values (3, 'tomas', 'alameda');
insert into patient values (4, 'nabais', 'telheiras');
insert into period values ('2014-11-11', '2999-11-11');
insert into period values ('2015-11-10', '2999-11-10');
insert into period values ('2015-11-10', '2015-11-14');
insert into period values ('2015-11-14', '2999-11-14');

insert into pan values ('pan1', 999);
insert into pan values ('pan2', 999);
insert into pan values ('pan3', 999);
insert into wears values ('2014-11-11', '2999-11-11', 1, 'pan2');
insert into wears values ('2015-11-10', '2999-11-10', 2, 'pan1');
update wears set wears_start = '2015-11-10', wears_end = '2015-11-14' where wears_patient = 2 and wears_pan = 'pan1'; 
update wears set wears_start = '2015-11-14', wears_end = '2999-11-14', wears_pan = 'pan3' where wears_patient = 2;
