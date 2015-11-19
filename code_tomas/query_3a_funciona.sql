/* Query a): Ultimas leituras de um paciente c/ descrição 'blood pressure' nos ultimos 6 meses*/


select * from device;
select * from pan;
select * from wears;
select * from connects;
select * from reading;
select * from sensor;

select distinct patient_number, patient_name, reading_value, sensor_units, reading_datetime
from reading
	join sensor
	join device
	join connects
	join pan
		on pan_domain = connects_pan
	join wears
		on pan_domain = wears_pan
	join patient
		on wears_patient = patient_number

where description like '%blood pressure%'
and date(reading_datetime) > DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
and date(reading_datetime) between wears_start and wears_end  /*VERIFICAR QUE EXISTE ALGUEM A USAR A PAN NO MOMENTO DA LEITURA*/
and reading_snum = device_serialnum
and reading_manuf = device_manufacturer	
and connects_manuf = device_manufacturer
and connects_snum = device_serialnum 
and sensor_manuf = device_manufacturer
and sensor_snum = device_serialnum;
