delimiter $$

create trigger check_overlapping_periods_wears_insert before insert on wears
for each row
begin

	if new.start < some (select wears.end from wears where new.pan = wears.pan)	
	 and new.pan in (select wears.pan from wears where new.pan = wears.pan) then

		call pan_already_in_use_1();
		
	end if;

end$$

create trigger check_overlapping_periods_wears_update before update on wears
for each row
begin

	if (new.start < some (select wears.end from wears where wears.patient != new.patient and  wears.pan = new.pan) 
		and new.end > some (select wears.start from wears where wears.patient != new.patient and wears.pan = new.pan))
	or (new.end > some (select wears.start from wears where wears.patient != new.patient and  wears.pan = new.pan) 
		and new.start < some (select wears.end from wears where wears.patient != new.patient and wears.pan = new.pan)) then
		
		call pan_already_in_use_2();
		
	end if;

end$$

create trigger check_overlapping_periods_connects_insert before insert on connects
for each row
begin

	if new.start < some (select connects.end from connects where new.snum = connects.snum and new.manuf = connects.manuf) then 
		call pan_already_in_use_3();
		
	end if;

end$$

create trigger check_overlapping_periods_connects_update before update on connects
for each row
begin

	if (new.start < some (select connects.end from connects 
			where new.snum = connects.snum and new.manuf = connects.manuf and new.pan != connects.pan)
		and new.end > some (select connects.start from connects 
			where new.snum = connects.snum and new.manuf = connects.manuf and new.pan != connects.pan))
	or (new.end > some (select connects.start from connects 
			where new.snum = connects.snum and new.manuf = connects.manuf and new.pan != connects.pan)
		and new.start < some (select connects.end from connects 
			where new.snum = connects.snum and new.manuf = connects.manuf and new.pan != connects.pan)) then
		
		call pan_already_in_use_4();
		
	end if;

end$$

delimiter ;
