package Dist::Iller;

our $VERSION = '0.1100'; # VERSION

use strict;
use warnings;
use 5.10.1;

1;

# ABSTRACT: Another way to use Dist::Zilla

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Iller - Another way to use Dist::Zilla

=head1 VERSION

version 0.1002

=head1 SYNOPSIS

  iller new Dist::Name

=head1 DESCRIPTION

Dist::Iller is a L<Dist::Zilla> profile, minter, L<Dist::Zilla plugin bundle|Dist::Zilla::PluginBundle::Iller>, and L<Pod::Weaver plugin bundle|Pod::Weaver::PluginBundle::Iller>.

This was inspired by L<Dist::Milla>, which is recommended if you are looking for a straight-forward way to start using L<Dist::Zilla>.

The reason for not just releasing the plugin bundles is the C<iller> command. Together with the profile it initializes a git repository, runs C<dzil build> on it, and then adds the newly created files to the repo. I find that useful.

=head1 SEE ALSO

L<Dist::Zilla>

L<Dist::Milla>

L<Pod::Weaver>

=head1 AUTHOR

Erik Carlsson <info@code301.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
