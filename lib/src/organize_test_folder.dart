import 'dart:io';

import 'package:path/path.dart' as p;

class OrganizeTestFolder {
  static Future<void> execute({
    required bool applyChanges,
    bool verbose = true,
  }) async {
    if (verbose) {
      print('Verbose mode is enabled. More information will be logged.');
    }

    final testDir = Directory('test');
    var entities = await testDir.list(recursive: true).toList();
    final testFiles = entities.whereType<File>().where((file) => p.basename(file.path).endsWith('_test.dart'));

    final libDir = Directory('lib');
    entities = await libDir.list(recursive: true).toList();
    final libFiles = entities.whereType<File>().where((file) => p.basename(file.path).endsWith('.dart'));

    if (verbose) {
      print('All dart files in lib:');
      print(libFiles);
      print('All dart files in test:');
      print(testFiles);
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
          }
        }
      }
    }
  }
}
