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
					
					/*QUERY DA PARA DESCOBRIR PAN DO PACIENTE*/
				
					$patient_request = $_REQUEST['patient_number'];
					
					$patient_request_hidden = $_REQUEST['patient_number'];


					//ENVIO DO PATIENT NUMBER PARA A PROXIMA PAGINA
					echo("<input type='hidden' name='patient_number_hidden' value='$patient_request_hidden'/>");
					

					//QUERY DA PAN ACTUAL
					$sql_pan = "select pan from wears
								where '$patient_request' = patient";
				
					$result_pan = $connection->query($sql_pan);
				
					$nrows = $result_pan->ROWCOUNT();
				
					if($nrows <= 0){
						echo("<p>Error: There is no PAN associated with that patient.</p>");
						exit();
					}

					foreach($result_pan as $row){
						$current_pan = $row['pan'];
					}
					
					echo("<input type='hidden' name='current_pan_hidden' value='$current_pan'/>");

					/*QUERY DEVICES ACTUAL PAN*/

					$sql_devices = "select serialnum, manufacturer, description
								from device, wears, connects
								where wears.patient = '$patient_request'
								and wears.end > CURDATE()
								and connects.pan = wears.pan
								and connects.end > CURDATE()
								and serialnum = snum
								and manufacturer = manuf";
				
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

					/*QUERY DEVICES LAST PAN*/					

					$sql_devices_last = "select serialnum, manufacturer, description, wears.pan
						from connects, device, wears			
						where patient = '$patient_request'
						and wears.end < CURDATE() and wears.end >= all
						(select end from wears where end < CURDATE()
							and patient = '$patient_request')
						and connects.pan = wears.pan
						and serialnum = snum
						and manufacturer = manuf
						and ((connects.start >= wears.start and connects.end <= wears.end)
							or (connects.start <= wears.start and connects.end >= wears.start)
							or (connects.start <= wears.end and connects.end >= wears.end))";

					$result = $connection->query($sql_devices_last);
				
					if ($result == FALSE){
						$info = $connection->errorInfo();
						echo("<p>Error: {$info[2]}</p>");
						exit();
					}
				
					$nrows = $result->ROWCOUNT();
				
					if($nrows <= 0){
						echo("<p>Error: There are no medical devices currently associated with the last PAN of this patient.</p>
							<p>Or the PAN is already in use by another patient.</p>
							<p>Or the patient doesn't have a last PAN.</p>");
						exit();
					}
				
					echo("<p>Devices on Last used PAN</p>");
					echo("<p>Choose the ones you want to move to your actual PAN:</p>");
				
					foreach($result as $row){
						$device_serialnum = $row['serialnum'];
						$device_manufacturer = $row['manufacturer'];
						$description = $row['description'];
						$last_pan = $row['pan'];


						//QUERY PARA A PAN ACTUAL DO DEVICE
						$sql_pan_device = "select pan
						 				from connects
						 				where end >= all
						 				(select end from connects)
						 				and end > CURDATE()
						 				and snum = '$device_serialnum'
						 				and manuf = '$device_manufacturer'";

						$result_pan_device = $connection->query($sql_pan_device);
						foreach($result_pan_device as $row_pan_device){
							$current_pan_device = $row_pan_device['pan'];
						}

						$sql_user_device = "select end
										from wears
										where end >= all
						 				(select end from wears
						 					where pan = '$current_pan_device')
										and pan = '$current_pan_device'";

						$result_user_device = $connection->query($sql_user_device);
						foreach($result_user_device as $row_user_device){
							$current_user_device = $row_user_device['end'];
						}

					    $time_of_device = strtotime($current_user_device);
					    $todays_date = date("Y-m-d");
					    $today = strtotime($todays_date);

						if($current_pan != $current_pan_device and $time_of_device < $today){
							echo("<input type=\"checkbox\" name = \"device[]\" value=\"$device_serialnum|$device_manufacturer\"> $device_serialnum : $device_manufacturer : $description<br/>");
						}

					}
						echo("<br/>");

						//ENVIO DA ULTIMA PAN USADA PARA A PROXIMA PAGINA
						echo("<input type='hidden' name='last_pan_hidden' value='$last_pan'/>");

						$connection = null;
		?>

				<input type="submit" value="Submit"/>
			</fieldset>
		</form>
	</body>
</html>