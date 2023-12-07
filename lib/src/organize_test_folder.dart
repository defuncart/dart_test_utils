import 'dart:io';

import 'package:path/path.dart' as p;

class OrganizeTestFolder {
  static Future<void> execute({
    required bool applyChanges,
    required bool setExitIfChanged,
    bool verbose = true,
  }) async {
    assert(applyChanges != true && setExitIfChanged != true);

    if (verbose) {
      print('Verbose mode is enabled. More information will be logged.\n');
    }

    final testDir = Directory('test');
    var entities = await testDir.list(recursive: true).toList();
    final testFiles = entities.whereType<File>().where((file) => p.basename(file.path).endsWith('_test.dart'));

    final libDir = Directory('lib');
    entities = await libDir.list(recursive: true).toList();
    final libFiles = entities.whereType<File>().where((file) => p.basename(file.path).endsWith('.dart'));

    if (verbose) {
      print('All dart files in lib:');
      libFiles.verbosePrint();
      print('All dart files in test:');
      testFiles.verbosePrint();
      print('');
    }

    for (final testFile in testFiles) {
      final filename = p.basename(testFile.path).replaceAll('_test', '');

      final libFilepaths = libFiles.where((file) => p.basename(file.path) == filename);
      if (libFilepaths.length > 1) {
        print('There are multiple files with the name $filename, skipping.');
        print(libFilepaths);
        continue;
      } else if (libFilepaths.isEmpty) {
        print('There are no files with the name $filename, skipping.');
      } else {
        final libFilepath = libFilepaths.first.path;
        final expectedTestFilepath =
            libFilepath.replaceFirst('lib', 'test').replaceAll(filename, p.basename(testFile.path));

        if (testFile.path != expectedTestFilepath) {
          print('Test for $filename is located at ${testFile.path}, however it should be at $expectedTestFilepath');

          if (applyChanges) {
            print('Moving ${testFile.path} to $expectedTestFilepath');
            await File(expectedTestFilepath).create(recursive: true);
            await File(testFile.path).rename(expectedTestFilepath);
          } else if (setExitIfChanged) {
            exit(1);
          }
        }
      }
    }
  }
}

extension on Iterable<File> {
  void verbosePrint() {
    for (final file in this) {
      print(file.path);
    }
  }
}
