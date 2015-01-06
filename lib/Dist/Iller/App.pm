package Dist::Iller::App;

our $VERSION = '0.1101'; # VERSION

use 5.10.1;
use strict;
use warnings;
use parent 'Dist::Zilla::App';
use IPC::Run;
use File::chdir;
use Git::Wrapper;

sub _default_command_base { 'Dist::Zilla::App::Command' }

sub prepare_command {
    my $self = shift;

    my($cmd, $opt, @args) = $self->SUPER::prepare_command(@_);

    if($cmd->isa('Dist::Zilla::App::Command::install')) {
        $opt->{'install_command'} ||= 'cpanm .';
    }
    elsif($cmd->isa('Dist::Zilla::App::Command::release')) {
        $ENV{'DZIL_CONFIRMRELEASE_DEFAULT'} // 1;
    }
    elsif ($cmd->isa('Dist::Zilla::App::Command::new')) {
        $ENV{'ILLER_MINTING'} = 1;
        IPC::Run::run [qw/dzil new --provider Author::CSSON --profile csson/, $args[0] ];
        my $dir = $args[0];
        $dir =~ s{::}{-}g;

        $CWD = $dir;
        my $git = Git::Wrapper->new('.');
        $git->add('.');
        $git->commit(qw/ --message Init /, { all => 1 });
        IPC::Run::run [qw/dzil build --no-tgz/];
        IPC::Run::run [qw/dzil clean/];
        $git->add('.');
        $git->commit(qw/ --message Init /, { all => 1 });
        exit;
    }

    return $cmd, $opt, @args;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Iller::App

=head1 VERSION

version 0.1101

=head1 AUTHOR

Erik Carlsson <info@code301.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
