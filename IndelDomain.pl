#！perl -w
open DOMAIN,"<","D:/bioinfo/cf/Indel2Domain/domain_location.txt" or die $!;
open INDEL,"<","D:/bioinfo/cf/Indel2Domain/indel_location.txt" or die $!;
open RESULT,">","D:/bioinfo/cf/Indel2Domain/result.txt" or die $!;
while(<DOMAIN>){
	chomp;
	$SeqID=(split /\t/)[0];
	#print "$SeqID\n";
	push @{$SeqID},$_;
}

close DOMAIN;
while($line=<INDEL>){
		chomp $line;
	($GeneID,$IndelLocation)=split/\t/,$line;
#	print "$GeneID\t$IndelLocation";
	foreach  (@{$GeneID}){
		($DomainStart,$DomainEnd)=(split/\t/)[1,2];
		#print " $DomainStart\t$DomainEnd\n";
		if($IndelLocation>=$DomainStart and $IndelLocation<=$DomainEnd){
			$Bingo=1;
			$CountInDomain++;
			print RESULT "$line\t 1\n";
			last;
		}else{
			$Bingo=0;
			next;
			}
	}
	if(!$Bingo){
		$CountOutDomain++;
		print RESULT "$line\t -1\n";
	}
}
print "$CountInDomain 个Indel 在蛋白结构域内,有$CountOutDomain 个Indel 在蛋白结构域外";
		
		
		
		
