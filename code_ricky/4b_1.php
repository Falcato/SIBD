<html>
	<body>
		<form action="4b_2.php" method="post">
			<fieldset>
				<legend>Patient(s)</legend>
				<table>
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
		$patient_request = $_REQUEST['patient_name'];
		/*tabela do query*/
		$sql = "select patient_name, patient_number
				from patient
				where patient_name like '%$patient_request%'";
		
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
			echo("<tr><td>SIDN</td><td>Patient's Name</td></tr>");
			foreach($result1 as $row){
					echo("<tr><td>");
					echo($row['patient_number']);
					echo("</td><td>");
					echo($row['patient_name']);
					echo("</td></tr>");
			}
			echo("</table>");
			echo("Choose one patient:");
			echo("<br />");
			foreach($result as $row){
				$patient_number = $row['patient_number'];
				echo("<input type=\"radio\" name = \"patient_number\" value=\"$patient_number\" checked=\"checked\">	$patient_number <br/>");
			}
		}else{
			echo("<p>There is no patient with that name</p>");
		}
	$connection = null;
?>
					<tr>
						<td></td>
						<td><input type="submit" value="Submit"/></td>
					</tr>
				</table>
			</fieldset>
		</form>
	</body>
</html>