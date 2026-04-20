use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'App::Shaperlmaker',
  VERSION_FROM => 'shaperlmaker.pl',
  ABSTRACT     => 'Helper tool for building and installing Perl projects under your own account',
  AUTHOR       => 'Sophia Elizabeth Shapira',
  LICENSE      => 'perl',
  EXE_FILES    => ['script/shaperlmaker'],
  PREREQ_PM    => {},
);

sub MY::postamble {
  my $lc_copycmd;  # command to generate script/shaperlmaker from shaperlmaker.pl

  if ( $^O =~ /\A(?:MSWin32|cygwin)\z/ ) {
    $lc_copycmd = '$(NOECHO) $(CP) shaperlmaker.pl script/shaperlmaker';
  }
  else {
    $lc_copycmd = '$(NOECHO) cat shaperlmaker.pl > script/shaperlmaker';
  }

  return
      "pure_all :: script/shaperlmaker\n"
    . "\n"
    . "script/shaperlmaker : shaperlmaker.pl\n"
    . "\t\$(NOECHO) \$(MKPATH) script\n"
    . "\t" . $lc_copycmd . "\n"
    . "\t\$(NOECHO) \$(CHMOD) 755 script/shaperlmaker\n"
    . "\n"
    . "realclean purge ::\n"
    . "\t\$(RM_F) script/shaperlmaker\n";
}
