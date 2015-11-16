delimiter $$

create trigger check_overlapping_periods before insert on connects
for each row
begin

	if new.connects_pan = connects_pan and new.connects_start < connects_end then
		
		call pan_already_in_use();
		
	end if;

end$$

delimiter ;
