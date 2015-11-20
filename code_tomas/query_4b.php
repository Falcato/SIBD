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
		$pan_request = $_REQUEST['pan_name'];

		$sql_devices = "select device_serialnum, device_manufacturer
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

			where patient_number = '$patient_number'";

		$result = $connection->query($sql_devices);
		if ($result == FALSE){
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}


		echo("<table border=\"1\">");
		echo("<tr><td>SNum</td><td>Manuf</td>");
		foreach($result as $row){
				echo("<tr><td>");
				echo($row['device_snum']);
				echo("</td><td>");
				echo($row['device_manuf']);
				echo("</td></tr>");
		}
		echo("</table>");


			$connection = null;
?>
	</body>
</html>
