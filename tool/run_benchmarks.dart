import 'dart:io';

import 'package:args/args.dart';

enum CompileType { jit, aot }

const assetsFolderPath = '../benchmark/assets';

const benchmarksSources = [
  '$assetsFolderPath/1_kb.json',
  '$assetsFolderPath/1024_kb.json',
  '$assetsFolderPath/48_kb_nesting.json',
];

const dartConvertEncodeEntryPointPath =
    '../benchmark/dart_convert/encode_benchmark.dart';
const dartConvertExecutablePath = '../benchmark/dart_convert/encode_benchmark';

const jardEncodeEntryPointPath = '../benchmark/jard/encode_benchmark.dart';
const jardEncodeExecutablePath = '../benchmark/jard/encode_benchmark';

const iterationsOptionName = 'iterations';
const iterationsOptionAbbr = 'i';

const compileTypeOptionName = 'type';
const compileTypeOptionAbbr = 't';

final parser = ArgParser()
  ..addOption(
    iterationsOptionName,
    abbr: iterationsOptionAbbr,
    defaultsTo: '10',
  )
  ..addOption(
    compileTypeOptionName,
    abbr: compileTypeOptionAbbr,
    defaultsTo: 'jit',
    allowed: CompileType.values.map((e) => e.name),
  );

Future<void> runJITBenchmark({
  required String entryPointPath,
  required String source,
  required int iterations,
}) async {
  print(getSourceName(source));

  final process = await Process.start('dart ', [
    entryPointPath,
    source,
    iterations.toString(),
  ]);

  process.stdout.listen((e) => stdout.add(e));
  process.stderr.listen((e) => stderr.add(e));

  await process.exitCode;
}

Future<void> runAOTBenchmark({
  required String entryPointPath,
  required String executablePath,
  required String source,
  required int iterations,
  required bool compile,
}) async {
  if (compile) {
    await Process.run(
      'dart',
      [
        'compile',
        'exe',
        entryPointPath,
      ],
      runInShell: true,
    );
  }

  print(getSourceName(source));

  final process = await Process.start(
    executablePath,
    [
      source,
      iterations.toString(),
    ],
  );

  process.stdout.listen((e) => stdout.add(e));
  process.stderr.listen((e) => stderr.add(e));

  await process.exitCode;
}

Future<void> runDartConvertEncodeTest({
  required int iterations,
  required CompileType compileType,
}) async {
  for (var i = 0; i < benchmarksSources.length; i++) {
    final source = benchmarksSources[i];

    if (compileType == CompileType.jit) {
      await runJITBenchmark(
        entryPointPath: dartConvertEncodeEntryPointPath,
        source: source,
        iterations: iterations,
      );
    } else {
      await runAOTBenchmark(
        entryPointPath: dartConvertEncodeEntryPointPath,
        executablePath: dartConvertExecutablePath,
        source: source,
        iterations: iterations,
        compile: i == 0,
      );
    }

    if (i < benchmarksSources.length - 1) {
      stdout.writeln();
    }
  }
}

Future<void> runJardEncodeTest({
  required int iterations,
  required CompileType compileType,
}) async {
  for (var i = 0; i < benchmarksSources.length; i++) {
    final source = benchmarksSources[i];

    if (compileType == CompileType.jit) {
      await runJITBenchmark(
        entryPointPath: jardEncodeEntryPointPath,
        source: source,
        iterations: iterations,
      );
    } else {
      await runAOTBenchmark(
        entryPointPath: jardEncodeEntryPointPath,
        executablePath: jardEncodeExecutablePath,
        source: source,
        iterations: iterations,
        compile: i == 0,
      );
    }

    if (i < benchmarksSources.length - 1) {
      stdout.writeln();
    }
  }
}

String getSourceName(String source) {
  final parts = source.split('/');

  return parts[parts.length - 1];
}

void main(List<String> args) async {
  final result = parser.parse(args);

  final iterations = int.parse(result[iterationsOptionName]);
  final compileType = CompileType.values
      .firstWhere((e) => e.name == result[compileTypeOptionName]);

  print('Encode dart:convert benchmark:');
  stdout.writeln();

  await runDartConvertEncodeTest(
    iterations: iterations,
    compileType: compileType,
  );

  stdout.writeln();

  print('Encode jard benchmark:');
  stdout.writeln();

  await runJardEncodeTest(
    iterations: iterations,
    compileType: compileType,
  );
}
