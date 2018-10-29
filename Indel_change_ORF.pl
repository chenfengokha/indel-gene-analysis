#!/usr/bin/perl
use strict;
use warnings;

open IN,"f:\\转录组\\Perl\\11.fasta";
my %cds;
my $id;
my $c="";#把空行赋给变量C；
while(<IN>){
	chomp;  #去掉回车；
  if($_ eq $c){next;}
  elsif(/>/){my @array=split />/,$_;$id=$array[1];} #读到>,将>和geneid按照>分开，数组第0列空，第一列是基因id；
  else{$cds{$id}=$_;}      #读到非>和非空行时，将改行和上条命令得到的数组第一列分别赋给哈希cds的值和键；
 
}
close IN;

open IN1,"f:\\转录组\\Perl\\Gene_variants";
open OUT,'>',"f:\\转录组\\Perl\\1.txt";
my $title=<IN1>;
while(<IN1>){
	chomp;
	my @list=split /\t/,$_;
	my $type=$list[1];
	my $site=$list[3];
	my $len=$list[2];
	my $seq=$list[4];
	
	my $r_seq;
	my $v_seq;
	my $v1;
	my $v2;
	
	if($type=~/D/){#正则表达式~，可以写成type eq "D";
		my $f=($site - 1)%3;		#%表示求余数；
		if($f==0){$r_seq=$seq;
			        $v_seq="";
			       }
		elsif($f==1){$r_seq=substr($cds{$list[0]},$site - 2,$len + 3);#substr表示将哈希中与数组对应的第一列相应序列，从变量site-2开始取变量len+3对应序列赋给变量r_seq;
			           $v1=substr($r_seq,0,1);
			           $v2=substr($r_seq,-2,2);
			           $v_seq="$v1" . "$v2";
			          }
		else{$r_seq=substr($cds{$list[0]},$site - 3,$len + 3);
			   $v1=substr($r_seq,0,2);
			   $v2=substr($r_seq,-1,1);
			   $v_seq="$v1" . "$v2";
			  }
	}
	
	elsif($type=~/I/){
		 my $f=$site%3;
		 if($f==0){$r_seq="";
			         $v_seq=$seq;
			       }
		 elsif($f==1){$r_seq=substr($cds{$list[0]},$site - 1,3); 
		 	            $v1=substr($r_seq,0,1);
			            $v2=substr($r_seq,-2,2);
			            $v_seq="$v1" . "$seq" . "$v2";
			           }
		 else{$r_seq=substr($cds{$list[0]},$site - 2,3);
			   $v1=substr($r_seq,0,2);
			   $v2=substr($r_seq,-1,1);
			   $v_seq="$v1" . "$seq" . "$v2";
			  }    
		 }
	
print OUT "$list[0]\t$type\t$site\t$r_seq\t$v_seq\t$len\n";
	
}
close IN1;