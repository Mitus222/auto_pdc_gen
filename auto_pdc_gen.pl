
#!/usr/local/bin/perl -w

if(@ARGV == 3) {
  chomp ($dat = shift @ARGV);
  chomp ($refdes = shift @ARGV);
  chomp ($pdc_file = shift @ARGV);
}
else {
  print "Usage: auto_gen.pl pstxref.dat refdes pdc_file\n";
  print "use pstxref.dat file\n";
  exit(1);
}

open (IN, $dat) ||
      die "could not open file:", $dat, "\n";
open RESLT,">>$pdc_file";


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
                $pin = $1;
                $net = $2;
                $bank = $3;
                #if ( ($net !~ /VCCA/) && ($net !~ /P1V2/)&& ($net !~ /P2V5/) && ($net !~ /VCCL/) && ($net !~ /P3V3/) && ($net !~ /VCCD/) && ($net !~ /NC/) && ($net !~ /GND/)  )
                 if (  ($net !~ /P3_3VA/) && ($net !~ /GND/) && ($net !~ /P1V2A/) && ($net !~ /P2_5VA/) && ($net !~ /NC/) && ($net !~ /UNNAMED\S+/)) #&& ($net !~ /A2_5V/) && ($net !~ /A3P3V/) && ($net !~ /A1_2V/))
                 {
        	        if($bank =~ /MSIO\S{1,5}B(\d+).*/)
                    {
                     $bknum = $1;
                     if(($bknum =~ /1/) || ($bknum =~ /7/) || ($bknum =~ /8/))
                     {
                        print RESLT "set_io $net -pinname $pin -fixed yes -iostd LVCMOS25\n";
                     }
                     else
                     {
                        print RESLT "set_io $net -pinname $pin -fixed yes -iostd LVCMOS33\n";
                     }
                    }
                    else
                    {
                        print RESLT "set_io $net -pinname $pin\n";
                    }
                 }
                 $line = <IN>;
            }
        }
    }

  }
close(IN);
