my $default-batch;
my $default-degree;
INIT with Iterable.hyper.configuration {
    $default-batch  := .batch;
    $default-degree := .degree;
}

my sub hyperize(\iterable, $batch, $degree?) is export {
    $degree.defined && $degree == 1
      ?? iterable
      !! iterable.hyper:
           :batch( $batch  // $default-batch),
           :degree($degree // $default-degree)
}

my sub racify(\iterable, $batch, $degree?) is export {
    $degree.defined && $degree == 1
      ?? iterable
      !! iterable.race:
           :batch( $batch  // $default-batch),
           :degree($degree // $default-degree)
}

=begin pod

=head1 NAME

hyperize - helper subs to hyperize iterables with defaults

=head1 SYNOPSIS

=begin code :lang<raku>

use hyperize;

sub MAIN(:$batch, :$degree) {
    my @foo = ^1000;
    @foo.&hyperize($batch, $degree);  # don't worry about defaults
}

=end code

=head1 DESCRIPTION

hyperize exports two subroutines to make it easier to handle defaults for
C<batch> and C<degree> from e.g. CLI scripts.  As such, these subs are
intended to replace the C<.hyper> and C<.race> methods on C<Iterable>s.

The problem with these methods, is that they (currently) do not take
undefined values for their C<:batch> and C<:degree> arguments, forcing
the caller to decide what sane defaults are.  With the subroutines
provided by this module, you don't have to worry about that as a developer
of CLI scripts anymore.

If there is a C<degree> specified, and its B<1>, then the first argument
(the invocant if used as C<.&hyperize>) will be returned, as there will be
no sense in trying to C<hyper> or C<race> anything.

=head1 EXPORTED SUBROUTINES

=head2 hyperize

=begin code :lang<raku>

@foo.&hyperize($batch).map: { ...  }

@foo.&hyperize($batch, $degree).map: { ...  }

=end code

The C<hyperize> subroutine takes 2 or 3 arguments.  The first argument
is an C<Iterable> on which a hyper sequence (aka C<HyperSeq>) should be
returned. This is then typically the invocant of a C<.map> of C<.grep>.

The second argument is the size of batches that should be used (aka the
C<:batch> argument to C<.hyper>.  If the value specified is undefined,
then the default value for batches will be assumed (whatever that may be,
as determined by the core).

The third argument is optional.  It indicates the degrees of parallelization
(aka the number of CPU cores to be used, aka the C<:degree> argument to
C<.hyper>.  If it is not specified, or the value specified is undefined,
then the default value for degree will be assumed (whatever that may be,
as determined by the core).

=head2 racify

=begin code :lang<raku>

@foo.&racify($batch).map: { ...  }

@foo.&racify($batch, $degree).map: { ...  }

=end code

The same as C<hyperize>, but will call the C<.race> method (causing unordered
results) rather than the C<.hyper> method.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/hyperize .
Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
