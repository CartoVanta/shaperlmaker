use strict;
use warnings;

use Test::More tests => 2;

my $proj_script;   # path to the source script
my $proj_out;      # captured output
my $proj_rc;       # exit status

$proj_script = 'shaperlmaker.pl';
ok( -f $proj_script, 'existence of -- shaperlmaker.pl' );

$proj_rc = system('perl -c ' . $proj_script);

ok( $proj_rc == 0, 'syntax check -- shaperlmaker.pl' );
