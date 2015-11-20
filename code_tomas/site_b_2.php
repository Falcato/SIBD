<html>
	<body>

		<form action="query_4b.php" method="post">
			<fieldset>
				<legend>Choose the patient and his/hers new PAN</legend>
				<table>
					<tr>
						<td align="right">Patient Number and Name</td>
						<td><p>
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

								$patient_request = $_REQUEST['patient_name'];
								

								$sql_patient = "select patient_number, patient_name from patient
								where patient_name like '%$patient_request%'";	
								$result = $connection->query($sql_patient);
								$nrows = $result->ROWCOUNT();
								if ($result == FALSE){
									$info = $connection->errorInfo();
									echo("<p>Error: {$info[2]}</p>");
									exit();
								}

								if($nrows <= 0){
									echo("<p>Error: There is no patient with that name.</p>");
									exit();
								}
								
								foreach($result as $row){
									$patient_number = $row['patient_number'];
									$patient_name = $row['patient_name'];
									echo("<input type=\"radio\" name = \"patient_number\" value=\"$patient_number\" checked=\"checked\"> $patient_number  $patient_name<br/>");
								}
								$connection = null;
								?>

							</p></td>
					</tr>
					<tr>
						<td align="right">Choose a PAN</td>
						<td><p>
							<select name="pan_name">

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

								$sql_pans = "select distinct pan_domain from pan, wears
								where wears_pan = pan_domain 
								and wears_end not like '2999%'";	
								$result = $connection->query($sql_pans);
								if ($result == FALSE){
									$info = $connection->errorInfo();
									echo("<p>Error: {$info[2]}</p>");
									exit();
								}
								foreach($result as $row){
									$pan_domain = $row['pan_domain'];
									echo("<option value=\"$pan_domain\">$pan_domain</option>");
								}
								$connection = null;
								?>
							
							</select>
							</p></td>
						</tr>
						</tr>
							<td><input type="submit" value="Submit"/></td>
							</tr>
					</table>
				</fieldset>
			</form>
	</body>
</html>