# KeyTuples

[![Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)
[![Build Status](https://travis-ci.org/tpapp/KeyTuples.jl.svg?branch=master)](https://travis-ci.org/tpapp/KeyTuples.jl)
[![Coverage Status](https://coveralls.io/repos/tpapp/KeyTuples.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/tpapp/KeyTuples.jl?branch=master)
[![codecov.io](http://codecov.io/github/tpapp/KeyTuples.jl/coverage.svg?branch=master)](http://codecov.io/github/tpapp/KeyTuples.jl?branch=master)

This library defines an associative type which is like a `Tuple`, except that you can also assess the elements using the keys (which need to be `Symbol`s) given when the object was created.

Usage:
```julia
k = KeyTuples(:a => 1, :b => 2)
```

A similar, and more mature library is [NamedTuples.jl](https://github.com/blackrock/NamedTuples.jl/blob/master/src/NamedTuples.jl).
