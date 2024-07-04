// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:universal_storage_space/universal_storage_space.dart';

void main() {
  group('UniversalStorageSpace', () {
    test('can be instantiated', () {
      expect(UniversalStorageSpace(path: ''), isNotNull);
    });
  });
}
