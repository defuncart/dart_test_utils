import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_test_utils/dart_test_utils.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addSeparator('Organizes files in /test to match /lib.')
    ..addFlag('help', abbr: 'h', negatable: false, defaultsTo: false, help: 'Displays help.')
    ..addFlag('verbose', abbr: 'v', defaultsTo: false, negatable: false, help: 'Logs verbose output')
    ..addSeparator('')
    ..addFlag('apply', defaultsTo: false, negatable: false, help: 'Applies file changes')
    ..addFlag(
      'set-exit-if-changed',
      defaultsTo: false,
      negatable: false,
      help: 'Return exit code 1 if there are any file changes',
    );
  try {
    final args = parser.parse(arguments);

    if (args['help']) {
      print(parser.usage);
      exit(0);
    } else {
      final verbose = args['verbose'] ?? false;
      final applyChanges = args['apply'] ?? false;
      final setExitIfChanged = args['set-exit-if-changed'] ?? false;

      if (applyChanges && setExitIfChanged) {
        print('Error! Both --apply and --set-exit-if-changed given, please choose one');
        exit(0);
      }

      await OrganizeTestFolder.execute(
        applyChanges: applyChanges,
        verbose: verbose,
        setExitIfChanged: setExitIfChanged,
      );
    }
  } on FormatException catch (e) {
    print(e.message);
    exit(0);
  }
}
