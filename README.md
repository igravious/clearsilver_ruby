
The way Clearsilver works is that you create a `Neo::Hdf` object and
instantiate a `Neo::Cs` object with it.

Like so:

```ruby
h = Neo::Hdf
# some stuff
c = Neo::Cs h
```

then you need to call:

```ruby
c.parse_str str
c.render
```

Two things to note are that there is no point in passing in other `Hdf` objects
as only the first gets used. Also `parse_str` remembers the strings so you need
to have a new `Cs` object every time. You would imagine that you could call
parse_str with `str2` or `str3` but that is not the case, that will not work.
The most you can do is modify `h` in between calls to render. It appears that in
the same way that `Hdf` object are shared behind the scenes, so are `str` objects.
This means that you can only have one template per ... per what?

My alternate API I have created gives you the option of the following:

```ruby
h1 = Neo.Hdf
h2 = Neo.Hdf

c = Neo::Cs
c.use h1
c.parse_str str
c.render
c.use h2
c.parse_str str
c.render
```

This is because new `Cs`and `Hdf` objects are created internally which is less
but more how you'd expect it to work.
