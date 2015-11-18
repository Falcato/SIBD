insert into patient values (1, 'ricky', 'fonte da vaca');
insert into patient values (2, 'ze', 'almada');
insert into patient values (3, 'tomas', 'alameda');
insert into patient values (4, 'nabais', 'telheiras');
insert into period values ('2014-11-21', '2014-11-25');
insert into period values ('2015-11-10', '2015-11-12');
insert into device values (11,'Philips', 'blood pressure');
insert into device values (22,'billabong', 'insulin pump');
insert into device values (33,'Philips', 'prancha de surf');
insert into sensor values (11,'Philips', 'mm Hg');

/* Criei o ze ligado ao pan1, pan1 ligado ao blood_pressure.*/
insert into pan values ('pan1', 991);
insert into pan values ('pan2', 992);
insert into wears values ('2014-11-21', '2014-11-25', 1, 'pan2');
insert into wears values ('2015-11-10', '2015-11-12', 2, 'pan1');
insert into connects values ('2014-11-21', '2014-11-25', 11, 'Philips', 'pan2');
insert into connects values ('2015-11-10', '2015-11-12', 11, 'Philips', 'pan1');

/* Base para query b) */
insert into device values (44,'Philips', 'prancha de bodyboard');
insert into pan values ('pan3', 993);
insert into pan values ('pan4', 994);
insert into period values ('2015-12-02', '2999-11-12');
insert into period values ('2015-12-01', '2999-11-12');
insert into period values ('2015-12-03', '2999-11-12');
insert into period values ('2015-12-04', '2999-11-12');
insert into municipality values (1111, 'Palmela');
insert into municipality values (2222, 'Almada');
insert into municipality values (3333, 'Lisboa');
insert into lives values ('2015-12-01', '2999-11-12', 1, 1111);
insert into lives values ('2015-12-02', '2999-11-12', 2, 2222);
insert into lives values ('2015-12-03', '2999-11-12', 3, 3333);
insert into lives values ('2015-12-04', '2999-11-12', 4, 3333);
insert into connects values ('2015-12-01', '2999-11-12', 11, 'Philips', 'pan1');
insert into connects values ('2015-12-02', '2999-11-12', 22, 'billabong', 'pan2');
insert into connects values ('2015-12-03', '2999-11-12', 33, 'Philips', 'pan3');
insert into connects values ('2015-12-04', '2999-11-12', 44, 'Philips', 'pan4');

/*insert into wears values ('2015-12-01', '2999-11-12', 1, 'pan1');
insert into wears values ('2015-12-02', '2999-11-12', 2, 'pan2');
insert into wears values ('2015-12-03', '2999-11-12', 3, 'pan3');
insert into wears values ('2015-12-04', '2999-11-12', 4, 'pan4');*/



/* Query b): Que concelho tem o maior numero de dispositivos da marca Philips activos*/

select lives_muni
from municipality, period, connects, lives
where connects_manuf = 'Philips'
and connects_end like '%2999%'
and connects_end = lives_end
group by lives_muni
order by count(lives_muni) desc 
limit 1;
