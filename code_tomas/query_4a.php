<html>
	<body>
<?php
		$host = "db.ist.utl.pt";
		$user = "ist175876";
		$pass = "ffar1598";
		$dsn = "mysql:host=$host;dbname=$user";
		try{
			$connection = new PDO($dsn, $user, $pass);
		}
		catch(PDOException $exception){
			echo("<p>Error: ");
			echo($exception->getMessage());
			echo("</p>");
			exit();
		}
		/*tabela dos readings*/

		$patient_request = $_REQUEST['patient_name'];

		$sql_readings = "select patient_number, patient_name, device_serialnum, device_manufacturer, 
				reading_value, sensor_units, reading_datetime
				
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

				where patient_name like '%$patient_request%'
				and date(reading_datetime) between wears_start and wears_end
				and reading_snum = device_serialnum
				and reading_manuf = device_manufacturer	
				and connects_manuf = device_manufacturer
				and connects_snum = device_serialnum 
				and sensor_manuf = device_manufacturer
				and sensor_snum = device_serialnum";
		$result = $connection->query($sql_readings);
		if ($result == FALSE){
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		echo("<table border=\"1\">");
		echo("<tr><td>Patient Number</td><td>Patient Name</td><td>Device Serial Number</td>
			<td>Device Manufacturer</td><td>Readings</td>
			<td>Units</td><td>Date Time</td></tr>");
		foreach($result as $row){
				echo("<tr><td>");
				echo($row['patient_number']);
				echo("</td><td>");
				echo($row['patient_name']);
				echo("</td><td>");
				echo($row['device_serialnum']);
				echo("</td><td>");				
				echo($row['device_manufacturer']);
				echo("</td><td>");
				echo($row['reading_value']);
				echo("</td><td>");
				echo($row['sensor_units']);
				echo("</td><td>");
				echo($row['reading_datetime']);
				echo("</td></tr>");
		}
		echo("</table>");

		echo("<br />");
		echo("<br />");

		/*tabela settings*/
		
		$sql_settings = "select patient_number, patient_name, device_serialnum, device_manufacturer, 
				setting_value, actuator_units, setting_datetime
				
				from setting
					join actuator
					join device
					join connects
					join pan
						on pan_domain = connects_pan
					join wears
						on pan_domain = wears_pan
					join patient
						on wears_patient = patient_number

				where patient_name like '%$patient_request%'
				and date(setting_datetime) between wears_start and wears_end
				and setting_snum = device_serialnum
				and setting_manuf = device_manufacturer	
				and connects_manuf = device_manufacturer
				and connects_snum = device_serialnum 
				and actuator_manuf = device_manufacturer
				and actuator_snum = device_serialnum";
		$result = $connection->query($sql_settings);
		if ($result == FALSE){
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		echo("<table border=\"1\">");
		echo("<tr><td>Patient Number</td><td>Patient Name</td><td>Device Serial Number</td>
			<td>Device Manufacturer</td><td>Settings</td>
			<td>Units</td><td>Date Time</td></tr>");
		foreach($result as $row){
				echo("<tr><td>");
				echo($row['patient_number']);
				echo("</td><td>");
				echo($row['patient_name']);
				echo("</td><td>");
				echo($row['device_serialnum']);
				echo("</td><td>");				
				echo($row['device_manufacturer']);
				echo("</td><td>");
				echo($row['setting_value']);
				echo("</td><td>");
				echo($row['actuator_units']);
				echo("</td><td>");
				echo($row['setting_datetime']);
				echo("</td></tr>");
		}
		echo("</table>");


	$connection = null;
?>
	</body>
</html>
