# -*- mode: cperl; tab-width: 8; indent-tabs-mode: nil; basic-offset: 2 -*-
# vim:ts=8:sw=2:et:sta:sts=2

use strict;
use warnings;
use Test::More;

our $VERSION = q[0.4.0];

BEGIN {
  if($ENV{TEST_AUTHOR}) {
    # avoids irritating Test::Kwalitee warning about environment variables
    $ENV{RELEASE_TESTING} = 1;
  }

  if(!$ENV{RELEASE_TESTING}) {
    plan skip_all => q[Set $ENV{RELEASE_TESTING} or $ENV{TEST_AUTHOR} true to run];
  }

  if(-e 'MYMETA.yml' && !-e 'META.yml') {
    qx[ln -s MYMETA.yml META.yml];
  }

  eval {
    require Test::Kwalitee;

    Test::Kwalitee->import( tests => [ qw( -no_symlinks ) ] );
  };

  if($@) {
    plan skip_all => q[Test::Kwalitee not installed];
  }
}

#done_testing;
