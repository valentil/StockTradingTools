use File::Glob;

my @files = glob q("*0-3*");

foreach my $file (@files){
	print "$file\n";
	my $fileout = $file . ".out";
	system("perl optionsAnalyzer2.pl $file > $fileout");
}