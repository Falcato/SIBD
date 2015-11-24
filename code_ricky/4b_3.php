<html>
	<body>
		<form action="site_b.php" method="post">
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
			//RETRIEVE VARIABLES FROM LAST PHP WEBPAGE
			$patient = $_POST['number'];
			$pan_ant = $_POST['pan_hidden'];			
			$pan_actual2 = $_POST['pan_actual_hidden'];

			if( (!empty($_POST['Device']))  ) {
				    foreach($_POST['Device'] as $check) {
				    	$teste = explode('|',$check);
				    		//FIND THE CONNECTION PERIOD BETWEEN A DEVICE AND A PATIENT
	            			$sql_descobre = "select connects_start, connects_end
	            							from connects, patient			
											where patient_number = '$patient'
											and connects_pan = '$pan_ant'
											and connects_snum = '$teste[0]'
											and connects_manuf = '$teste[1]' ";

							$sql1 = $connection->query($sql_descobre);
							foreach ($sql1 as $row) {
								$start = $row['connects_start'];
								$end = $row['connects_end'];
							}
							//INSERTING NEW PERIOD FOR THE TRANSFERED DEVICE TO THE CURRENT PAN																	
				          	$sql_transf = "insert into period values (CURDATE(), '2999-12-31')";
				          	$result = $connection->query($sql_transf);
							if ($result == FALSE){
								$info = $connection->errorInfo();
								echo("<p>Error: {$info[2]}</p>");
								//exit();
							}
							//INSERTING NEW PERIOD FOR THE DEVICE IN THE LAST PAN
				          	$sql_transf2 = "insert into period values ('$start', CURDATE())";
				          	$result = $connection->query($sql_transf2);
							if ($result == FALSE){
								$info = $connection->errorInfo();
								echo("<p>Error: {$info[2]}</p>");
								//exit();
							}
							//UPDATING CONNECTS_END FOR CURRENT DATE FOR THE DEVICE THAT WAS TRANSFERED	
				            $sql_transf3 = "update connects set connects_end = CURDATE()
				            				where connects_pan = '$pan_ant'
				           					and connects_snum = '$teste[0]'
				           					and connects_manuf = '$teste[1]' 
				           					and connects_start = '$start'
				           					and connects_end = '$end' ";       
				           	$result = $connection->query($sql_transf3);
							if ($result == FALSE){
								$info = $connection->errorInfo();
								echo("<p>Error: {$info[2]}</p>");
								//exit();
							}
							//INSERTING NEW CONNECTION FOR THE DEVICE CHANGED TO THE CURRENT PAN	
				           	$sql_transf4 = "insert into connects values (CURDATE(), '2999-12-31', '$teste[0]', '$teste[1]', '$pan_actual2')";
				           	$result = $connection->query($sql_transf4);         	
							if ($result == FALSE){
								$info = $connection->errorInfo();
								echo("<p>Error: {$info[2]}</p>");
								exit();
							}				           	
				    }
				}

		//DEVICES THAT BELONG TO THE CURRENT PAN
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
			where patient_number = '$patient'
			and connects_end like '%2999%'
			and wears_end like '%2999%'";

		$result = $connection->query($sql);
		if ($result == FALSE){
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		
		$result1 = $connection->query($sql);
		if ($result1 == FALSE){
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		$nrows = $result1->rowCount();
		//PRINTING TABLE WITH DEVICES FROM CURRENT PAN
		if ($nrows > 0){
			echo("<p>Devices from current PAN:</p>");
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
			echo("<br />");
		}	
?>
			<tr>
				<td></td>
				<td><input type="submit" value="Return"/></td>
			</tr>
		</form>
	</body>
</html>