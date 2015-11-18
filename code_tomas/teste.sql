insert into patient values (001542451555555, 'Bernardo Gomes', 'Rua Alves Redol');
insert into patient values (001542451555575, 'Diogo Martins', 'Avenida João Crisóstomo');
insert into patient values (001547451555556, 'Diogo Proença', 'Avenida Praia da Vitória');
insert into patient values (001542451855555, 'Zé Manel', 'Avenida Duque de Ávila');

insert into pan values ('www.pan1.pt', 910000000);
insert into pan values ('www.pan2.pt', 910000001);
insert into pan values ('www.pan3.pt', 910000002);
insert into pan values ('www.pan4.pt', 910000003);

insert into device values (123456789, 'Philips', 'blood pressure');
insert into device values (123456790, 'Philips', 'insuline meter');
insert into device values (123456791, 'Philips', 'insuline meter');
insert into device values (123456789, 'RPG', 'blood pressure');
insert into device values (123456789, 'LG', 'scale');


insert into actuator values (123456790, 'Philips', 'scale');
insert into actuator values (123456791, 'Philips', 'insuline meter');

insert into sensor values (123456789, 'RPG', 'blood pressure');
insert into sensor values (123456789, 'Philips', 'blood pressure');
insert into sensor values (123456790, 'Philips', 'insuline');

insert into period values ('2015-10-26', '2015-11-26');
insert into period values ('2015-04-26', '2015-10-26');
insert into period values ('2015-05-26', '2015-11-25');
insert into period values ('2014-12-25', '2015-01-01');
insert into period values ('2015-11-25', '2015-12-01');
insert into period values ('2015-11-27', '2016-01-01');
insert into period values ('2015-04-01', '2015-10-25');
insert into period values ('2012-10-10', '2013-10-10');
insert into period values ('2012-10-10', '2014-10-10');
insert into period values ('2014-10-09', '2015-12-01');
insert into period values ('2012-10-10', '2014-11-19');
insert into period values ('2011-10-09', '2012-12-01');
insert into period values ('2015-11-26', '2016-01-01');
insert into period values ('2015-11-28', '2016-01-01');


insert into connects values ('2015-04-01', '2015-10-25', 123456789, 'RPG', 'www.pan1.pt');
insert into connects values ('2015-10-26', '2015-11-26', 123456790, 'Philips', 'www.pan1.pt');
insert into connects values ('2015-10-26', '2015-11-26', 123456789, 'Philips', 'www.pan1.pt');
insert into connects values ('2015-11-27', '2016-01-01', 123456789, 'Philips', 'www.pan3.pt');
insert into connects values ('2015-10-26', '2015-11-26', 123456789, 'LG', 'www.pan1.pt');
insert into connects values ('2012-10-10', '2013-10-10', 123456789, 'LG', 'www.pan1.pt');


/*insert into Wears values ('2014-12-25', '2015-01-01', '001-54245-1555555', 'www.pan1.pt');*/
/*insert into Wears values ('2015-04-01', '2015-10-25', '001-54245-1555555', 'www.pan1.pt');
insert into Wears values ('2015-10-26', '2015-11-26', '001-54245-1555555', 'www.pan1.pt');*/
insert into wears values ('2015-11-25', '2015-12-01', 001542451555575, 'www.pan2.pt');
insert into wears values ('2014-10-09', '2015-12-01', 001542451555555, 'www.pan1.pt');
insert into wears values ('2011-10-09', '2012-12-01', 001542451555555, 'www.pan1.pt');
insert into reading values (123456789, 'RPG', '2015-10-24 09:45:00', 45);
insert into reading values (123456789, 'Philips', '2015-01-24 09:45:00', 20);
insert into reading values (123456789, 'Philips', '2015-11-24 09:45:00', 21);
insert into reading values (123456790, 'Philips', '2015-11-24 09:45:00', 24);

insert into municipality values (2870, 'Montijo');
insert into municipality values (2890, 'Alcochete');
insert into municipality values (8125, 'Quarteira');

insert into lives values ('2012-10-10', '2014-11-19', 001542451555555, 2870);
