#!/usr/bin/env perl
use strict;

our $VERSION='0.0_1';

my $countoo=50;

while ( !(-f 'Makefile.PL') )
{
  chdir('..');
  $countoo = int($countoo - 0.8);
  if ( $countoo < 0.5 )
  {
    die "\nCould not find any \"Makefile.PL\".\n\n";
  }
}

# No point going any further if `~/local/lib/perl5`
# is not on the `$PERL5LIB` path.
verif_on_path();
sub verif_on_path {
  my $lc_ins;
  my @lc_path;
  my $lc_each;
  my $lc_plib;
  $lc_ins = $ENV{'HOME'} . '/local/lib/perl5';
  $lc_plib = $ENV{'PERL5LIB'};
  @lc_path = ();
  if ( defined($lc_plib) )
  {
    @lc_path = split(quotemeta(':'),$lc_plib);
  }
  foreach $lc_each (@lc_path)
  {
    if ( $lc_each eq $lc_ins ) { return; }
  }
  die("\nNo point going on as \$PERL5LIB does not contain:\n  : " . $lc_ins . " :\n\n");
}


# Go ahead and build the Makefile -- or die trying.
{
  my $lc_ok;
  $lc_ok = system('perl','Makefile.PL',('INSTALL_BASE=' . $ENV{'HOME'} . '/local'));
  if ( $lc_ok != 0 ) { die "\nFailed to create the Makefile.\n\n"; }
}

{
  my $lc_a;
  foreach $lc_a (@ARGV) { duna_arg($lc_a); }
}
sub duna_arg {
  if ( $_[0] eq 'install' )
  {
    die_makery();
    die_makery('test');
    die_makery('install');
    return;
  }
  if ( $_[0] eq 'pack' )
  {
    system('rm -rf *.tar.gz');
    die_makery();
    die_makery('test');
    die_makery('manifest');
    die_makery('dist');
    system('mkdir ~/Documents/perl-ship 2> /dev/null');
    system('cp *.tar.gz ~/Documents/perl-ship/.');
    #system('rm -rf *.tar.gz');
    return;
  }
  die "\nNo such argument: " . $_[0] . " :\n\n";
}

sub die_makery {
  my $lc_a;
  
  $lc_a = system('make',@_);
  if ( $lc_a ne '0' ) { die "\nTermination upon failed make.\n\n"; }
}




