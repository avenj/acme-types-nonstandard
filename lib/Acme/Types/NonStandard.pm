package Acme::Types::NonStandard;

use strict; use warnings;

use Scalar::Util 'isdual', 'reftype';

use Type::Library     -base;
use Type::Utils       -all;
use Types::TypeTiny   ();
use Types::Standard   -types;

declare ConfusingDualVar =>
  where { isdual($_) && "$_" =~ /^[0-9.]+$/ && $_+0 ne "$_" };

declare FortyTwo => as Int() => where { $_ == 42 };
coerce  FortyTwo => from Any() => via { 42 };

declare RefRefRef => where { ref $_ && ref ${ $_ } && ref ${ ${ $_ } } };

declare ReallySparseArray => as ArrayRef[Undef];


print "I'm not sorry.\n" unless caller; 1;

=pod

=head1 NAME

Acme::Types::NonStandard - unbundled set of stupid types for Type::Tiny

=head1 SYNOPSIS

  use Acme::Types::NonStandard -types;

=head1 DESCRIPTION

=head3 ConfusingDualVar

A dualvar (see L<Scalar::Util/dualvar>) whose stringy value must be a floating
point number or integer distinct from the numeric value (to maximize debugging
confusion).

=head3 FortyTwo

The number 42. Always.

Can be coerced from Any (to the number 42).

=head3 ReallySparseArray

An array that only contains C<undef> (but as many of them as you'd like!)

=head3 RefRefRef

A reference to a reference to a reference (to ensure adequate levels of
indirection).

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>, but I'm going to loudly deny while pointing
fingers at C<popl> and C<hobbs> on C<irc.perl.org#moose>.

Licensed under the same terms as Perl.

Patches or suggestions regarding other completely stupid types welcome, as
long as they're not in any way useful.

=cut
