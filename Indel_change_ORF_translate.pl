#!/usr/bin/perl
use strict;
use warnings;

open IN,"f:\\转录组\\Perl\\1.txt";
open OUT,'>',"f:\\转录组\\Perl\\out_translate_1.txt";

my %genetic_code = (                 
     'TCA' => 'S',    # Serine      
     'TCC' => 'S',    # Serine      
     'TCG' => 'S',    # Serine      
     'TCT' => 'S',    # Serine      
     'TTC' => 'F',    # Phenylalanine      
     'TTT' => 'F',    # Phenylalanine      
     'TTA' => 'L',    # Leucine      
     'TTG' => 'L',    # Leucine      
     'TAC' => 'Y',    # Tyrosine       
     'TAT' => 'Y',    # Tyrosine      
     'TAA' => '_',    # Stop      
     'TAG' => '_',    # Stop      
     'TGC' => 'C',    # Cysteine      
     'TGT' => 'C',    # Cysteine      
     'TGA' => '_',    # Stop      
     'TGG' => 'W',    # Tryptophan      
     'CTA' => 'L',    # Leucine      
     'CTC' => 'L',    # Leucine      
     'CTG' => 'L',    # Leucine      
     'CTT' => 'L',    # Leucine      
     'CCA' => 'P',    # Proline      
     'CCC' => 'P',    # Proline      
     'CCG' => 'P',    # Proline      
     'CCT' => 'P',    # Proline      
     'CAC' => 'H',    # Histidine      
     'CAT' => 'H',    # Histidine      
     'CAA' => 'Q',    # Glutamine      
     'CAG' => 'Q',    # Glutamine      
     'CGA' => 'R',    # Arginine      
     'CGC' => 'R',    # Arginine      
     'CGG' => 'R',    # Arginine      
     'CGT' => 'R',    # Arginine      
     'ATA' => 'I',    # Isoleucine      
     'ATC' => 'I',    # Isoleucine      
     'ATT' => 'I',    # Isoleucine      
     'ATG' => 'M',    # Methionine      
     'ACA' => 'T',    # Threonine      
     'ACC' => 'T',    # Threonine      
     'ACG' => 'T',    # Threonine      
     'ACT' => 'T',    # Threonine      
     'AAC' => 'N',    # Asparagine      
     'AAT' => 'N',    # Asparagine      
     'AAA' => 'K',    # Lysine      
     'AAG' => 'K',    # Lysine      
     'AGC' => 'S',    # Serine      
     'AGT' => 'S',    # Serine      
     'AGA' => 'R',    # Arginine      
     'AGG' => 'R',    # Arginine      
     'GTA' => 'V',    # Valine      
     'GTC' => 'V',    # Valine      
     'GTG' => 'V',    # Valine      
     'GTT' => 'V',    # Valine      
     'GCA' => 'A',    # Alanine      
     'GCC' => 'A',    # Alanine      
     'GCG' => 'A',    # Alanine      
     'GCT' => 'A',    # Alanine          
     'GAC' => 'D',    # Aspartic Acid      
     'GAT' => 'D',    # Aspartic Acid      
     'GAA' => 'E',    # Glutamic Acid      
     'GAG' => 'E',    # Glutamic Acid      
     'GGA' => 'G',    # Glycine      
     'GGC' => 'G',    # Glycine      
     'GGG' => 'G',    # Glycine      
     'GGT' => 'G',    # Glycine      
); 

while(<IN>){
	chomp;
	my @list=split /\t/,$_;
	my $r_pep;
	my $v_pep;
	
	if($list[3]){
	    for(my $i=0;$i<(length($list[3])-2);$i+=3){
			   my $code=substr($list[3],$i,3);
         $r_pep.=$genetic_code{$code};
         if($genetic_code{$code} eq "_"){last;}
      }
  }else{
  	  $r_pep="";
  	   }
  	
  if($list[4]){
	    for(my $i=0;$i<(length($list[4])-2);$i+=3){
			   my $code=substr($list[4],$i,3);
         $v_pep.=$genetic_code{$code};
         if($genetic_code{$code} eq "_"){last;}
      }
  }else{
  	  $v_pep="";
  	   }
  	   
  print OUT "$list[0]\t$list[1]\t$list[2]\t$r_pep\t$v_pep\t$list[5]\n";
  
 }
 close IN;