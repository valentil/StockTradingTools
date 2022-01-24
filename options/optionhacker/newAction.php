<html>
 <head>
  <title>Post Dump</title>
 </head>
 <body>
 <h1></h1>
 <p>
<?php
 date_default_timezone_set("America/New_York");
 $path = 'C:\stocks\options\\';
 if (isset($_POST['field1'])) {
	$path = $path . date('Y-m-d h-i-s-A') . ".txt";
	$path = str_replace(" ", "_", $path);
    $fh = fopen($path,"a+");
    $string = $_POST['field1'];
    fwrite($fh,$string); // Write information to the file
    fclose($fh); // Close the file
	$scriptLocation = "c:/stocks/options/optionsAnalyzer2.pl $path";
	$output = shell_exec("perl $scriptLocation 2>&1");
	echo "<pre>$output</pre>";
	$UpdateGraphScriptLocation = "c:/stocks/options/googchartsHelperParseDate.pl $path C:\\\\stocks\\\\options\\\\";
	$output = shell_exec("perl $UpdateGraphScriptLocation");
	//echo "<p>$output</p>";
 }
?>
</p>
  </body>
</html>