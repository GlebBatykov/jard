<div align="center">

[![pub package](https://img.shields.io/pub/v/jard.svg?label=jard&color=blue)](https://pub.dev/packages/jard)

**Languages:**
  
[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

- [Using](#using)
  - [Encode](#encode)
  - [Decode](#decode)
- [Performance](#performance)
  - [Encode perfomance](#encode-perfomance)

# Using

This package is used for encoding and decoding JSON.

At the moment, encoding has been implemented, faster than using `jsonEncode` from dart:convert.

## Encode

Encoding is available using the static `encode` method of the `Jard` class.

Usage example:

```dart
import 'package:jard/jard.dart';

void main() {
  final map = <String, dynamic>{
    'name': 'Alex',
    'age': 22,
  };

  final json = Jard.encode(map);

  print(json);
}
```

Expected output:

```dart
{"name":"Alex","age":22}
```

## Decode

Under development.

# Performance

## Encode perfomance

Execution time (microseconds) benchmark in JIT:

<img src="https://raw.githubusercontent.com/GlebBatykov/jard/main/doc/images/time-jit.jpg" width="1200px"/>

Execution time (microseconds) benchmark in AOT:

<img src="https://raw.githubusercontent.com/GlebBatykov/jard/main/doc/images/time-aot.jpg" width="1200px"/>

Memory costs do not differ, they are at the level of 1% error in various tests in the direction of Jard or dart:convert.
