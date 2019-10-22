#!/usr/bin/perl

unless (scalar @ARGV == 1){
	print "Usage:\n$0 file";
	exit;
}

my $file = $ARGV[0]; 

open (FILE, $file) || die;

system (">gyrA_QRDR_AA.tbl");
open (OUT, ">>gyrA_QRDR_AA.tbl");
print OUT "isolate\t83\t87\tphenotype\n";

while (<FILE>) {
	chomp $_;
	my @line = split (/\t/, $_);
	my $isolate = $line[0];
	$isolate =~ s/_\d+$//;
	my $position83 = substr($line[1],82,1);
	my $position87 = substr($line[1],86,1);
#	print $isolate, "\t", $position83, "\t", $position87, "\n";
	if ($position83 eq "S" && $position87 eq "D") {
		print OUT $isolate . "\tS". "\tD"."\tWT", "\n";
	} elsif ($position83 eq "L" && $position87 eq "D") {
		print OUT $isolate . "\tL". "\tD"."\tS83L\/D87", "\n";
	} elsif ($position83 eq "S" && $position87 eq "N") {
		print OUT $isolate . "\tS". "\tN"."\tS83\/D87N", "\n";
	} elsif ($position83 eq "L" && $position87 eq "N") {
		print OUT $isolate . "\tL". "\tN"."\tS83L\/D87N", "\n";
	} elsif ($position83 eq "A" && $position87 eq "D") {
		print OUT $isolate . "\tA". "\tD"."\tS83A\/D87", "\n"
	} else {
		print OUT $isolate . "\t$position83" . "\t$position87", "\tother(S83$position83\/D87$position87)\n";
	}
}

close (FILE);
close (OUT);
exit;
