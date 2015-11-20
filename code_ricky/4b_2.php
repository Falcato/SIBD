<html>
	<body>
<?php
$host = "db.ist.utl.pt";
		$user = "ist175757";
		$pass = "jcfs1855";
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

		$patient_request = $_REQUEST['patient_SIDN'];
		$sql = "select device_serialnum, device_manufacturer, description
			from connects 
				join pan 
					on connects_pan = pan_domain
				join device
					on device_serialnum = connects_snum
				join wears 
					on wears_pan = pan_domain
				join patient
					on patient_number = wears_patient
			where patient_number = '$patient_request'
			and connects_end like '%2999%'
			and wears_end like '%2999%'";

		$result = $connection->query($sql);
		if ($result == FALSE){
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		
		$result1 = $connection->query($sql);
		$nrows = $result1->rowCount();
		
		if ($nrows >0){
			echo("<table border=\"1\">");
			echo("<tr><td>Serial Number</td><td>Manufacturer</td><td>Description</td></tr>");
			foreach($result as $row){
					echo("<tr><td>");
					echo($row['device_serialnum']);
					echo("</td><td>");
					echo($row['device_manufacturer']);
					echo("</td><td>");
					echo($row['description']);
					echo("</td></tr>");
			}
			echo("</table>");
		}
	$connection = null;
?>
	</body>
</html>