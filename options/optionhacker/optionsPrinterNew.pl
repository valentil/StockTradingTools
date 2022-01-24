use File::Glob;
use Cwd 'abs_path';

my $mode = @ARGV[0];
my $ticker = @ARGV[1];
my $daterange = @ARGV[2];
my $pattern = "$ticker*";


#print "pattern : $pattern\n";

my $home =  "C:\\xampp\\htdocs\\options\\optionhacker\\";
chdir("$home");
if($mode == 1){
	$pattern = "$ticker*\.graph";
}

if($mode == 2){
	$pattern = "*\.graph";
}

my @files = glob "$pattern";
#print "$pattern\n";

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

if($mode == 1){
	
	
	@newfiles;
	foreach my $file (@files){
		$file =~ s/\.graph//g;
		push(@newfiles, $file);
	}
	@files = @newfiles;
	@files = sort(@files);
	@files = uniq(@files);
}

if($mode == 2){
	
	
	@newfiles;
	foreach my $file (@files){
		$file =~ s/\d+[a-zA-Z]+\.graph//g;
		$file =~ s/\d+[a-zA-Z]+\d+\.graph//g;
		$file =~ s/\d+\.//g;		
		push(@newfiles, $file);
	}
	@files = @newfiles;
	@files = sort(@files);
	@files = uniq(@files);
}

foreach my $file (@files){
	
	if($mode == 1 ){
		print "$file\n";
	}
	elsif($mode == 2){
		#$file =~ s/\.graph//g;
		print "$file\n";
	}
	else{
		my $fullFilename = "$home" . $file;
		#print "$fullFilename\n";
		open (FH, '<', $fullFilename);
		while(<FH>){
				if($daterange =~ /Today/){
					my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
					#[new  Date(2021,11,28,14,56,34), 'color: green',5212650],
					#[new  Date(2021,11,28,16,00,39), 'color: green',5329165],
					$year = $year + 1900;
					my $patternToUse = "$year\,$mon\,$mday";
					if($_ =~ /$patternToUse/){
						print $_;
					}
					else{
						#print "ptu : $patternToUse<br>$_<br>";
					}
				}
				elsif($daterange =~ /Weekly/){
					my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
					$year = $year + 1900;
					$epoc = time();
					$epoc = $epoc - 24 * 60 * 60;   # one day before of current date.
					my $patternToUse = "$year\,$mon\,$mday";
					($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($epoc);
					$year = $year + 1900;
					
					my $patternToUse2 = "$year\,$mon\,$mday";
					$epoc = $epoc - 24 * 60 * 60;   # one day before of current date.
					($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($epoc);
					$year = $year + 1900;
					my $patternToUse3 = "$year\,$mon\,$mday";
					$epoc = $epoc - 24 * 60 * 60;   # one day before of current date.
					($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($epoc);
					$year = $year + 1900;
					my $patternToUse4 = "$year\,$mon\,$mday";
					$epoc = $epoc - 24 * 60 * 60;   # one day before of current date.
					($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($epoc);
					$year = $year + 1900;
					my $patternToUse5 = "$year\,$mon\,$mday";
					$epoc = $epoc - 24 * 60 * 60;   # one day before of current date.
					($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($epoc);
					$year = $year + 1900;
					my $patternToUse6 = "$year\,$mon\,$mday";
					$epoc = $epoc - 24 * 60 * 60;   # one day before of current date.
					($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($epoc);
					$year = $year + 1900;
					my $patternToUse7 = "$year\,$mon\,$mday";
					$epoc = $epoc - 24 * 60 * 60;   # one day before of current date.
					($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($epoc);
					$year = $year + 1900;					
					
					if($_ =~ /$patternToUse/ || $_ =~ /$patternToUse2/ || $_ =~ /$patternToUse3/ || $_ =~ /$patternToUse4/ || $_ =~ /$patternToUse5/ || $_ =~ /$patternToUse6/ || $_ =~ /$patternToUse7/){
						print $_;
					}
					else{
						#print "ptu : $patternToUse<br>$_<br>";
					}
				}
				elsif($daterange =~ /Alltime/){
					print $_;
				}
				else{
					print $_;
				}
				
		}
	}
	
	
	
	
}