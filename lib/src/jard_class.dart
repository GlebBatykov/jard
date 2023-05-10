part of jard;

abstract class Jard {
  static final _encoder = JsonEncoder();

  static String encode(Object? object) {
    return _encoder.encode(object);
  }
}
