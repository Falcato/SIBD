<html>
	<body>
		<form action="4b_3.php" method="post"> 
		<p>
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
		$patient_ = $_REQUEST['patient_number'];
		$patient_request2 = $_REQUEST['patient_number'];
		$sql_0 = "select wears_pan from wears where wears_patient = '$patient_request2' and wears_end like '%2999%'";
			$sql_pan = $connection->query($sql_0);
			foreach ($sql_pan as $row){
				$pan_actual = $row['wears_pan'];
			}
 		
 		echo"<input type='hidden' name='pan_actual_hidden' value='$pan_actual'/>";
 		echo"<input type='hidden' name='number' value='$patient_request2'/>";
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
			where patient_number = '$patient_'
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
		
		if ($nrows > 0){
			echo("<p>Devices from current PAN:</p>");
			echo("<table border=\"1\">");
			echo("<tr><td>Serial Number</td><td>Manufacturer</td><td>Description</td></tr>");
			foreach($result as $row1){
					echo("<tr><td>");
					echo($row1['device_serialnum']);
					echo("</td><td>");
					echo($row1['device_manufacturer']);
					echo("</td><td>");
					echo($row1['description']);
					echo("</td></tr>");
			}
			echo("</table>");
			echo("<br />");
		}
		//DEVICES THAT BELONG TO THE PREVIOUS PAN
		$sql2 = "select device_serialnum, device_manufacturer, description, wears_pan
						from connects, device, wears			
						where wears_patient = '$patient_'
						and wears_end < CURDATE() and wears_end >= all
						(select wears_end from wears where wears_end < CURDATE())
						and connects_pan = wears_pan
						and device_serialnum = connects_snum
						and device_manufacturer = connects_manuf";


		$result2 = $connection->query($sql2);
		$nrows2 = $result2->rowCount();

		if ($nrows2 > 0 and $nrows > 0){
		
			echo("Choose one or more device(s):");
			echo("<br />");
					$result3 = $connection->query($sql2);
			foreach($result3 as $row){
					$manufacturer = $row['device_manufacturer'];
					$device_serialnum = $row['device_serialnum'];
					$descrip = $row['description'];
					$pan_last = $row['wears_pan'];

					$sql_pan_device = "select connects_pan
						from connects
						where connects_end >= all
						(select connects_end from connects)
						and connects_end > CURDATE()
						and connects_snum = '$device_serialnum'
						and connects_manuf = '$manufacturer'";
	
				$result_pan_device = $connection->query($sql_pan_device);
				echo("<p>Error: $pan_actual</p>");
				foreach($result_pan_device as $row_pan_device){
						$current_pan_device = $row_pan_device['connects_pan'];
						echo var_dump($row_pan_device['connects_pan'])."<br/>";
						echo("<p>111111: $current_pan_device</p>");
				}
					if( $pan_actual != $current_pan_device ){
						echo"<input type='checkbox' name='Device[]' value='$device_serialnum|$manufacturer'>  $device_serialnum - $manufacturer - $descrip <br />";
					}
			}

			echo"<input type='hidden' name='pan_hidden' value='$pan_last'/>";
		}elseif ($nrows2 == 0 and $nrows > 0){			
			echo("<p>There  no previous PAN/devices connected to this patient</p>");
		}elseif ($nrows2 == 0 and $nrows == 0){
			echo("<p>There is no record of a connection between this patient and one or more PAN(s)</p>");
		}elseif ($nrows2 > 0 and $nrows == 0) {
			echo("<p>There is no current PAN connected to this patient</p>");
		}
		$connection = null;
?>		
 			</select>
 			</p>
 			<p><input type="submit" value="Submit"/></p>
		</form>
	</body>
</html>