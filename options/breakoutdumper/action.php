<html>
 <head>
  <title>Post Breakouts Dump</title>
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
	$scriptLocation = "c:/stocks/breakout.pl";
	
	$output = shell_exec("perl $scriptLocation $path");
	echo "<pre>Breakouts $output</pre>";
 }
?>
</p>
  </body>
</html>