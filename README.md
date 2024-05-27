# dart_test_utils

A dart tool containing test utils.

## Installation

The tool can be installed by activating the package on your local machine: `dart pub global activate dart_test_utils`. Similarly, the tool can be uninstalled via `dart pub global deactivate dart_test_utils`. Alternatively, the tool can be a depended upon in a dart/flutter project:

```yaml
dev_dependencies:
    dart_test_utils:
```

## Organize Test Folder

This tools re-organizes the file structure of `/test` to match `lib`.

For instance, if the file structure was

```
lib/
├─ features/
│  ├─ feature_1/
│  │  ├─ feature_1_repository.dart
test/
├─ feature_1_repository_test.dart
```

then

`test/feature_1_repository_test.dart` would be moved into `test/features/feature_1/feature_1_repository_test.dart`.

### Usage

```sh
dart pub global run dart_test_utils:organize_test_folder --apply
```

or

```sh
dart run dart_test_utils:organize_test_folder --apply
```

if the tool is a dev dependency. 

The option `--set-exit-if-changed` can be used in a CI pipeline to fail when there are file changes. For a full overview, see `dart run dart_test_utils:organize_test_folder -h`.

### Expected Behavior

- When a file should be moved, if a file exists at the target location, then the existing file will be overwritten.
- If a moved file contains relative paths (i.e. `import '../mocks.dart'`), then the path will need manual resolution.
