#!/usr/bin/perl
use strict;
use warnings;

open IN,"F:\\转录组\\Perl\\eel_gene_g.cds";
open OUT,">","F:\\转录组\\Perl\\genelength_length.fasta";
my $id;
my $length1;
my $seq;
while(<IN>){
	chomp;
	if(/>/){
	
		print OUT "$_\t";
		}else{
		$seq=$_;
		$length1=length $seq;
		print OUT "$length1\n";
		}
	#if ($length1>50)
	#{print OUT "$id\t$length1\n";}
	#print OUT "$id\t$length1\n";
	}
	close IN;
  close OUT;