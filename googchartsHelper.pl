my @columns;
push(@columns, "Description");
push(@columns, "Close");
push(@columns, "Last");
push(@columns, "52High");
push(@columns, "%Change");
push(@columns, "Volume");
push(@columns, "Bid");
push(@columns, "Ask");
push(@columns, "High");
push(@columns, "Low");
push(@columns, "Delta");
push(@columns, "Theta");
push(@columns, "Vega");
push(@columns, "Price * Volume");

my @flowColumns;
push(@flowColumns, "Flow in Dollars (for sorting)");
push(@flowColumns, "Flow in Dollars (for reading)");

my @netFlowColumns;
push(@netFlowColumns, "Net Flow(Calls minus Puts) in Dollars (for sorting)");
push(@netFlowColumns, "Net Flow(Calls minus Puts) in Dollars (for reading)");

#print "reading @ARGV[0]\n";
my $filename = @ARGV[0];
$filename =~ s/_/-/g;

my $trimmer = @ARGV[1];

my $DTE = "";
if($filename =~ /0-3dte/){
	$DTE = "0-3DTE";
	$filename =~ s/0-3dte//g;
}
if($filename =~ /4-7dte/){
	$DTE =  "4-7DTE";
	$filename =~ s/4-7dte//g;
}
if($filename =~ /8-30dte/){
	$DTE =  "8-30DTE";
	$filename =~ s/8-30dte//g;
}
if($filename =~ /31-60dte/){
	$DTE =  "31-60DTE";
	$filename =~ s/31-60dte//g;
}
if($filename =~ /61-420dte/){
	$DTE =  "61-420DTE";
	$filename =~ s/61-420dte//g;
}

open(FHDATA, '<', @ARGV[0])  or die $! . @ARGV[0];

my $dataFromFiles = "";

my %flowHash;
my $callSize = 0;
my $putSize = 0;

my $sizeLimitLow = 0;

while(<FHDATA>){
	my @data = split("	",$_);
	my $ticker = @data[1];
	my @tickerHelper = split(" ", $ticker);
	$ticker = @tickerHelper[0];
	my $lastPrice = @data[3];
	my $volume = @data[6];
	$volume =~ s/,//g;
	@data[1] = "[$ticker](https://finance.yahoo.com/quote/$ticker/)";
	my $volPrice = $lastPrice * $volume * 100;
	if(@data[0] =~ /[0-9+]C[0-9]+/){
		my $hashthing = $ticker . "calls";
		$callSize = $callSize + $volPrice;
		if(0+$flowHash{$hashthing} != 0){
			#print "@data[0] + $volPrice + call\n";
			$flowHash{$hashthing} = $flowHash{$hashthing} + $volPrice;
		}
		else{
			#print "@data[0] + $volPrice + call + new\n";
			$flowHash{$hashthing} = $volPrice;
		}
		
	}
	else{
		
		my $hashthing2 = $ticker . "puts";
		$putSize = $putSize + $volPrice;
		if(0+$flowHash{$hashthing2} != 0){
			$flowHash{$hashthing2} = $flowHash{$hashthing2} + $volPrice;
		}
		else{
			$flowHash{$hashthing2} = $volPrice;
		}
	}
	#print "LP : $lastPrice volume: $volume = $volPrice\n";
	
	@data[0+@data-1] = chomp(@data[0+@data-1]);
	pop(@data); #fuck if I know this fugazi bullshit
	#$volPrice = commify($volPrice);
	#print "$volPrice\n";
	push(@data, $volPrice);
	push(@data, "\n");
	#print "'@data'\n";
	#exit(0);
	my $printer = join("|",@data);
	$dataFromFiles = $dataFromFiles . "$printer";

}


my $size;
my $printHelp;

my $printer;
my $putter;

my $sizeLimitLow = 5000000;
my $sizeLimitLowNegative = $sizeLimitLow * -1;
my $commaSizeLimit = commify($sizeLimitLow);

my $starter = "[new  Date(";
my $intermission = "), ";
my $ender = "],\n";
my $ampm = ($filename =~ /PM/);

$filename =~ s/[AM|PM]//g;

$filename =~ s/\.txt//g;
print "pre : $filename\n";
my @filenameArray = split("-", $filename);
if($ampm){
	my $hourIndex = 3;
	if(@filenameArray[$hourIndex] + 12 < 24){
			@filenameArray[$hourIndex] = @filenameArray[$hourIndex] + 12;
	}
	if(@filenameArray[$hourIndex] > 16){
		@filenameArray[$hourIndex] = 16; #close at 4pm
		@filenameArray[$hourIndex+1] = 0; #close at 4pm
		@filenameArray[$hourIndex+2] = 0; #close at 4pm
	}
}
	my $monthIndex = 1;
		@filenameArray[$monthIndex] = @filenameArray[$monthIndex] - 1;
		
my $filename = join(",", @filenameArray);
#$filename =~ s/PM//g;
print "$filename\n";

print "trimming : $trimmer\n";
my $filenameForDate = $filename;
$filenameForDate =~ s/$trimmer//g;

#printTableHeader("Price weighted volume(Price * Volume) * all $DTE trades Call Option Scan(live data) trimmed to > \$$commaSizeLimit", @flowColumns);
for(sort keys %flowHash){
	
	if($_ =~ /calls/){
		$size = $flowHash{$_};
		if($size > $sizeLimitLow){
			$printer = $_;
			$printer =~ s/calls//g;
			$printer =~ s/\//-/g;
			$printer = $printer . $DTE . ".graph";
			print "writing to $printer\n";
			open(FHTICKER, '>>', $printer)  or die $! . $printer;
			print FHTICKER "$starter$filenameForDate$intermission\'color: green\',$size$ender";
			close(FHTICKER);
		}
	}
	else{
		$size = $flowHash{$_};
		if($size > $sizeLimitLow){
			$size = -1 * $size;
			$printer = $_;
			$printer =~ s/puts//g;
			$printer =~ s/\//-/g;
			$printer = $printer . $DTE . ".graph";
			print "writing to $printer\n";
			open(FHTICKER, '>>', $printer)  or die $! . $printer;
			print FHTICKER "$starter$filenameForDate$intermission\'color: red\',$size$ender";
			close(FHTICKER);
		}
	}
}
exit();


printTableHeader("Price weighted volume(Price * Volume) * all $DTE trades Put Option Scan(live data) trimmed to > \$$commaSizeLimit", @flowColumns);
for(sort keys %flowHash){
	if($_ =~ /puts/){
		$size = $flowHash{$_};
		if($size > $sizeLimitLow || $size < $sizeLimitLowNegative){
			$printHelp = commify($flowHash{$_});
			$printer = $_;
			$printer =~ s/puts//g;
			$printer = "[$printer](https://finance.yahoo.com/quote/$printer/)";
			print("$printer|$flowHash{$_}|$printHelp|\n");
		}
	}
	else{
		#
	}
}

printTableHeader("Net Price weighted volume(Price * Volume) * all $DTE trades Calls minus Put Option Scan(live data) trimmed to > \$$commaSizeLimit", @netFlowColumns);
for(sort keys %flowHash){
	if($_ =~ /calls/){
		$printer = $_;
		$putter = $_;
		$printer =~ s/calls//g;
		$putter =~ s/calls/puts/g;
		$size = 0;
		if($flowHash{$_} > 0 ){
			$size = $flowHash{$_};
			if($flowHash{$putter} > 0){
				$size = $size - $flowHash{$putter};
				$flowHash{$putter} = 0; #zero it out
			}
		}
		if($size > $sizeLimitLow || $size < $sizeLimitLowNegative){
			$printHelp = commify($size);
			$printer = "[$printer](https://finance.yahoo.com/quote/$printer/)";
			print("$printer|$size|$printHelp|\n");
		}
		
	}
	else{
		$size = $flowHash{$_};
		$size = -1 * $size;
		if($size > $sizeLimitLow || $size < $sizeLimitLowNegative){
			#we haven't already done these calls then
			$printer = $_;
			$printer =~ s/puts//g;
			$printHelp = commify($size);
			$printer = "[$printer](https://finance.yahoo.com/quote/$printer/)";
			print("$printer|$size|$printHelp|\n");
		}
	}
}

my $callSizePrint = commify($callSize);
my $putSizePrint = commify($putSize);
print "\nUntrimmed Total $DTE Calls: $callSizePrint\n";
print "\nUntrimmed Total $DTE Puts: $putSizePrint\n";

if($putSize > $callSize){
	my $abs = $putSize - $callSize;
	$abs = commify($abs);
	print "\nBearish $DTE Flow: $abs\n";
}
else{
	my $abs = $callSize - $putSize;
	$abs = commify($abs);
	print "\nBullish $DTE Flow $abs\n";
}

exit;
#
printTableHeader("Options Scan (live data)", @columns);
print "$dataFromFiles\n";

sub commify {
    my $text = reverse $_[0];
    $text =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/g;
    return scalar reverse $text;
}

sub printTableHeader(){
	my $tableName = shift(@_);
	my @columns = @_;
	my $firstLine = "Symbol|";
	my $alignmentLine = ":--|";
	foreach(@columns){
		$firstLine = $firstLine . "$_|";
		$alignmentLine = $alignmentLine . ":--:|";
	}
	$firstLine = $firstLine . "\n";
	$alignmentLine = $alignmentLine . "\n";
	print "\n\n$tableName\n\n";
	print "$firstLine$alignmentLine";
}


