<div align="center">

[![pub package](https://img.shields.io/pub/v/jard.svg?label=jard&color=blue)](https://pub.dev/packages/jard)

**Языки:**
  
[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

- [Применение](#применение)
  - [Кодирование](#кодирование)
  - [Декодирование](#декодирование)
- [Производительность](#производительность)
  - [Производительность кодирования](#производительность-кодирования)

# Применение

Данный пакет используется для кодирования декодирования JSON-а.

В данный момент было реализованно кодирование, более быстрое чем при использовании `jsonEncode` из dart:convert.

## Кодирование

Кодирование доступно при помощи статического метода `encode` класса `Jard`.

Пример использования:

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

Ожидаемый вывод:

```dart
{"name":"Alex","age":22}
```

## Декодирование

В стадии разработки.

# Производительность

## Производительность кодирования

Время исполнения тестов (микросекунды) в JIT:

<img src="https://raw.githubusercontent.com/GlebBatykov/jard/main/doc/images/time-jit.jpg" width="1200px"/>

Время исполнения тестов (микросекунды) в AOT:

<img src="https://raw.githubusercontent.com/GlebBatykov/jard/main/doc/images/time-aot.jpg" width="1200px"/>

Затраты по памяти не отличаются, они на уровне погрешности в 1% в различных тестах в сторону Jard или dart:convert.