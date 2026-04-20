use strict;
use warnings;

use Test::More tests => 2;

my $lc_script;   # path to the source script
my $lc_cmd;      # command to run the script
my $lc_out;      # captured output
my $lc_rc;       # exit status

$lc_script = 'shaperlmaker.pl';
ok( -f $lc_script, 'source script exists' );

$lc_cmd = "perl $lc_script 2>&1";
$lc_out = `$lc_cmd`;
$lc_rc = $? >> 8;

ok( $lc_rc == 0, 'script ran without failure' );
