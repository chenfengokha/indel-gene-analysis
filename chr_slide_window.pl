#!/usr/bin/perl
use strict;
use warnings;

#设定染色体总长度、window长度、滑动的步长
my $chr_length=80000000;
my $window_size=5000000;
my $step_size=100000;
my $max_i=$chr_length-$window_size;

my $in_dir="F:\\转录组\\Perl\\in_F_expression\\";
my $out_dir="F:\\转录组\\Perl\\out_F_expression\\";

opendir INDIR,$in_dir or die $!;
my @infile=readdir INDIR or die $!;
foreach my $file (@infile){
	next if $file eq "."or $file eq "..";

open IN,"$in_dir$file";
open OUT,">","$out_dir$file";

#my $title=<IN>;
my @gene_start;
while(<IN>){
	chomp;
	my $start=$_;
	push @gene_start,$start;
}
 
for (my $i=1;$i<$max_i;$i+=$step_size){
		my $window_start=$i;
		my $window_end=$i+$window_size-1;
		my $window_num=0;
		foreach my $start (@gene_start) {
			if($start <= $window_end && $start >= $window_start){
                       $window_num++;
		    }
		}
		print OUT "$window_start\t$window_end\t$window_num\n";
		#print OUT "$window_num\n";
}

}
