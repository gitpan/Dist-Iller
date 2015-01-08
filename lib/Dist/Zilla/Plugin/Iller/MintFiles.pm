package Dist::Zilla::Plugin::Iller::MintFiles;

our $VERSION = '0.1101'; # VERSION

use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';
with 'Dist::Zilla::Role::TextTemplate';

override 'merged_section_data' => sub {
    my $self = shift;

    my $data = super;

    for my $name (keys %$data) {
        $data->{ $name } = \$self->fill_in_string( ${ $data->{ $name } },
                                                   {
                                                      dist => \($self->zilla),
                                                      plugin => \($self),
                                                   },
        );
    }

    return $data;
};

1;

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Plugin::Iller::MintFiles

=head1 VERSION

version 0.1101

=head1 AUTHOR

Erik Carlsson <info@code301.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__DATA__
___[ Changes ]___
Revision history for {{ $dist->name }}

{{ '{{$NEXT}}' }}
   - Initial release

___[ .gitignore ]___
/{{ $dist->name }}-*
/.build
/_build*
/Build
MYMETA.*
!META.json
/.prove

___[ t/basic.t ]___
use strict;
use Test::More;
use {{ (my $mod = $dist->name) =~ s/-/::/g; $mod }};

# replace with the actual test
ok 1;

done_testing;

__[ cpanfile ]___
requires 'perl', '5.010001';

# requires 'Some::Module', 'VERSION';

on test => sub {
    requires 'Test::More', '0.96';
    requires 'Test::NoTabs';
};

___[ dist.ini ]___
name = {{ $dist->name }}
author = {{ $dist->authors->[0] }}
license = Perl_5
copyright_holder = {{ $dist->authors->[0] }}

[@Iller]
is_private = 0

NextVersion::Semantic.major =
NextVersion::Semantic.minor = API Changes, New Features, Enhancements
NextVersion::Semantic.revision = Revision, Bug Fixes, Documentation, Meta
NextVersion::Semantic.format = %d.%02d%02d
NextVersion::Semantic.numify_version = 0
