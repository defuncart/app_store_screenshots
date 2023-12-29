fvm flutter test --coverage --dart-define IS_CI_TEST=true

genhtml coverage/lcov.info --output=coverage
