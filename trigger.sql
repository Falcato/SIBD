
delimiter $$

create trigger check_overlapping_periods before insert on wears
for each row
begin

	if new.wears_pan = (select wears_pan from wears) and new.wears_start < (select wears_end from wears) then
		
		call pan_already_in_use();
		
	end if;

end$$

delimiter ;

