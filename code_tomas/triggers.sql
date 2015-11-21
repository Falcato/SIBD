delimiter $$

create trigger check_overlapping_periods_wears_insert before insert on wears
for each row
begin

	if new.wears_start < some (select wears_end from wears where new.wears_pan = wears_pan)	/*PERGUNTAR AO PROF SE PRECISAMOS DE VER OS TEMPOS*/
	 and new.wears_pan in (select wears_pan from wears where new.wears_pan = wears_pan) then

		call pan_already_in_use_1();
		
	end if;

end$$

create trigger check_overlapping_periods_wears_update before update on wears
for each row
begin

	if new.wears_end < some (select wears_start from wears where wears_pan = new.wears_pan)
	 and new.wears_patient != all (select wears_patient from wears where new.wears_pan = wears_pan) then
		
		call pan_already_in_use_2();
		
	end if;

end$$

create trigger check_overlapping_periods_connects_insert before insert on connects
for each row
begin

	if new.connects_start < some (select connects_end from connects where new.connects_snum = connects_snum and new.connects_manuf = connects_manuf) then 	/*PERGUNTAR AO PROF SE PRECISAMOS DE VER OS TEMPOS*/
			
		call pan_already_in_use_3();
		
	end if;

end$$

create trigger check_overlapping_periods_connects_update before update on connects
for each row
begin

	if new.connects_end < some (select connects_start from connects where new.connects_snum = connects_snum and new.connects_manuf = connects_manuf)
	 and (new.connects_snum != all (select connects_snum from connects where new.connects_pan = connects_pan)
	 or new.connects_manuf != all (select connects_manuf from connects where new.connects_pan = connects_pan)) then
		
		call pan_already_in_use_4();
		
	end if;

end$$

delimiter ;
