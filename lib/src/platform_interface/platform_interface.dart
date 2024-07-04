/// The interface that all platform implementations of the universal_storage_space
/// must implement.
abstract class UniversalStorageSpacePlatformInterface {
  /// The path to the directory for which the storage space should be calculated.
  UniversalStorageSpacePlatformInterface({required String path});

  /// Returns the total storage space in bytes.
  Future<double> getTotalSpace();

  /// Returns the free storage space in bytes.
  Future<double> getFreeSpace();

  /// Returns the used storage space in bytes.
  Future<double> getUsedSpace();
}
