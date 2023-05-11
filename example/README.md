<div align="center">

**Языки:**
  
[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

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
