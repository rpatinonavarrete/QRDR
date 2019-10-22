#!/usr/bin/perl

use strict;

my $aln = $ARGV[0];
chomp $aln;

unless (open (ALN, $aln)){
	print "cannot open file \"$aln\"\n";
	exit;
}

my $i = 0;

while (<ALN>) {
	chomp $_;
	if ($_ =~ /^>/ && $i == 0) {
		$_ =~ s/>//;
		print $_, "\t";
		$i = 1;
	} elsif ($i == 1 && $_ !~ /^>/) {
		print $_;
	} elsif ($i == 1 && $_ =~ /^>/) {
		$_ =~ s/>//;
		print "\n", $_, "\t";
	}
}


close (ALN);
exit;
