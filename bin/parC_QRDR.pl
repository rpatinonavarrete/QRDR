#!/usr/bin/perl

unless (scalar @ARGV == 1){
	print "Usage:\n$0 file";
	exit;
}

my $file = $ARGV[0]; 

open (FILE, $file) || die;

system (">parC_QRDR_AA.tbl");
open (OUT, ">>parC_QRDR_AA.tbl");
print OUT "isolate\t80\t84\tphenotype\n";

while (<FILE>) {
	chomp $_;
	my @line = split (/\t/, $_);
	my $isolate = $line[0];
	$isolate =~ s/_\d+$//;
	my $position80 = substr($line[1],79,1);
	my $position84 = substr($line[1],83,1);
#	print $isolate, "\t", $position83, "\t", $position87, "\n";
	if ($position80 eq "S" && $position84 eq "E") {
		print OUT $isolate . "\tS". "\tE"."\tWT", "\n";
	} elsif ($position80 eq "I" && $position84 eq "E") {
		print OUT $isolate . "\tI". "\tE"."\tS80I\/E84", "\n";
	} elsif ($position80 eq "S" && $position84 eq "G") {
		print OUT $isolate . "\tS". "\tG"."\tS80\/E84G", "\n";
	} elsif ($position80 eq "I" && $position84 eq "G") {
		print OUT $isolate . "\tI". "\tG"."\tS80I\/E84G", "\n";
	} else {
		print OUT $isolate . "\t$position80" . "\t$position84", "\tother(S80$position80\/E84$position84)\n";
	}
}

close (FILE);
close (OUT);
exit;
