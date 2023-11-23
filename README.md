# dart_test_utils

A dart tool contain test utils.

## Installation

The tool can be installed via `dart pub global` by activate the package on your local machine:

```sh
dart pub global activate --source git https://github.com/defuncart/dart_test_utils
```

Similarly, the tool can be uninstalled via `dart pub global deactivate dart_test_utils`. Alternatively, the tool can be a depenended upon in a dart project:

```yaml
dev_dependencies:
    dart_test_utils:
        git: https://github.com/defuncart/dart_test_utils
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

if the tool is a dev dependency. For a full overview, see `dart run dart_test_utils:organize_test_folder -h`.
