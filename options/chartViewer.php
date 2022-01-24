 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<?php
$begin = file_get_contents('viewerBegin.txt');
$begin2 = file_get_contents('viewerBegin2.txt');
$end = file_get_contents('viewerEnd.txt');
$end2 = file_get_contents('viewerEnd2.txt');
date_default_timezone_set("America/New_York");

$dte = "";
$ticker = "";
if (isset($_POST['DTE'])){
	$dte = $_POST['DTE'];
}
if (isset($_POST['Ticker'])){
	$ticker = $_POST['Ticker'];
}

$path = 'C:/xampp/htdocs/options/optionhacker';
$scriptLocation = "C:/xampp/htdocs/options/optionhacker/optionsPrinter.pl";
//echo "perl $scriptLocation $date";
$tickers =  shell_exec("perl $scriptLocation 1");
$tickers = preg_split('/\s+/', trim($tickers));
//echo "$tickers";
//strlen($tickers)
$favoriteTickers = array("SPY" => "1", "QQQ" => 1,"IWM" => 1, "TSLA" => 1, "AAPL" => "AAPL", "NVDA"=> 1, "AMD"=> 1, 
"F"=> 1, "GOOGL"=> 1, "FB"=> 1, "BABA"=> 1, "TSM"=> 1, "AMZN"=> 1, "SHOP" => 1, "NFLX"=> 1,
 "SQ"=> 1, "AFRM"=> 1, "PLTR" => 1, "GME" => 1, "AMC"=> 1, "DWAC"=> 1,
 "COST" => 1, "TGT" => 1, "ROKU" => 1, "INDI" => 1, "EWZ" => 1, "WMT" => 1, "WFC" => 1, "MS" => 1, "GS" => 1, "PFE" => 1, "ADBE" => 1, "MRNA" => 1);
for($x = 0; $x < count($tickers); $x++){
	//echo "$tickers[$x]";
	if(array_key_exists($tickers[$x], $favoriteTickers)){
		//echo "did not skip $tickers[$x]";
		echo file_get_contents('scriptstart.txt');
		echo "$tickers[$x] 0-3DTE'); //perl $scriptLocation 0 $tickers[$x] 0-3DTE<br>\ndata.addRows([\n";
		$middle =  shell_exec("perl $scriptLocation 0 $tickers[$x] 0-3DTE");
		echo "$middle";
		echo file_get_contents('scriptfinish.txt');
		echo "$tickers[$x]|0-3DTE"; //title
		echo file_get_contents('scriptfinishmiddle.txt');
		echo "$tickers[$x]0-3DTE"; //div id
		echo file_get_contents('scriptfinish2.txt');
		echo "<div id=\"chart_div_$tickers[$x]0-3DTE\">$tickers[$x] 0-3DTE</div>";
		
		echo file_get_contents('scriptstart.txt');
		echo "$tickers[$x] 4-7DTE'); //perl $scriptLocation 0 $tickers[$x] 4-7DTE<br>\ndata.addRows([\n";
		$middle =  shell_exec("perl $scriptLocation 0 $tickers[$x] 4-7DTE");
		echo "$middle";
		echo file_get_contents('scriptfinish.txt');
		echo "$tickers[$x]|4-7DTE";
		echo file_get_contents('scriptfinishmiddle.txt');
		echo "$tickers[$x]4-7DTE";
		echo file_get_contents('scriptfinish2.txt');
		echo "<div id=\"chart_div_$tickers[$x]4-7DTE\">$tickers[$x]4-7</div>";
		
		echo file_get_contents('scriptstart.txt');
		echo "$tickers[$x] 8-30DTE'); //perl $scriptLocation 0 $tickers[$x] 8-30DTE<br>\ndata.addRows([\n";
		$middle =  shell_exec("perl $scriptLocation 0 $tickers[$x] 8-30DTE");
		echo "$middle";
		echo file_get_contents('scriptfinish.txt');
		echo "$tickers[$x]|8-30DTE";
		echo file_get_contents('scriptfinishmiddle.txt');
		echo "$tickers[$x]8-30DTE";
		echo file_get_contents('scriptfinish2.txt');
		echo "<div id=\"chart_div_$tickers[$x]8-30DTE\">$tickers[$x]8-30DTE</div>";
		
		echo file_get_contents('scriptstart.txt');
		echo "$tickers[$x] 31-60DTE'); //perl $scriptLocation 0 $tickers[$x] 31-60DTE<br>\ndata.addRows([\n";
		$middle =  shell_exec("perl $scriptLocation 0 $tickers[$x] 31-60DTE");
		echo "$middle";
		echo file_get_contents('scriptfinish.txt');
		echo "$tickers[$x]|31-60DTE";
		echo file_get_contents('scriptfinishmiddle.txt');
		echo "$tickers[$x]31-60DTE";
		echo file_get_contents('scriptfinish2.txt');
		echo "<div id=\"chart_div_$tickers[$x]31-60DTE\">$tickers[$x]31-60</div>";
		
		echo file_get_contents('scriptstart.txt');
		echo "$tickers[$x] 61-420DTE'); //perl $scriptLocation 0 $tickers[$x] 61-420DTE<br>\ndata.addRows([\n";
		$middle =  shell_exec("perl $scriptLocation 0 $tickers[$x] 61-420DTE");
		echo "$middle";
		echo file_get_contents('scriptfinish.txt');
		echo "$tickers[$x]|61-420DTE";
		echo file_get_contents('scriptfinishmiddle.txt');
		echo "$tickers[$x]61-420DTE";
		echo file_get_contents('scriptfinish2.txt');
		echo "<div id=\"chart_div_$tickers[$x]61-420DTE\">$tickers[$x]61-420DTE</div>";
	}
	else{
		//echo "$tickers[$x] skipped<br>";
	}
}
//$middle =  shell_exec("perl $scriptLocation");
//echo "perl $scriptLocation $dte $ticker";
//echo "$begin$ticker$begin2";
//echo "$middle$end$ticker $dte $end2";
?>
