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



insert into period values ('2015-11-11', '2016-11-11');
insert into period values ('2013-11-10', '2014-11-15');
insert into wears values ('2013-11-10', '2014-11-15', 2, 'pan1');
insert into wears values ('2015-11-11', '2016-11-11', 1, 'pan1');	






update wears set wears.end = '2015-11-17' where wears.patient = 1 and wears.pan = 'pan1' and wears.start = '2015-11-11';
insert into wears values ('2015-11-18', '2999-11-18', 1, 'pan2');



insert into period values ('2013-11-11', '2014-11-11');
insert into period values ('2013-11-11', '2017-12-31');

insert into connects values ('2013-11-11', '2014-11-11', 11, 'nokia', 'pan1');
insert into connects values ('2015-11-11', '2016-11-11', 11, 'nokia', 'pan2');
insert into connects values ('2015-11-11', '2016-11-11', 11, 'philips', 'pan1');	

update connects set connects.end = '2017-12-31' where connects.snum = 11 and connects.manuf = 'nokia' and connects.pan = 'pan1';

/*update connects set connects.end = '2015-11-17' where connects.snum = 11 and connects.manuf = 'nokia' and connects.pan = 'pan2' and connects.start = '2015-11-12';
insert into connects values ('2015-11-18', '2999-11-18', 11, 'philips', 'pan2');
insert into connects values ('2015-11-19', '2999-11-19', 11, 'nokia', 'pan2');*/