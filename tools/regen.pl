#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use File::Slurp;

use constant {
    KIND => 0,
    TYPE => 1,
    NAME => 2,
    ARGS => 3,
    CONST => 1,
};

my @spec = map { !$_ || /^#/ ? () : [ split /\t/ ] }
    read_file("libouroboros.txt", chomp => 1);

my @funcs = grep $_->[KIND] eq "fn", @spec;
my @shims = map $_->[NAME], @funcs;

my @enums = map $_->[CONST], grep $_->[KIND] eq "enum", @spec;
my @consts = map $_->[CONST], grep $_->[KIND] eq "const", @spec;

my @names;
{
    open my $xs, ">", "autogenerated.inc";

    foreach my $shim (@shims) {
        push @names, my $name = $shim . "_ptr";
        $xs->print("void*\n$name()\n");
        $xs->print("CODE:\n\tRETVAL = $shim;\nOUTPUT:\n\tRETVAL\n\n");
    }
}

{
    my $package = "lib/Ouroboros.pm";
    my $pm = read_file($package);
    my $shims = join "", map "    $_\n", @names;
    $pm =~ s/(our\s+\@EXPORT_OK\s*=\s*qw\()[^\)]*(\);)/$1\n$shims$2/m;
    write_file($package, $pm);
}

{
    my $decls = do {
        local $" = ", ";
        join "", map sprintf("%s %s(pTHX_ %s);\n", @$_[TYPE, NAME], "@$_[ARGS..$#$_]"), @funcs
    };

    my $header = "libouroboros.h";
    my $ch = read_file($header);
    $ch =~ s!(/\*\s*functions\s*{\s*\*/)[^}]*(/\*\s*}\s*\*/)!$1\n$decls$2!m;
    write_file($header, $ch);
}

{
    my $enums = join "", map "    $_\n", @enums;
    my $consts = join "", map "    $_\n", @consts;

    my $makefile = "Makefile.PL";
    my $mf = read_file($makefile);
    $mf =~ s/(my\s+\@enums\s*=\s*qw\()[^\)]*(\);)/$1\n$enums$2/m;
    $mf =~ s/(my\s+\@consts\s*=\s*qw\()[^\)]*(\);)/$1\n$consts$2/m;
    write_file($makefile, $mf);
}
