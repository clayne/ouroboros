#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use File::Slurp;

my $prefix = "ouroboros_";

my @shims = map "$prefix$_", qw/
    stack_init
    stack_prepush
    stack_putback

    stack_fetch
    stack_store

    stack_xpush_sv
    stack_xpush_iv
    stack_xpush_uv
    stack_xpush_nv
    stack_xpush_pv

    sv_iv
    sv_uv
    sv_nv
    sv_av
    sv_hv
    sv_rok
    sv_type

    call_sv
/;

open my $xs, ">", "autogenerated.inc";

my @names;
foreach my $shim (@shims) {
    push @names, my $name = $shim . "_ptr";
    $xs->print("void*\n$name()\n");
    $xs->print("CODE:\n\tRETVAL = $shim;\nOUTPUT:\n\tRETVAL\n\n");
}

my $package = "lib/Ouroboros.pm";
my $pm = read_file($package);
my $shims = join "", map "    $_\n", @names;
$pm =~ s/(our\s+\@EXPORT_OK\s*=\s*qw\()[^\)]*(\);)/$1\n$shims$2/m;
write_file($package, $pm);
