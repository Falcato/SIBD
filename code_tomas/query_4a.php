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

		$sql_readings = "select patient.number, name, serialnum, manufacturer, 
				value, units, datetime
				
				from reading
					join sensor
					join device
					join connects
					join pan
						on domain = connects.pan
					join wears
						on domain = wears.pan
					join patient
						on wears.patient = patient.number

				where patient.name like '%$patient_request%'
				and date(reading.datetime) between wears.start and wears.end
				and reading.snum = device.serialnum
				and reading.manuf = device.manufacturer	
				and connects.manuf = device.manufacturer
				and connects.snum = device.serialnum 
				and sensor.manuf = device.manufacturer
				and sensor.snum = device.serialnum";

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
				echo($row['number']);
				echo("</td><td>");
				echo($row['name']);
				echo("</td><td>");
				echo($row['serialnum']);
				echo("</td><td>");				
				echo($row['manufacturer']);
				echo("</td><td>");
				echo($row['value']);
				echo("</td><td>");
				echo($row['units']);
				echo("</td><td>");
				echo($row['datetime']);
				echo("</td></tr>");
		}
		echo("</table>");

		echo("<br />");
		echo("<br />");

		/*tabela settings*/
		
		$sql_settings = "select patient.number, patient.name, device.serialnum, device.manufacturer, 
				setting.value, actuator.units, setting.datetime
				
				from setting
					join actuator
					join device
					join connects
					join pan
						on pan.domain = connects.pan
					join wears
						on pan.domain = wears.pan
					join patient
						on wears.patient = patient.number

				where patient.name like '%$patient_request%'
				and date(setting.datetime) between wears.start and wears.end
				and setting.snum = device.serialnum
				and setting.manuf = device.manufacturer	
				and connects.manuf = device.manufacturer
				and connects.snum = device.serialnum 
				and actuator.manuf = device.manufacturer
				and actuator.snum = device.serialnum";
				
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
				echo($row['number']);
				echo("</td><td>");
				echo($row['name']);
				echo("</td><td>");
				echo($row['serialnum']);
				echo("</td><td>");				
				echo($row['manufacturer']);
				echo("</td><td>");
				echo($row['value']);
				echo("</td><td>");
				echo($row['units']);
				echo("</td><td>");
				echo($row['datetime']);
				echo("</td></tr>");
		}
		echo("</table>");


	$connection = null;
?>
	</body>
</html>
