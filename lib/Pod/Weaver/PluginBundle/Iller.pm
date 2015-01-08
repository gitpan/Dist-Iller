use 5.10.1;

package Pod::Weaver::PluginBundle::Iller;

our $VERSION = '0.1101'; # VERSION

use strict;
use warnings;
use Pod::Weaver::Config::Assembler;
use Path::Tiny;

sub xp {
    Pod::Weaver::Config::Assembler->expand_package(shift);
}

sub mvp_bundle_config {
    my @plugins = ();

    # check git config
    my $include_default_github = 0;
    my $git_config = path('.git/config');
    if($git_config->exists) {
        my $git_config_contents = $git_config->slurp_utf8;
        if($git_config_contents =~ m{github\.com:([^/]+)/(.+)\.git}) {
            $include_default_github = 1;
        }
        else {
            warn ('[PW/@Iller] No github url found');
        }
    }

    push @plugins => (
        ['@Iller/CorePrep',       xp('@CorePrep'),       { } ],
        ['@Iller/SingleEncoding', xp('-SingleEncoding'), { } ],
        ['@Iller/Name',           xp('Name'),            { } ],
        ['@Iller/Version',        xp('Version'),         { format => q{Version %v, released %{YYYY-MM-dd}d.} } ],
        ['@Iller/Prelude',        xp('Region'),          { region_name => 'prelude' } ],
    );

    foreach my $plugin (qw/Synopsis Description Overview Stability/) {
        push @plugins => ['@Iller/'.$plugin, xp('Generic'), { header => uc $plugin } ];
    }

    foreach my $plugin ( ['Attributes', 'attr'],
                         ['Methods', 'method'],
                         ['Functions', 'func'],
    ) {
        push @plugins => [ $plugin->[0], xp('Collect'), { command => $plugin->[1], header => uc $plugin->[0] } ];
    }
    push @plugins => (
        ['@Iller/Leftovers',             xp('Leftovers'), { } ],
        ['@Iller/postlude',              xp('Region'),    { } ],
        (
            !$ENV{'ILLER_MINTING'} && $include_default_github ?
            ['@Iller/Source::DefaultGitHub', xp('Source::DefaultGitHub'), { text => 'L<%s>' } ]
            :
            ()
        ),
        ['@Iller/Homepage::DefaultCPAN', xp('Homepage::DefaultCPAN'), { text => 'L<%s>' } ],
        ['@Iller/Authors',               xp('Authors'),   { } ],
        ['@Iller/Legal',                 xp('Legal'),     { } ],

        ['@Iller/List', xp('-Transformer'), { transformer => 'List' } ],
    );


    return @plugins;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Pod::Weaver::PluginBundle::Iller

=head1 VERSION

version 0.1101

=head1 AUTHOR

Erik Carlsson <info@code301.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
