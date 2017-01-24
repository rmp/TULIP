# -*- mode: cperl; tab-width: 8; indent-tabs-mode: nil; basic-offset: 2 -*-
# vim:ts=8:sw=2:et:sta:sts=2
use strict;
use warnings;
use Module::Build;
use Carp;
use English qw(-no_match_vars);

my $VERSION = q[2.44.1];
my $builder = Module::Build->new(
                                 module_name          => 'TULIP',
                                 dist_author          => 'Christiaan Henkel <c.v.henkel@biology.leidenuniv.nl>',
                                 dist_version         => $VERSION,
                                 dist_abstract        => q[TULIP assembler],
#                                 license              => 'gpl',
                                 requires             => {
                                                          'strict'                    => '1.03',
                                                          'warnings'                  => '1.05',
                                                          'base'                      => '2.07',
                                                          'Carp'                      => '1.26',
                                                          'English'                   => '1.02',
                                                         },
                                 recommends           => {
                                                         },
                                 configure_requires   => {
                                                          'Module::Build' => 0.38,
                                                         },
                                 build_requires       => {
                                                          'File::Touch'             => '0.08',
                                                          'Test::More'              => '0.62',
                                                         },
                                 build_recommends     => {
                                                          'Test::Distribution'      => '2.00',
                                                          'Test::Perl::Critic'      => '1.01',
                                                         },
                                 script_files         => [qw(bin/tulipbulb.perl bin/tulipseed.perl)],
                                 use_tap_harness      => 1,
                                 recursive_test_files => 1,
                                 tap_harness_args     => {
                                                          jobs      => 10,
                                                          verbosity => 1,
                                                          merge     => 1,
                                                         },
                                );

$builder->create_build_script();
