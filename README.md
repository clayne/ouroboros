# Ouroboros

Perl XS macros re-exported as C functions.

[![Build status: Windows](https://ci.appveyor.com/api/projects/status/tmmk51e2h25qsd99/branch/master?svg=true)](https://ci.appveyor.com/project/vickenty/ouroboros/branch/master)
[![Build Status: Linux](https://travis-ci.org/vickenty/ouroboros.svg?branch=master)](https://travis-ci.org/vickenty/ouroboros)

## Why

* Write Perl extensions in any language that can produce and link shared
libraries.

* Generate native Perl subs at run-time using a just-in-time compiler.

## Contents

* `libouroboros.c`
* `libouroboros.h` - a library of wrappers around various XS macros.

* `libouroboros.txt` - main source file for the entire thing, lists
  all supported functions, their signatures, and constants. Can be
  used to automatically generate bindings in other languages.

* `Ouroboros` - Perl package that exports pointers to libouroboros
  functions as well as many necessary constants needed to call them
  correctly (like values of `svtype` enumeration and flags).

* `Ouroboros::Spec` - parser for `libouroboros.txt`.

## Requirements

Perl 5.20 or later.

A working C compiler.

## Building

    perl Makefile.PL
    make
    make install
