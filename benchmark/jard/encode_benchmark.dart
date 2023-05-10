import 'dart:convert';
import 'dart:io';

import 'package:jard/jard.dart';

Future<Object?> _getObject(String source) async {
  final file = File.fromUri(Uri.file(source));

  final json = await file.readAsString();

  return jsonDecode(json);
}

void main(List<String> args) async {
  final source = args[0];
  final iterations = int.parse(args[1]);

  final object = await _getObject(source);

  final stopwatch = Stopwatch()..start();

  final startMemory = ProcessInfo.currentRss;

  for (var i = 0; i < iterations; i++) {
    Jard.encode(object);
  }

  stopwatch.stop();

  final memory = ProcessInfo.currentRss - startMemory;

  print('Time (mc): ${stopwatch.elapsedMicroseconds}');
  print('Memory (bytes): $memory');
}
