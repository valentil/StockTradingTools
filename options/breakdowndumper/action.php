<html>
 <head>
  <title>Post Breakdowns Dump</title>
 </head>
 <body>
 <h1></h1>
 <p>
<?php
 date_default_timezone_set("America/New_York");
 $path = 'C:/stocks/';
 if (isset($_POST['field1'])) {
	$path = $path . date('Y-m-d h-i-s-A') . ".txt";
	$path = str_replace(" ", "-", $path);
    $fh = fopen($path,"a+");
    $string = $_POST['field1'];
    fwrite($fh,$string); // Write information to the file
    fclose($fh); // Close the file
	$scriptLocation = "c:/stocks/breakdowns/breakdown.pl";
	
	$output = shell_exec("perl $scriptLocation $path");
	echo "<pre>Breakdowns $output</pre>";
 }
?>
</p>
  </body>
</html>