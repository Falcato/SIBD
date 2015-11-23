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

					$patient_request = $_REQUEST['patient_request'];
					

					if( (!empty($_POST['device']))  ) {
					    foreach($_POST['device'] as $check) {
					    	$teste = explode('|',$check);
					            echo ("<p>$teste[0] : $teste[1] </p>"); 
					            //caguem no nome das variaveis. isto é a versao em que isto resultou, vou fazer os proximos passos
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
	</body>
</html>