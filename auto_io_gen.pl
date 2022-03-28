#!/usr/local/bin/perl -w

if(@ARGV == 4) {
  chomp ($dat = shift @ARGV);
  chomp ($refdes = shift @ARGV);
  chomp ($io_file = shift @ARGV);
  chomp ($inst_file = shift @ARGV);
}
else {
  print "Usage: auto_gen.pl pstxref.dat refdes io_file inst_file\n";
  print "use pstxref.dat file\n";
  exit(1);
}

open (IN, $dat) ||
      die "could not open file:", $dat, "\n";
open IO,">>$io_file";
open INST,">>$inst_file";


while (<IN>) {
  chomp;

  if (/(\S+)\s\s(I\d+)\s\s(\S+)$/)
  {
    my $ref = $3;

    if ($ref =~ /\b$refdes\b/)
    {
            $line = <IN>;
            while ($line =~ /^\s*(\S+)\s+(\S+)\s+(\w+)/)
            {
                $net = $2;
                #if ( ($net !~ /VCCA/) && ($net !~ /P1V2/)&& ($net !~ /P2V5/) && ($net !~ /VCCL/) && ($net !~ /P3V3/) && ($net !~ /VCCD/) && ($net !~ /NC/) && ($net !~ /GND/)  )
                 if (  ($net !~ /P3_3VA/) && ($net !~ /GND/) && ($net !~ /P1V2A/) && ($net !~ /P2_5VA/) && ($net !~ /NC/) && ($net !~ /UNNAMED\S+/)) #&& ($net !~ /A2_5V/) && ($net !~ /A3P3V/) && ($net !~ /A1_2V/))
                 {
                        print IO "$net;\n";
                        print INST ".$net($net),\n";
                 }
                 $line = <IN>;
            }
        }
    }

  }
close(IN);

