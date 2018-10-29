#!/usr/bin/perl-w



$target="nnn";
$list="list1.txt";
$CDSsource="1.txt";



open(LIST1,"<$list");
while ($list=<LIST1>) {     
	  chomp($list);
	 # print "$sequence";
    push(@list,$list);
    
}

close(LIST1);




open(FASTA,">$target");
open (CDSfile,"<$CDSsource");
#open(SEQ,">seq.txt");
#open(SEQUENCE,">sequence.txt");



LINE:while (<CDSfile>) {
	chomp;
($HighseqID,$genename,$identity,$matchlength,$mismatch,$gap,$HiseqStart,$HiseqEnd,$geneStart,$geneEnd)=split(/\t/);
$Query="$genename\t$identity\t$matchlength\t$mismatch\t$gap\t$HiseqStart\t$HiseqEnd\t$geneStart\t$geneEnd";
$QueryReverse="$genename\t$identity\t$matchlength\t$mismatch\t$gap\t$HiseqStart\t$HiseqEnd\t$geneEnd\t$geneStart";





  	 foreach $list (@list){
  	 	#print SEQUENCE "$sequence\n";
  	 	if (($Query eq $list ) or($QueryReverse eq $list )){
  	 		
  	 		print FASTA "$HighseqID\t$list\n";
  	 		next LINE;
  	 		}
  	
  }
   ;
  }
  	 
  
 
close (CDSfile);
close(FASTA);

