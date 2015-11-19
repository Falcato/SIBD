<html>
	<body>
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
		/*tabela do connect*/
		$sql = "SELECT * FROM connects";
		$result = $connection->query($sql);
		if ($result == FALSE){
			$info = $connection->errorInfo();
			echo("<p>Error: {$info[2]}</p>");
			exit();
		}
		echo("<table border=\"1\">");
		echo("<tr><td>start</td><td>end</td><td>serial_number</td><td>manufacturer</td><td>PAN</td></tr>");
		foreach($result as $row){
				echo("<tr><td>");
				echo($row['connects_start']);
				echo("</td><td>");
				echo($row['connects_end']);
				echo("</td><td>");
				echo($row['connects_snum']);
				echo("</td><td>");
				echo($row['connects_manuf']);
				echo("</td><td>");				
				echo($row['connects_pan']);
				echo("</td></tr>");
		}
		echo("</table>");
		/*tabela XXX*/
		
	$connection = null;
?>
	</body>
</html>
