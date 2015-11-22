<html>
	<body>
		<form action="#" method="post">
<?php
			$patient = $_POST['number'];
			echo ("<p>Patient Number: $patient </p>");
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