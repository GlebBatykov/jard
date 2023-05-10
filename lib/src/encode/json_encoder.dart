part of jard;

class JsonEncoder {
  StringBuffer? _buffer;

  String encode(Object? object) {
    if (object is bool) {
      if (object) {
        return 'true';
      } else {
        return 'false';
      }
    } else if (object is num) {
      return object.toString();
    }

    _buffer = StringBuffer();

    _encodeObject(object);

    final json = _buffer.toString();
    _buffer = null;

    return json;
  }

  void _encodeObject(Object? object, [bool separator = false]) {
    if (object == null) {
      _encodeNull(separator);
    } else if (object is String) {
      _encodeString(object, separator);
    } else if (object is num) {
      _encodeNum(object, separator);
    } else if (object is bool) {
      _encodeBoolean(object, separator);
    } else if (object is List) {
      _encodeList(object, separator);
    } else if (object is Map) {
      _encodeMap(object, separator);
    } else {
      throw UnimplementedError();
    }
  }

  void _encodeNull([bool separator = false]) {
    if (separator) {
      _buffer!.write('null,');
    } else {
      _buffer!.write('null');
    }
  }

  void _encodeString(String object, [bool separator = false]) {
    _buffer!.write('"');

    _buffer!.write(object);
    if (separator) {
      _buffer!.write('",');
    } else {
      _buffer!.write('"');
    }
  }

  void _encodeNum(num object, [bool separator = false]) {
    _buffer!.write(object.toString());
    if (separator) _buffer!.write(',');
  }

  void _encodeBoolean(bool object, [bool separator = false]) {
    if (object) {
      if (separator) {
        _buffer!.write('true,');
      } else {
        _buffer!.write('true');
      }
    } else {
      if (separator) {
        _buffer!.write('false,');
      } else {
        _buffer!.write('false');
      }
    }
  }

  void _encodeList(List<Object?> list, [bool separator = false]) {
    if (list.isEmpty) {
      if (separator) {
        _buffer!.write('[],');
      } else {
        _buffer!.write('[]');
      }
      return;
    }

    _buffer!.write('[');

    for (var i = 0; i < list.length; i++) {
      _encodeObject(list[i], i < list.length - 1);
    }

    if (separator) {
      _buffer!.write('],');
    } else {
      _buffer!.write(']');
    }
  }

  void _encodeMap(Map<Object?, Object?> map, [bool separator = false]) {
    if (map.isEmpty) {
      if (separator) {
        _buffer!.write('{},');
      } else {
        _buffer!.write('{}');
      }
      return;
    }

    final keyValueList = List<Object?>.filled(map.length * 2, null);
    var i = 0;

    map.forEach((key, value) {
      if (key is! String) {
        throw UnimplementedError();
      }

      keyValueList[i++] = key;
      keyValueList[i++] = value;
    });

    _buffer!.write('{');

    for (var i = 0; i < keyValueList.length; i += 2) {
      _buffer!.write('"');
      _buffer!.write(keyValueList[i]);
      _buffer!.write('":');

      _encodeObject(keyValueList[i + 1], i < keyValueList.length - 2);
    }

    if (separator) {
      _buffer!.write('},');
    } else {
      _buffer!.write('}');
    }
  }
}
