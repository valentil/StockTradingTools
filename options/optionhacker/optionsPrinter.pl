use File::Glob;
use Cwd 'abs_path';

my $mode = @ARGV[0];
my $ticker = @ARGV[1];
my $dte = @ARGV[2];
my $pattern = "$ticker$dte*.graph";


#print "pattern : $pattern\n";

my $home =  "C:\\xampp\\htdocs\\options\\optionhacker\\";
chdir("$home");

my @files = glob "$pattern";
#print "$pattern\n";

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

if($mode){
	
	
	@newfiles;
	foreach my $file (@files){
		$file =~ s/[0-9]+-[0-9]+DTE\.graph//g;
		push(@newfiles, $file);
	}
	@files = @newfiles;
	@files = sort(@files);
	@files = uniq(@files);
}



foreach my $file (@files){
	
	if($mode){
		print "$file\n";
	}
	else{
			my $fullFilename = "$home" . $file;
		#print "$fullFilename\n";
		open (FH, '<', $fullFilename);
		while(<FH>){
				print $_;
		}
	}
	
	
	
}