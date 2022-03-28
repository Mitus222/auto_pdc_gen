#!/usr/bin/perl

use 5.010;
use strict;
use warnings;
use diagnostics;#warning info


my ($fileA,$fileB) = @ARGV;

open A,'<',$fileA or die "Unable to open file:$fileA:$!";
my %ta;
my $i;
while(<A>){
  chomp;
  $ta{$_} = ++$i;
}
close A;

open B,'<',$fileB or die "Unable to open file:$fileB:$!";
#open COMM_AB, ">$fileA.comm" or die "Unable to create comm file for $fileA and $fileB:$!";
open COMM_AB, ">$fileA.comm.txt" or die "Unable to create comm file for $fileA and $fileB:$!";
my $countAB;
my @B;
while(<B>){
    chomp;
    unless (defined $ta{$_}){
        push @B,$_;
    }else{
        $ta{$_} = 0;
        $countAB++;
        print COMM_AB $_ ."\n";
    }
}
close B;
print "$countAB lines both in $fileA and $fileB\n";
close COMM_AB;


# Output diff to different files respectively
#open DIFF_A, ">$fileA.diff" or die "Unable to create diff file for $fileA:$!";
open DIFF_A, ">$fileA.diff.txt" or die "Unable to create diff file for $fileA:$!";
my $countA;
my %tt = reverse %ta;
foreach (sort keys %tt) {
    $countA += $_>0? print DIFF_A $tt{$_}."\n":0;
}

print "$countA lines in $fileA but not in $fileB\n";
close DIFF_A;


#open DIFF_B, ">$fileB.diff" or die "Unable to create diff file for $fileB:$!";
open DIFF_B, ">$fileB.diff.txt" or die "Unable to create diff file for $fileB:$!";
my $countB = scalar @B;
print DIFF_B $_."\n" foreach @B;
print "$countB lines in $fileB but not in $fileA\n";

if ($countA == 0 and $countB ==0 ){
    print STDOUT "The two files are identical\n";
}

close DIFF_B;
