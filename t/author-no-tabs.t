
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.09

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Dist/Iller.pm',
    'lib/Dist/Iller/App.pm',
    'lib/Dist/Zilla/MintingProfile/Iller.pm',
    'lib/Dist/Zilla/Plugin/Iller/MetaGeneratedBy.pm',
    'lib/Dist/Zilla/Plugin/Iller/MintFiles.pm',
    'lib/Dist/Zilla/PluginBundle/Iller.pm',
    'lib/Pod/Weaver/PluginBundle/Iller.pm',
    'script/iller',
    't/basic.t'
);

notabs_ok($_) foreach @files;
done_testing;
