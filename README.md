NAME
====

hyperize - helper subs to hyperize iterables with defaults

SYNOPSIS
========

```raku
use hyperize;

sub MAIN(:$batch, :$degree) {
    my @foo = ^1000;
    @foo.&hyperize($batch, $degree);  # don't worry about defaults
}
```

DESCRIPTION
===========

hyperize exports two subroutines to make it easier to handle defaults for `batch` and `degree` from e.g. CLI scripts. As such, these subs are intended to replace the `.hyper` and `.race` methods on `Iterable`s.

The problem with these methods, is that they (currently) do not take undefined values for their `:batch` and `:degree` arguments, forcing the caller to decide what sane defaults are. With the subroutines provided by this module, you don't have to worry about that as a developer of CLI scripts anymore.

EXPORTED SUBROUTINES
====================

hyperize
--------

```raku
@foo.&hyperize($batch).map: { ...  }

@foo.&hyperize($batch, $degree).map: { ...  }
```

The `hyperize` subroutine takes 2 or 3 arguments. The first argument is an `Iterable` on which a hyper sequence (aka `HyperSeq`) should be returned. This is then typically the invocant of a `.map` of `.grep`.

The second argument is the size of batches that should be used (aka the `:batch` argument to `.hyper`. If the value specified is undefined, then the default value for batches will be assumed (whatever that may be, as determined by the core).

The third argument is optional. It indicates the degrees of parallelization (aka the number of CPU cores to be used, aka the `:degree` argument to `.hyper`. If it is not specified, or the value specified is undefined, then the default value for degree will be assumed (whatever that may be, as determined by the core).

racify
------

```raku
@foo.&racify($batch).map: { ...  }

@foo.&racify($batch, $degree).map: { ...  }
```

The same as `hyperize`, but will call the `.race` method (causing unordered results) rather than the `.hyper` method.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/hyperize . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

