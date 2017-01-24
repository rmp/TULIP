# -*- mode: cperl; tab-width: 8; indent-tabs-mode: nil; basic-offset: 2 -*-
# vim:ts=8:sw=2:et:sta:sts=2

package critic;
use strict;
use warnings;
use Test::More;
use English qw(-no_match_vars);

our $VERSION = q[0.4.0];

if ( not $ENV{TEST_AUTHOR} ) {
  my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run.';
  plan( skip_all => $msg );
}

eval {
  require Test::Perl::Critic;
};

if($EVAL_ERROR) {
  plan skip_all => 'Test::Perl::Critic not installed';

} else {
  Test::Perl::Critic->import(
			     -severity => 1,
			     -exclude  => [qw(CodeLayout::RequireTidyCode
					      NamingConventions::Capitalization
					      PodSpelling
					      ValuesAndExpressions::RequireConstantVersion)],
			    );
  all_critic_ok(qw(lib scripts bin));
}

1;
