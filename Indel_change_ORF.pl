#!/usr/bin/perl
use strict;
use warnings;

open IN,"f:\\ת¼��\\Perl\\11.fasta";
my %cds;
my $id;
my $c="";#�ѿ��и�������C��
while(<IN>){
	chomp;  #ȥ���س���
  if($_ eq $c){next;}
  elsif(/>/){my @array=split />/,$_;$id=$array[1];} #����>,��>��geneid����>�ֿ��������0�пգ���һ���ǻ���id��
  else{$cds{$id}=$_;}      #������>�ͷǿ���ʱ�������к���������õ��������һ�зֱ𸳸���ϣcds��ֵ�ͼ���
 
}
close IN;

open IN1,"f:\\ת¼��\\Perl\\Gene_variants";
open OUT,'>',"f:\\ת¼��\\Perl\\1.txt";
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
	
	if($type=~/D/){#������ʽ~������д��type eq "D";
		my $f=($site - 1)%3;		#%��ʾ��������
		if($f==0){$r_seq=$seq;
			        $v_seq="";
			       }
		elsif($f==1){$r_seq=substr($cds{$list[0]},$site - 2,$len + 3);#substr��ʾ����ϣ���������Ӧ�ĵ�һ����Ӧ���У��ӱ���site-2��ʼȡ����len+3��Ӧ���и�������r_seq;
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