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
					echo"<input type='hidden' name='patient_number' value='$patient_request_hidden'/>";
				
					$sql_pan = "select wears_pan from wears
								where '$patient_request' = wears_patient";
				
					$result_pan = $connection->query($sql_pan);
				
					$nrows = $result_pan->ROWCOUNT();
				
					if($nrows <= 0){
						echo("<p>Error: There is no PAN associated with that patient.</p>");
						exit();
					}
					

					/*QUERY DEVICES ACTUAL PAN*/
					

					$sql_devices = "select device_serialnum, device_manufacturer, description
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
					echo("<br/>");


					/*QUERY DEVICES LAST PAN*/
					

					$sql_devices_last = "select device_serialnum, device_manufacturer, description, wears_pan
						from connects, device, wears			
						where wears_patient = '$patient_request'
						and wears_end < CURDATE() and wears_end >= all 
						(select wears_end from wears where wears_end < CURDATE())
						and connects_pan = wears_pan
						and device_serialnum = connects_snum
						and device_manufacturer = connects_manuf";

					$result = $connection->query($sql_devices_last);
				
					if ($result == FALSE){
						$info = $connection->errorInfo();
						echo("<p>Error: {$info[2]}</p>");
						exit();
					}
				
					$nrows = $result->ROWCOUNT();
				
					if($nrows <= 0){
						echo("<p>Error: There are no medical devices currently associated with the last PAN of this patient.</p>
							<p>Or the PAN is already in use by another patient.</p>");
						exit();
					}
				
					echo("<p>Devices on Last used PAN</p>");
					echo("<p>Choose the ones you want to move to your actual PAN:</p>");
				
					foreach($result as $row){
						$device_serialnum = $row['device_serialnum'];
						$device_manufacturer = $row['device_manufacturer'];
						$description = $row['description'];
						$last_pan = $row['wears_pan'];

						echo("<input type=\"checkbox\" name = \"device[]\" value=\"$device_serialnum|$device_manufacturer\"> $device_serialnum : $device_manufacturer : $description<br/>");
					}
						echo("<br/>");

						//ENVIO DA ULTIMA PAN USADA PARA A PROXIMA PAGINA
						echo"<input type='hidden' name='last_pan' value='$wears_pan'/>";

						$connection = null;
		?>

				<input type="submit" value="Submit"/>
			</fieldset>
		</form>
	</body>
</html>