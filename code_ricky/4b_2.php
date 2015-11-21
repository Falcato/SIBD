<html>
	<body>
		<form action="site_b.php" method="post"> 
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
			and device_manufacturer = connects_manuf
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
			(select wears_end from wears where wears_end not like '%2999%')";

			//and wears_end not like '%2999%'			and device_manufacturer = connects_manuf
		$result2 = $connection->query($sql2);
		$nrows2 = $result2->rowCount();
		$result3 = $connection->query($sql2);
		if ($nrows2 >0 and $nrows >0){
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
				echo("<input type=\"checkbox\" name=\"Device\" value=\"$device_serialnum\">  $device_serialnum - $descrip <br />");
				}
		}else{
			echo("<p>There is no connected PAN to this patient</p>");
		}
		$connection = null;
?>		
 			</select>
 			</p>
 			<p><input type="submit" value="Submit"/></p>
		</form>
	</body>
</html>