<html>
	<body>
		<form action="site_final_4b.php" method="post">
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
					$pan_request = $_POST['last_pan_hidden'];

					echo("<p>$patient_request</p>");
					echo("<p>$pan_request</p>");
					

					if( (!empty($_POST['device']))  ) {
					    foreach($_POST['device'] as $check) {
					    	$device = explode('|',$check);
					            echo ("<p>$device[0] : $device[1] </p>"); 
								
							/*RETIRAR TEMPOS DE INCIO E FIM DE UM CERTO DISPOSITIVO QUE VAI SER TROCADO*/
							$sql_times = "select connects_start, connects_end
									from wears, connects
									where wears_patient = '$patient_request'
									and wears_pan = '$pan_request'
									and connects_pan = wears_pan
									and connects_snum = '$device[0]'
									and connects_manuf = '$device[1]'";

							$result_times = $connection->query($sql_times);
							
							if ($result_times == FALSE){
								$info = $connection->errorInfo();
								echo("<p>Error: {$info[2]}</p>");
								exit();
							}
							foreach($result_times as $row){
								$start = $row['connects_start'];
								$end = $row['connects_end'];
								echo("<p>START : $start -> END : $end</p>");
					
							}

						}
					}


					/*DEVICES NA PAN ACTUAL ACTUALIZADA*/


					/*$sql_devices = "select device_serialnum, device_manufacturer, description
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
					echo("<tr><td>Serial Number</td><td>Manufacturer</td><td>Description</td>");
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
					echo("<br/>");*/


					$connection = null;
				?>
		

			</fieldset>
		</form>
	</body>
</html>