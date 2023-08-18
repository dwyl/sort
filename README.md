<div align="center">

# `sort`

![Elixir Build Status](https://img.shields.io/github/actions/workflow/status/dwyl/sort/elixir.yml?label=Elixir&style=flat-square)
![Dart Build Status](https://img.shields.io/github/actions/workflow/status/dwyl/sort/dart.yml?label=Dart&style=flat-square)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/sort/main.svg?style=flat-square)](http://codecov.io/github/dwyl/sort?branch=main)
[![Hex.pm](https://img.shields.io/hexpm/v/sort?color=brightgreen&style=flat-square)](https://hex.pm/packages/sort)
[![pub package](https://img.shields.io/pub/v/srt.svg?color=brightgreen&style=flat-square)](https://pub.dev/packages/srt)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/sort#contributing)
[![HitCount](http://hits.dwyl.com/dwyl/sort.svg)](http://hits.dwyl.com/dwyl/sort)

</div>

# Why?

We needed a way to manage the `sort` (order) 
in our `App` both on the `server` (`Elixir`) and `mobile` (`Flutter`) client.
So we wrote this mini package that works in both languages.

# What?

[`sort.json`](https://github.com/dwyl/sort/blob/main/lib/sort.json)
is a maintainable list of sort objects/maps
that anyone can read 
to be informed of **`sort`**
used in our App(s).
It makes it easier for us to keep them
in one place 
and means 
anyone can contribute.

# Who?

This package is for us by us.
We don't expect anyone else to use it.
It's 
[Open Source](https://github.com/dwyl/intellectual-property)
so that
anyone using our Apps can view 
and contribute to the list.

# How?

## Elixir

### Installation

Add `sort` 
to your dependencies 
in `mix.exs`:

```elixir
def deps do
  [
    {:sort, "~> 1.0.0"},
  ]
end
```

### Usage

```elixir
sort = Sort.get_list()
# use them how you see fit
```

Documentation available at: 
[hexdocs.pm/sort](https://hexdocs.pm/sort)



## Dart - Comming Soon!

### Installation

You can run the following command
to install the dependency.

```sh
flutter pub add srt
```

Alternatively,
add `srt` 
to your dependencies 
in `pubspec.yml`:

```dart
dependencies:
  srt: ^1.0.0
```

### Usage

```dart
final sortArray = Srt.list()
# use them how you see fit
```

Documentation available at: 
[pub.dev/packages/sort](https://pub.dev/packages/sort)
