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

		$patient_request = $_REQUEST['patient_number'];

		$sql_pan = "select wears_pan from wears
					where '$patient_request' = wears_patient";

		$result_pan = $connection->query($sql_pan);
		$nrows = $result_pan->ROWCOUNT();
		if($nrows <= 0){
			echo("<p>Error: There is no PAN associated with that patient.</p>");
			exit();
		}

		/*QUERY DEVICES ACTUAL PAN*/

		$sql_devices = "select device_serialnum, device_manufacturer
					from device, wears, connects
					where wears_patient = '$patient_request'
					and wears_end > CURDATE()
					and connects_pan = wears_pan
					and connects_end > CURDATE()
					and device_serialnum = connects_snum
					and device_manufacturer = connects_manuf";

		$result = $connection->query($sql_devices);
		if ($result == FALSE){
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}

		$nrows = $result->ROWCOUNT();
		if($nrows <= 0){
			echo("<p>Error: There are no medical devices associated with that PAN.</p>");
			exit();
		}


		echo("<table border=\"1\">");
		echo("Devices on Actual PAN");
		echo("<tr><td>Serial Number</td><td>Manufacturer</td>");
		foreach($result as $row){
				echo("<tr><td>");
				echo($row['device_serialnum']);
				echo("</td><td>");
				echo($row['device_manufacturer']);
				echo("</td></tr>");
		}
		echo("</table>");


		/*QUERY DEVICES LAST PAN*/

		$sql_devices_last = "select connects_snum, connects_manuf
					from wears, connects
					where wears_patient = '$patient_request'
					and wears_end < CURDATE()
					and connects_pan = wears_pan
					and connects_end > CURDATE()";

		$result = $connection->query($sql_devices_last);
		if ($result == FALSE){
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}

		$nrows = $result->ROWCOUNT();
		if($nrows <= 0){
			echo("<p>Error: There are no medical devices currently associated with the last PAN of this patient.</p>");
			exit();
		}


		echo("<table border=\"1\">");
		echo("Devices on Last PAN");
		echo("<tr><td>Serial Number</td><td>Manufacturer</td>");
		foreach($result as $row){
				echo("<tr><td>");
				echo($row['device_serialnum']);
				echo("</td><td>");
				echo($row['device_manufacturer']);
				echo("</td></tr>");
		}
		echo("</table>");


			$connection = null;
?>
	</body>
</html>
