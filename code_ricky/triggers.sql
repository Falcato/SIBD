delimiter $$

create trigger check_overlapping_periods_wears_insert before insert on wears
for each row
begin

	if new.wears_pan in (select wears_pan from wears where new.wears_pan = wears_pan)
	 and new.wears_start < some (select wears_end from wears
	 where new.wears_pan = wears_pan) then
		
		call pan_already_in_use_1();
		
	end if;

end$$

create trigger check_overlapping_periods_wears_update before update on wears
for each row
begin

	if new.wears_start < some (select wears_end from wears
	 where wears_pan = new.wears_pan) and new.wears_patient != all (select wears_patient from wears 
     where new.wears_pan = wears_pan) then
		
		call pan_already_in_use_2();
		
	end if;

end$$

create trigger check_overlapping_periods_connects_insert before insert on connects
for each row
begin

	if new.connects_pan in (select connects_pan from connects where new.connects_pan = connects_pan)
	 and new.connects_start < some (select connects_end from connects
	 where new.connects_pan = connects_pan) then
		
		call pan_already_in_use_3();
		
	end if;

end$$

create trigger check_overlapping_periods_connects_update before update on connects
for each row
begin

	if new.connects_start < some (select connects_end from connects
     where connects_pan = new.connects_pan) then
		
		call pan_already_in_use_4();
		
	end if;

end$$

delimiter ;
