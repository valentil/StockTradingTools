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
my $DTE = "";

open(FHDATA, '<', @ARGV[0])  or die $! . @ARGV[0];

my $dataFromFiles = "";

my %flowHash;
my $callSize = 0;
my $putSize = 0;

my $daySave = "notset";
my $monthSave = "notset";
my $yearSave = "notset";
my $putVolume = 0;
my $callVolume = 0;
my $epoc = time();
my $deltaSymbol = "Δ"; #hard to reference otherwise

while(<FHDATA>){
	my @data = split("	",$_);
	my $ticker = @data[1];
	my @tickerHelper = split(" ", $ticker);
	$ticker = @tickerHelper[0];
	my $lastPrice = @data[3];
	my $volume = @data[6];
	
	my $timestamper = @data[1];
	$timestamper =~ s/ (Weeklys)//g;
	$timestamper =~ s/ (Quarterlys)//g;
	
	my @timestampHelper = split(" " , $timestamper);
	my $day = @timestampHelper[3];
	my $month = @timestampHelper[4];
	my $year = @timestampHelper[5];
	
	if($yearSave =~ /notset/){
		$yearSave = $year;
	}
	if($monthSave =~ /notset/){
		$monthSave = $month;
	}
	if($daySave =~ /notset/){
		$daySave = $day;
	}
	
	
	$volume =~ s/,//g;
	@data[1] = "[$ticker](https://finance.yahoo.com/quote/$ticker/)";
	my $volPrice = $lastPrice * $volume * 100;
	if(@data[0] =~ /[0-9+]C[0-9]+/){
		my $hashthing = $ticker . "calls";
		$callSize = $callSize + $volPrice;
		$callVolume = $callVolume + $volume;
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
		$putVolume = $putVolume + $volume;
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



my $filenameSaver = "todaystotals";


my $callSizeFromFile = "notset";
my $putSizeFromFile = "notset";
my $totalSizeFromFile = "notset";
my $callVolumeFromFile = "notset";
my $putVolumeFromFile = "notset";
my $epochFromFile = "notset";


my %deltaHash;

if(open(DELTASAVER, '<', $filenameSaver)){
	while(<DELTASAVER>){
		if($epochFromFile =~ /notset/){
			$epochFromFile = $_;
		}
		elsif($callSizeFromFile =~ /notset/){
			$callSizeFromFile = $_;		
		}
		elsif($putSizeFromFile =~ /notset/){
			$putSizeFromFile = $_;
		}
		elsif($totalSizeFromFile =~ /notset/){
			$totalSizeFromFile = $_;
		}
		elsif($callVolumeFromFile =~ /notset/){
			$callVolumeFromFile = $_;
		}
		elsif($putVolumeFromFile =~ /notset/){
			$putVolumeFromFile = $_;
		}
		elsif($_ =~ /calls|puts/){
			my @deltaHelper = split(",");
			$deltaHash{@deltaHelper[0]} = (@deltaHelper[1]);
		}
	}
}
if($callSizeFromFile =~ /notset/){
	$callSizeFromFile = 0;
}
if($putSizeFromFile =~ /notset/){
	$putSizeFromFile = 0;
}
if($totalSizeFromFile =~ /notset/){
	$totalSizeFromFile = 0;
}
if($callVolumeFromFile =~ /notset/){
	$callVolumeFromFile = 0;
}
if($putVolumeFromFile =~ /notset/){
	$putVolumeFromFile = 0;
}



close(DELTASAVER);
open(DELTASAVER, '>', $filenameSaver) or die $! . $filenameSaver;

my $size = 0;
my $printHelp;

my $printer;
my $putter;

my $sizeLimitLow = 5000000;
my $sizeLimitLowNegative = $sizeLimitLow * -1;
my $commaSizeLimit = commify($sizeLimitLow);

my $oldSize = 0;
my $deltaSize = 0;


print(DELTASAVER "$epoc\n");
print(DELTASAVER "$callSize\n");
print(DELTASAVER "$putSize\n");
print(DELTASAVER "$absv\n");
print(DELTASAVER "$callVolume\n");
print(DELTASAVER "$putVolume\n");

for(sort keys %flowHash){
	print(DELTASAVER "$_,$flowHash{$_}\n");
}


printTableHeader("Price weighted volume(Price * Volume) * all trades Call Option Scan(live data) trimmed to > \$$commaSizeLimit", @flowColumns);
for(sort keys %flowHash){
	if($_ =~ /calls/){
		$size = $flowHash{$_};
		$oldSize = $deltaHash{$_};
		$deltaSize = int($size - $oldSize);
		if($size > $sizeLimitLow || $oldSize > $sizeLimitLow){
			$printHelp = commify($flowHash{$_});
			$printer = $_;
			$printer =~ s/calls//g;
			$printer = "[$printer](https://finance.yahoo.com/quote/$printer/)";
			print("$printer|$size($deltaSymbol$deltaSize)|$printHelp|\n");
		}
	}
	else{
		#
	}
}

printTableHeader("Price weighted volume(Price * Volume) * all trades Put Option Scan(live data) trimmed to > \$$commaSizeLimit", @flowColumns);
for(sort keys %flowHash){
	if($_ =~ /puts/){
		$size = $flowHash{$_};
		$oldSize = $deltaHash{$_};
		$deltaSize = int($size - $oldSize);
		if($size > $sizeLimitLow || $size < $sizeLimitLowNegative){
			$printHelp = commify($flowHash{$_});
			$printer = $_;
			$printer =~ s/puts//g;
			$printer = "[$printer](https://finance.yahoo.com/quote/$printer/)";
			print("$printer|$size($deltaSymbol$deltaSize)|$printHelp|\n");
		}
	}
	else{
		#
	}
}

printTableHeader("Net Price weighted volume(Price * Volume) * all trades Calls minus Put Option Scan(live data) trimmed to > \$$commaSizeLimit", @netFlowColumns);
for(sort keys %flowHash){
	if($_ =~ /calls/){
		$printer = $_;
		$putter = $_;
		$printer =~ s/calls//g;
		$putter =~ s/calls/puts/g;
		$size = 0;
		$deltaSize = 0;
		if($flowHash{$_} > 0 ){
			$size = $flowHash{$_};
			if($flowHash{$putter} > 0){
				$size = int($size - $flowHash{$putter});
				$flowHash{$putter} = 0; #zero it out
			}
		}
		
		if($deltaHash{$_} > 0 ){
			$deltaSize = $deltaHash{$_};
			if($deltaHash{$putter} > 0){
				$deltaSize = int($deltaSize - $deltaHash{$putter});
				$deltaHash{$putter} = 0; #zero it out
			}
		}
		$deltaSize = int($size - $deltaSize);
		chomp($deltaSize);
		if($size > $sizeLimitLow || $size < $sizeLimitLowNegative){
			$printHelp = commify($size);
			$printer = "[$printer](https://finance.yahoo.com/quote/$printer/)";
			print("$printer|$size($deltaSymbol$deltaSize)|$printHelp|\n");
		}
		
	}
	else{
		$size = $flowHash{$_};
		$size = -1 * $size;
		$deltaSize = int($size + $deltaHash{$_});
		chomp($deltaSize);
		if($size > $sizeLimitLow || $size < $sizeLimitLowNegative){
			#we haven't already done these calls then
			$printer = $_;
			$printer =~ s/puts//g;
			$printHelp = commify($size);
			$printer = "[$printer](https://finance.yahoo.com/quote/$printer/)";
			print("$printer|$size($deltaSymbol$deltaSize)|$printHelp|\n");
		}
	}
}

my $callSizePrint = commify($callSize);
my $putSizePrint = commify($putSize);





$callSizeFromFile = commify($callSize - $callSizeFromFile);
$putSizeFromFile = commify($putSize - $putSizeFromFile);

my $callSizeFromFileNumber = $callVolume - $callVolumeFromFile;
my $putSizeFromFileNumber = $putVolume - $putVolumeFromFile;

my $bothSizeFromFileNumber;
my $callVolumePrint = commify($callVolume - $callVolumeFromFile);
my $putVolumePrint = commify($putVolume - $putVolumeFromFile);

my $callVolumePrintOrig = commify($callVolume);
my $putVolumePrintOrig = commify($putVolume);

my $timeDelta = $epoc - $epochFromFile;

my $timeDelta = $timeDelta / 60.0; #seconds to minutes
my $contractsperminute = 0;
$contractsperminute = $callSizeFromFileNumber / ($timeDelta *1.0);
commify($contractsperminute);
print "\nUntrimmed Total Calls: \$$callSizePrint ($deltaSymbol$callSizeFromFile) volume: $callVolumePrintOrig ($deltaSymbol$callVolumePrint -> $contractsperminute per minute)\n";
$contractsperminute = $putSizeFromFileNumber / ($timeDelta *1.0);
commify($contractsperminute);
print "\nUntrimmed Total Puts: \$$putSizePrint ($deltaSymbol$putSizeFromFile) volume: $putVolumePrintOrig ($deltaSymbol$putVolumePrint -> $contractsperminute per minute)\n";
my $absv = 0;

if($putSize > $callSize){
	$abs = $putSize - $callSize;
	$absv = -1 * $abs;
	$totalSizeFromFile = commify((-1 * $abs) - $totalSizeFromFile);
	$bothSizeFromFileNumber = (-1 * $abs) - $totalSizeFromFile;
	$abs = commify($abs);
	$contractsperminute = $bothSizeFromFileNumber / ($timeDelta *1.0);
	commify($contractsperminute);
	print "\nBearish Flow: \$$abs ($deltaSymbol$totalSizeFromFile in $timeDelta minutes)\n";
}
else{
	my $abs = $callSize - $putSize;
	$totalSizeFromFile = commify($abs - $totalSizeFromFile);
	$bothSizeFromFileNumber =  $abs - $totalSizeFromFile;
	$absv = "$abs";
	$abs = commify($abs);
	$contractsperminute = $bothSizeFromFileNumber / ($timeDelta *1.0);
	commify($contractsperminute);
	print "\nBullish Flow \$$abs ($deltaSymbol$totalSizeFromFile in $timeDelta minutes -> \$$contractsperminute per minute)\n";
}
$epoc2 = time();
$epoc2 = $epoc2 + 2 * 60 * 60;    # 2 hours after
my $datestring = localtime($epoc2);
print "\nSnapshot @ $datestring\n";




close(DELTASAVER);

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


