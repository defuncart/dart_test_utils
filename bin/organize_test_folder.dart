import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_test_utils/dart_test_utils.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addSeparator('Organizes files in /test to match /lib.')
    ..addFlag('apply', abbr: 'a', defaultsTo: false, help: 'Applies file changes')
    ..addFlag('verbose', abbr: 'v', defaultsTo: true, help: 'Logs verbose output')
    ..addFlag('help', abbr: 'h', negatable: false, defaultsTo: false, help: 'Displays help.');
  final args = parser.parse(arguments);

  if (args['help']) {
    print(parser.usage);
    exit(0);
  } else {
    final applyChanges = args['apply'] ?? false;
    final verbose = args['verbose'] ?? true;

    await OrganizeTestFolder.execute(
      applyChanges: applyChanges,
      verbose: verbose,
    );
  }
}
