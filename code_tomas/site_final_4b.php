<html>
	<body>
		<form action="site_b_1.php" method="post">
			<fieldset>

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

					$patient_request = $_POST['patient_number_hidden'];
					$last_pan_request = $_POST['last_pan_hidden'];
					$current_pan_request = $_POST['current_pan_hidden'];					

					if( (!empty($_POST['device']))  ) {
					    foreach($_POST['device'] as $check) {
					    	$device = explode('|',$check);

							/*RETIRAR TEMPOS DE INCIO E FIM DE UM CERTO DISPOSITIVO QUE VAI SER TROCADO*/
							$sql_times = "select connects.start, connects.end
									from wears, connects
									where patient = '$patient_request'
									and connects.pan = '$last_pan_request'
									and connects.pan = wears.pan
									and snum = '$device[0]'
									and manuf = '$device[1]'";

							$result_times = $connection->query($sql_times);
							
							if ($result_times == FALSE){
								$info = $connection->errorInfo();
								echo("<p>Error: {$info[2]}</p>");
								exit();
							}
							foreach($result_times as $row){
								$start = $row['start'];
								$end = $row['end'];	
							}

							//QUERIES PARA A ALTERAÇÃO DE CADA DEVICE
							$sql_insert_periods_1 = "insert into period values ('$start', CURDATE())";
							$result1 = $connection->query($sql_insert_periods_1);
							
							$sql_insert_periods_2 = "insert into period values (CURDATE(), '2999-12-31')";
							$result2 = $connection->query($sql_insert_periods_2);
							
							$sql_update = "update connects set end = CURDATE()
										where snum = '$device[0]'
										and manuf = '$device[1]'
										and start = '$start'
										and end = '$end'";
							$result3 = $connection->query($sql_update);
							
							$sql_insert_device = "insert into connects values (CURDATE(), '2999-12-31', '$device[0]', '$device[1]', '$current_pan_request')";
							$result4 = $connection->query($sql_insert_device);
						

						}
					}

					/*DEVICES NA PAN ACTUAL ACTUALIZADA*/

					$sql_devices = "select serialnum, manufacturer, description
								from device, wears, connects
								where wears.patient = '$patient_request'
								and wears.end > CURDATE()
								and connects.pan = wears.pan
								and connects.end > CURDATE()
								and device.serialnum = connects.snum
								and device.manufacturer = connects.manuf";
					
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
					echo("<tr><td>Serial Number</td><td>Manufacturer</td><td>Description</td>");
					foreach($result as $row){
							echo("<tr><td>");
							echo($row['serialnum']);
							echo("</td><td>");
							echo($row['manufacturer']);
							echo("</td><td>");
							echo($row['description']);
							echo("</td></tr>");
					}
					echo("</table>");
					echo("<br/>");


					$connection = null;
				?>
		
				<tr>
					<td></td>
					<td><input type="Submit" value="Return"/></td>
				</tr>

			</fieldset>
		</form>
	</body>
</html>