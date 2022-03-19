
my $retValue = 0;
foreach my $helper (@ARGV){
	#print "helper $helper\n";
	$retValue = detectShilling($helper) || $retValue;
}
#print "$retValue\n";
exit($retValue);

sub detectShilling {
	my $inputString = @_[0];
	my $retVal = 0;
	#print "checking $inputString\n";
	$retVal =  checkString($inputString);
	return $retVal;
	#print "$inputString\n";
}

sub checkString{
	my $inputString = @_[0];
	my $forbiddenString = "Bitcoin";
	my @helpe = split(//, $forbiddenString);
		my $counter = 0;
		foreach my $hel(@helpe){
			my @helper = split(//, $inputString);
			foreach my $help (@helper){
				if($help =~ /$hel/i){
					#print "checking $help $hel\n";
					#print "counter++";
					$counter++;
				}
				if($counter == 0+@helpe){
					print "matched $inputString to $forbiddenString\n";
					return 1;
				}
				#print "\n";
			}
		}
		if($counter == 0+@helpe){
				print "matched $inputString to $forbiddenString\n";
				return 1;
		}
		else{
			return 0;
		}
}
