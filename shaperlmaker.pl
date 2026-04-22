#!/usr/bin/env perl
use strict;

our $VERSION='0.0_1';

my $countoo=50;
my $errorput = '';
my $hightarget;
my $doingwell = 1;

my $succeeded = {};

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
# is not on the `$PERL5LIB` path or `~/local/bin`
# is not on the `$PATH` path.
verif_l_on_path('PERL5LIB','/local/lib/perl5');
verif_l_on_path('PATH','/local/bin');
sub verif_l_on_path {
  my $lc_ins;
  my @lc_path;
  my $lc_each;
  my $lc_plib;
  $lc_ins = $ENV{'HOME'} . $_[1];
  $lc_plib = $ENV{$_[0]};
  @lc_path = ();
  if ( defined($lc_plib) )
  {
    @lc_path = split(quotemeta(':'),$lc_plib);
  }
  foreach $lc_each (@lc_path)
  {
    if ( $lc_each eq $lc_ins ) { return; }
  }
  die("\nNo point going on as \$" . $_[0] . " does not contain:\n  : " . $lc_ins . " :\n\n");
}


# Go ahead and build the Makefile -- or die trying.
{
  my $lc_ok;
  $lc_ok = system('perl','Makefile.PL',('INSTALL_BASE=' . $ENV{'HOME'} . '/local'));
  if ( $lc_ok != 0 ) { die "\nFailed to create the Makefile.\n\n"; }
}

{
  my $lc_a;
  my $lc_ok;
  foreach $lc_a (@ARGV)
  {
    $lc_ok = duna_arg($lc_a);
    $doingwell = ( $doingwell && $lc_ok );
  }
  if ( !$doingwell ) { die("\n" . $errorput . "\n"); }
}
sub duna_arg {
  my $lc_ok;
  my $lc_nomi;
  $hightarget = $_[0];
  if ( $_[0] eq 'x' )
  {
    if ( !$doingwell ) { die("\n" . $errorput . "\n"); }
    return 1;
  }
  if ( $_[0] eq 'install' )
  {
    $lc_ok = try_makery();
    if ( $lc_ok ) { $lc_ok = try_makery('test'); }
    if ( $lc_ok ) { try_makery('install'); }
    return $lc_ok;
  }
  if ( $_[0] eq 'pack' )
  {
    if ( $succeeded->{'s:pack'} ) { return 1; }
    system('rm -rf *.tar.gz');
    $lc_ok = try_makery();
    if ( $lc_ok ) { $lc_ok = try_makery('test'); }
    if ( $lc_ok ) { try_makery('manifest'); }
    if ( $lc_ok ) { try_makery('dist'); }
    if ( $lc_ok )
    {
      $succeeded->{'s:pack'} = 1;
      system('mkdir ~/Documents/perl-ship 2> /dev/null');
      system('cp *.tar.gz ~/Documents/perl-ship/.');
    }
    return $lc_ok;
  }
  $lc_nomi = $_[0];
  $lc_nomi =~ s/'/\\'/g;
  die("\n" . $errorput . "No such argument-value: '" . $lc_nomi . "'\n\n");
}

sub try_makery {
  my $lc_a;
  my @lc_allgo;
  my $lc_taggy;
  
  
  $lc_taggy = 'x';
  @lc_allgo = ();
  if ( defined($_[0]) )
  {
    $lc_taggy = ':' . $_[0];
    @lc_allgo = ( $_[0] );
  }
  if ( $succeeded->{$lc_taggy} ) { return 1; }
  
  print "DOING MAKE COMMAND:";
  if ( @lc_allgo ) { print " " . $lc_allgo[0] . " :"; }
  print "\n";
  
  $lc_a = system('make',@lc_allgo);
  if ( $lc_a != 0 )
  {
    $errorput .= $hightarget . ': ';
    if ( @lc_allgo )
    {
      my $lc3_a;
      my $lc3_b;
      $errorput .= "Failed to make:";
      foreach $lc3_a (@lc_allgo)
      {
        $lc3_b = $lc3_a;
        $lc3_b =~ s/'/\\'/g;
        $errorput .= " '" . $lc3_b . "'";
      }
      $errorput .= "\n";
    } else {
      $errorput .= "Failed basic make target.\n";
    }
    return 0;
  }
  $succeeded->{$lc_taggy} = 1;
  return 1;
}




