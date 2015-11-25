drop table if exists connects;
drop table if exists lives;
drop table if exists wears;
drop table if exists setting;
drop table if exists reading;
drop table if exists sensor;
drop table if exists actuator;
drop table if exists municipality;
drop table if exists period;
drop table if exists device;
drop table if exists pan;
drop table if exists patient;

create table patient
   (number numeric(20),
    name varchar(255),
    address varchar(255),
    primary key(number));

create table pan
   (domain varchar(255),
    phone numeric(20),
    primary key(domain));

create table device
   (serialnum numeric(20),
    manufacturer varchar(255),
    description varchar(255),
    primary key(serialnum, manufacturer));

create table sensor
   (snum numeric(20),
    manuf varchar(255),
    units varchar(255),
    primary key(snum, manuf),
    foreign key(snum, manuf) references device(serialnum, manufacturer));

create table actuator
   (snum numeric(20),
    manuf varchar(255),
    units varchar(255),
    primary key(snum, manuf),
    foreign key(snum, manuf) references device(serialnum, manufacturer));

create table municipality
   (nut4code numeric(20),
    name varchar(255),
    primary key(nut4code));

create table period
   (start date,
    end date,
    primary key(start, end));

create table reading
   (snum numeric(20),
    manuf varchar(255),
    datetime timestamp,
    value numeric(20,2),
    primary key(snum, manuf, datetime),
    foreign key(snum, manuf) references sensor(snum, manuf));

create table setting
   (snum numeric(20),
    manuf varchar(255),
    datetime timestamp,
    value numeric(20,2),
    primary key(snum, manuf, datetime),
    foreign key(snum, manuf) references actuator(snum, manuf));

create table wears
   (start date,
    end date,
    patient numeric(20),
    pan varchar(255),
    primary key(start, end, patient),
    foreign key(start, end) references period(start, end),
    foreign key(patient) references patient(number),
    foreign key(pan) references pan(domain));

create table lives
   (start date,
    end date,
    patient numeric(20),
    muni numeric(20),
    primary key(start, end, patient),
    foreign key(start, end) references period(start, end),
    foreign key(patient) references patient(number),
    foreign key(muni) references municipality(nut4code));

create table connects
   (start date,
    end date,
    snum numeric(20),
    manuf varchar(255),
    pan varchar(255),
    primary key(start, end, snum, manuf),
    foreign key(start, end) references period(start, end),
    foreign key(snum, manuf) references device(serialnum, manufacturer),
    foreign key(pan) references pan(domain));