#!/usr/bin/perl -w
use lib "/usr/local/netfpga/lib/Perl5";
use strict;

my $YLRCPU_COMMAND_REG        = 0x2000100;
my $YLRCPU_ADDRESS_REG        = 0x2000104;
my $YLRCPU_IMEM_REG           = 0x2000108;
my $YLRCPU_UPPER_DMEM_REG     = 0x200010C;
my $YLRCPU_LOWER_DMEM_REG     = 0x2000110;
my $YLRCPU_UPPER_DMEM_READ    = 0x2000114;
my $YLRCPU_LOWER_DMEM_READ    = 0x2000118;


sub regwrite {
   my( $addr, $value ) = @_;
   my $cmd = sprintf("regwrite 0x%08x 0x%08x", $addr, $value);
   system($cmd) == 0 or die "Failed: $cmd\n";
}

sub regread {
   my( $addr ) = @_;
   my $cmd = sprintf("regread 0x%08x", $addr);
   my @out = `$cmd`;
   my $result = $out[0];
   if ($result =~ m/Reg (0x[0-9a-f]+).*:\s+(0x[0-9a-f]+)/) {
      return $2;
   }
   die "Unexpected regread output\n";
}

# CPU Operations
# command[0] = write IMem
# command[1] = write DMem
# command[2] = read DMem

sub write_imem {
   my ($addr, $instr) = @_;
   regwrite($YLRCPU_ADDRESS_REG, $addr);
   regwrite($YLRCPU_IMEM_REG, $instr);
   regwrite($YLRCPU_COMMAND_REG, 0x1);   # write IMem
   regwrite($YLRCPU_COMMAND_REG, 0x0);   # clear command
}

sub write_dmem {
   my ($addr, $upper, $lower) = @_;
   regwrite($YLRCPU_ADDRESS_REG, $addr);
   regwrite($YLRCPU_UPPER_DMEM_REG, $upper);
   regwrite($YLRCPU_LOWER_DMEM_REG, $lower);
   regwrite($YLRCPU_COMMAND_REG, 0x2);   # write DMem
   regwrite($YLRCPU_COMMAND_REG, 0x0);   # clear
}

sub read_dmem {
   my ($addr) = @_;
   regwrite($YLRCPU_ADDRESS_REG, $addr);
   regwrite($YLRCPU_COMMAND_REG, 0x4);   # read DMem

   my $upper = regread($YLRCPU_UPPER_DMEM_READ);
   my $lower = regread($YLRCPU_LOWER_DMEM_READ);

   print "DMEM[$addr] = $upper $lower\n";

   regwrite($YLRCPU_COMMAND_REG, 0x0);   # clear
}

sub usage {
   print "Usage:\n";
   print "  ylrcpu_reg imem <addr> <hex_instr>\n";
   print "  ylrcpu_reg dmemw <addr> <upper32> <lower32>\n";
   print "  ylrcpu_reg dmemr <addr>\n";
}

my $numargs = $#ARGV + 1;
if ($numargs < 1) {
   usage();
   exit(1);
}

my $cmd = $ARGV[0];

if ($cmd eq "imem") {
   die "Need addr and instr\n" if ($numargs < 3);
   write_imem($ARGV[1], hex($ARGV[2]));
}
elsif ($cmd eq "dmemw") {
   die "Need addr upper lower\n" if ($numargs < 4);
   write_dmem($ARGV[1], hex($ARGV[2]), hex($ARGV[3]));
}
elsif ($cmd eq "dmemr") {
   die "Need addr\n" if ($numargs < 2);
   read_dmem($ARGV[1]);
}
else {
   usage();
}
