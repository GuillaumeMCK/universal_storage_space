import 'package:disk_space_2/disk_space_2.dart';
import 'package:universal_storage_space/src/platform_interface/platform_interface.dart';

/// The Android and iOS implementation of [UniversalStorageSpacePlatformInterface].
/// This class should be used to implement methods that are platform specific.
class UniversalStorageSpaceAndroidIos
    extends UniversalStorageSpacePlatformInterface {
  /// The path to the directory for which the storage space should be calculated.
  UniversalStorageSpaceAndroidIos({required super.path});

  @override
  Future<double> getTotalSpace() =>
      DiskSpace.getTotalDiskSpace.then((value) => value ?? 0);

  @override
  Future<double> getFreeSpace() =>
      DiskSpace.getFreeDiskSpace.then((value) => value ?? 0);

  @override
  Future<double> getUsedSpace() async {
    final total = await getTotalSpace();
    final free = await getFreeSpace();
    return total - free;
  }
}
