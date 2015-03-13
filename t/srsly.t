use strict; use warnings;

use Test::More;
use Test::TypeTiny;

use List::Objects::WithUtils;

use Acme::Types::NonStandard -all;

use Scalar::Util 'dualvar';
should_pass dualvar(2, 4),      ConfusingDualVar;
should_pass dualvar(2.2, 4.4),  ConfusingDualVar;
should_fail dualvar(2, 'foo'),  ConfusingDualVar;
should_fail dualvar(2, 2),      ConfusingDualVar;

my $orig = 'foo';
my $r = \$orig;
my $rr = \$r;
my $rrr = \$rr;
should_pass $rrr,     RefRefRef;
should_fail $rr,      RefRefRef;
should_fail $r,       RefRefRef;
should_fail $orig,    RefRefRef;

should_pass [undef,undef], ReallySparseArray;
should_fail [undef, 1],    ReallySparseArray;
# FIXME coercion tests for ReallySparseArray

done_testing
