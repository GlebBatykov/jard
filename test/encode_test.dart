import 'package:jard/jard.dart';
import 'package:test/test.dart';

import 'test_data/boolean.dart';
import 'test_data/collections.dart';
import 'test_data/null.dart';
import 'test_data/numbers.dart';
import 'test_data/strings.dart';

void main() {
  group('Single values', () {
    group('boolean', () {
      test('false', () {
        final result = Jard.encode(testBooleanFalse);

        expect(result, testBooleanFalseJson);
      });

      test('true', () {
        final result = Jard.encode(testBooleanTrue);

        expect(result, testBooleanTrueJson);
      });
    });

    test('null', () {
      final result = Jard.encode(testNull);

      expect(result, testNullJson);
    });

    test('double', () {
      final result = Jard.encode(testDouble);

      expect(result, testDoubleJson);
    });

    test('integer', () {
      final result = Jard.encode(testInt);

      expect(result, testIntJson);
    });

    test('String', () {
      final result = Jard.encode(testString);

      expect(result, testStringJson);
    });
  });

  group('Collections', () {
    test('List', () {
      final result = Jard.encode(testList);

      expect(result, testListJson);
    });

    test('Map', () {
      final result = Jard.encode(testMap);

      expect(result, testMapJson);
    });

    test('List with lists', () {
      final result = Jard.encode(testListWithLists);

      expect(result, testListWithListsJson);
    });

    test('List with maps', () {
      final result = Jard.encode(testListWithMaps);

      expect(result, testListWithMapsJson);
    });

    test('Map with lists', () {
      final result = Jard.encode(testMapWithLists);

      expect(result, testMapWithListsJson);
    });

    test('Map with maps', () {
      final result = Jard.encode(testMapWithMaps);

      expect(result, testMapWithMapsJson);
    });
  });
}
