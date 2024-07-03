import 'package:disk_space_2/disk_space_2.dart';
import 'package:universal_storage_space/src/platform_interface/platform_interface.dart';

/// The Android and iOS implementation of [UniversalStorageSpacePlatformInterface].
/// This class should be used to implement methods that are platform specific.
class UniversalStorageSpaceAndroidIos
    extends UniversalStorageSpacePlatformInterface {
  Future<double?> getTotalSpace() => () async {
        return await DiskSpace.getTotalDiskSpace ?? 0;
      }();

  @override
  Future<double?> getFreeSpace() => () async {
        return await DiskSpace.getFreeDiskSpace ?? 0;
      }();

  @override
  Future<double?> getUsedSpace() => () async {
        final total = await DiskSpace.getTotalDiskSpace ?? 0;
        final free = await DiskSpace.getFreeDiskSpace ?? 0;
        return total - free;
      }();
}
