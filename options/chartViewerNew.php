<html>
<head>
 <link rel="stylesheet" href="styles.css">
</head>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>



<?php
$begin = file_get_contents('viewerBegin.txt');
$begin2 = file_get_contents('viewerBegin2.txt');
$end = file_get_contents('viewerEnd.txt');
$end2 = file_get_contents('viewerEnd2.txt');
date_default_timezone_set("America/New_York");

$ticker = "";
if (isset($_POST['Ticker'])){
	$ticker = $_POST['Ticker'];
}

if (isset($_POST['DateRange'])){
	$DateRange = $_POST['DateRange'];
	$path = 'C:/xampp/htdocs/options/optionhacker';
	
	
echo "
<form action=\"chartViewerNew.php\" method=\"post\">
	</h1>
	<p>
	  <select name=\"DateRange\" id=\"DateRange\">
	  <option value=\"Select\">Select a date range</option>
	  <option value=\"Today\""; if(strcmp($DateRange,"Today") == 0){echo "selected=\true\"";} echo ">Today</option>
	  <option value=\"Weekly\""; if(strcmp($DateRange,"Weekly") == 0){echo "selected=\true\"";} echo ">Weekly</option>
	  <option value=\"All-time\""; if(strcmp($DateRange,"All-time") == 0){echo "selected=\true\"";} echo ">All-time</option>
	  </select>
	  <input type=\"submit\" value=\"Select Date Range\"></input>
	</form>
";
	
$scriptLocation = "C:/xampp/htdocs/options/optionhacker/optionsPrinterNew.pl";
//echo "perl $scriptLocation $date";
$tickers =  shell_exec("perl $scriptLocation 2");
$tickers = preg_split('/\s+/', trim($tickers));
//strlen($tickers)
$favoriteTickers = array("SPY" => "1", "QQQ" => 1,"IWM" => 1, "TSLA" => 1, "AAPL" => "AAPL", "NVDA"=> 1, "AMD"=> 1, 
"F"=> 1, "GOOGL"=> 1, "FB"=> 1, "BABA"=> 1, "TSM"=> 1, "AMZN"=> 1, "SHOP" => 1, "NFLX"=> 1,
 "SQ"=> 1, "AFRM"=> 1, "PLTR" => 1, "GME" => 1, "AMC"=> 1, "DWAC"=> 1,
 "COST" => 1, "TGT" => 1, "ROKU" => 1, "INDI" => 1, "EWZ" => 1, "WMT" => 1, "WFC" => 1, "MS" => 1, "GS" => 1, "PFE" => 1, "ADBE" => 1, "MRNA" => 1);
echo "<table>";
for($x = 0; $x < count($tickers); $x++){
		
		echo "<tr>";
		
		
		
		
		$graphs = shell_exec("perl $scriptLocation 1 $tickers[$x]");
		#echo "perl $scriptLocation 1 $tickers[$x]<br>";
		$graphs = preg_split('/\s+/', trim($graphs));
		
		echo "<td>";
		echo file_get_contents('scriptstart.txt');
		echo "$tickers[$x]'); data.addRows([\n";
			
			#echo "$tickers[$x]";
			$middle =  shell_exec("perl $scriptLocation 0 $tickers[$x] $DateRange");
			echo "$middle";
			echo file_get_contents('scriptfinish.txt');
			echo "$tickers[$x] summarized|"; //title
			echo file_get_contents('scriptfinishmiddle.txt');
			echo "$tickers[$x] summarized"; //div id
			echo file_get_contents('scriptfinish2.txt');
			echo "<div id=\"chart_div_$tickers[$x] summarized\">$tickers[$x] summarized</div>";
			echo "</td>";
		
		for($y = 0; $y < count($graphs); $y++){
			echo "<td>";
			echo "$tickers[$x]";
			echo file_get_contents('scriptstart.txt');
			echo "$graphs[$y]'); //perl $scriptLocation 0 $graphs[$y] $DateRange<br>\ndata.addRows([\n";
			$middle =  shell_exec("perl $scriptLocation 0 $graphs[$y] $DateRange");
			echo "$middle";
			echo file_get_contents('scriptfinish.txt');
			echo "$graphs[$y]|"; //title
			echo file_get_contents('scriptfinishmiddle.txt');
			echo "$graphs[$y]"; //div id
			echo file_get_contents('scriptfinish2.txt');
			echo "<div id=\"chart_div_$graphs[$y]\">$graphs[$y]</div>";
			echo "</td>";
			
		}
		echo "</tr>";
		
		
}
echo "</table>";
}
else{
	echo "
<form action=\"chartViewerNew.php\" method=\"post\">
	</h1>
	<p>
	  <select name=\"DateRange\" id=\"DateRange\">
	  <option value=\"Select\">Select a date range</option>
	  <option value=\"Today\">Today</option>
	  <option value=\"Weekly\">Weekly</option>
	  <option value=\"All-time\">All-time</option>
	  </select>
	  <input type=\"submit\" value=\"Select Date Range\"></input>
	</form>
";
	
}


//$middle =  shell_exec("perl $scriptLocation");
//echo "perl $scriptLocation $dte $ticker";
//echo "$begin$ticker$begin2";
//echo "$middle$end$ticker $dte $end2";
?>

</html>