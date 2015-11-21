<html>
	<body>
		<form action="4b_2.php" method="post"> 
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
		$patient_request = $_REQUEST['patient_number'];
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
		$sql2 = "select device_serialnum, device_manufacturer, description
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
			and wears_end not like '%2999%' and wears_end >= all 
			(select wears_end from wears where wears_patient = '$patient' 
				and wears_end not like '%2999%')";

			//and wears_end not like '%2999%'			and device_manufacturer = connects_manuf
		$result2 = $connection->query($sql2);
		$nrows2 = $result2->rowCount();
		$result3 = $connection->query($sql2);
		if ($nrows2 > 0 and $nrows > 0){
			echo("<p>Devices from last PAN:</p>");
			echo("<table border=\"1\">");
			echo("<tr><td>Serial Number</td><td>Manufacturer</td><td>Description</td></tr>");
			foreach($result2 as $row){
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
			echo("Choose one or more device(s):");
			echo("<br />");
			foreach($result3 as $row){
				$manufacturer = $row['device_manufacturer'];
				$device_serialnum = $row['device_serialnum'];
				$descrip = $row['description'];
				
				echo"<input type='hidden' name='$device_serialnum$manufacturer' value='$manufacturer'/>";
				echo"<input type='checkbox' name='Device[]' value='$device_serialnum|$manufacturer'>  $device_serialnum - $manufacturer - $descrip <br />";
				//echo("<input type=\"hidden\" name=\"Manufacturer[]\" value=\"$manufacturer\"/>");
				//echo("<input type=\"checkbox\" name=\"Device[]\" value=\"$device_serialnum\">  $device_serialnum - $manufacturer - $descrip <br />");
				}
		}elseif ($nrows2 == 0 and $nrows > 0){			
			echo("<p>There was no previous PAN connected to this patient</p>");
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
 			<?php
					
					//list($device_serialnum,$device_manufacturer) = explode('|',$_POST['device_specs']);
 					/*$abc=$_POST['Device'];
 					echo var_dump($abc)."<br>";
					$teste = explode('|',$abc);
					echo var_dump($teste)."<br>";
						echo "<p>sas = $teste[0]</p>";
						echo "<p>sas = $teste[1]</p>";
					$_POST['Device'] = $option;
					$option = explode ("|",$option);
					print_r($option);
					//echo $option[0]; //This would print the material
					//echo $option[1]; //This would print the price



 					if( (!empty($_POST['Device']) ){
						foreach($_POST['Device']) as $option){
							 $option= explode ("|",$option);
							print $option[0]; //This would print the material
							print $option[1]; //This would print the price
							echo("<br />");
							//echo ("<p> $option[0] - $option[1] </p>");
						}
					}
*/
				if( (!empty($_POST['Device']))  ) {
				    foreach($_POST['Device'] as $check) {
				    	$teste = explode('|',$check);
				    	echo var_dump($teste)."<br>";

				            echo ("<p>$teste[0]......$teste[1] </p>"); 
				            //caguem no nome das variaveis. isto é a versao em que isto resultou, vou fazer os proximos passos
				    }
				}
?>
		</form>
	</body>
</html>