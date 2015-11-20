/* Query 4b)*/

/*mostrar pans que estao a ser utilizadas actualmente(ou seja, nao podem ser escolhidas?)*/
select wears_pan
from wears;

/*mostrar os pacientes que tem o nome semelhante e respectivos SIDN para escolher o correcto[4b_1]*/
select patient_name, patient_number
from patient
where patient_name like '%$patient_request%';

/*mostrar todos os dispositivos connectados a pan "actual"[4b_2]*/
select device_serialnum, device_manufacturer, description
	from connects 
	join pan 
		on connects_pan = pan_domain
	join device
		on device_serialnum = connects_snum
	join wears 
		on wears_pan = pan_domain
	join patient
		on patient_number = wears_patient
where patient_number = /*qualquer merda retornada pelo html*/
and connects_end like '%2999%'
and wears_end like '%2999%';/*periodo está como 2999, porque so depois disto é que é feita a actualizaçao do tempo*/