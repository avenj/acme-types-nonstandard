package Acme::Types::NonStandard;

use strictures 2;

use Scalar::Util 'isdual', 'reftype';

use Type::Library     -base;
use Type::Utils       -all;
use Types::TypeTiny   ();
use Types::Standard   -types;

declare ConfusingDualVar =>
  where {
    isdual($_)
    && "$_" =~ /^[0-9.]+$/   # yeah, I know
    && $_+0 ne "$_"
  };

declare FortyTwo =>
  as Int,
  where { $_ == 42 };
coerce FortyTwo =>
  from Any,
  via { 42 };

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
