package Acme::Types::NonStandard;

use strictures 2;

use Scalar::Util 'isdual', 'reftype';

use Type::Library   -base;
use Type::Utils     -all;
use Types::TypeTiny ();

use Types::Standard       -types;
use List::Objects::Types  -types;

# ConfusingDualVar whose stringy value must be a number different from the
# numeric value
declare ConfusingDualVar =>
  where {
    isdual($_)
    && (my $s = "$_") =~ /^[0-9.]+$/
    && (my $n = $_+0) ne "$_"
  };

# RefRefRef which must be a reference to a reference to a reference
declare RefRefRef =>
  where {
    ref $_
    && ref ${ $_ }
    && ref ${ ${ $_ } }
  };

# SparseArray which can only contain undefs
declare ReallySparseArray => as ArrayRef[Undef];

# CircularHashOfNothing which must contain at least one circular
# reference and no useful data


1;

# vim: ts=2 sw=2 et sts=2 ft=perl
