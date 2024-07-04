import 'dart:developer';

import 'package:universal_disk_space/universal_disk_space.dart';
import 'package:universal_storage_space/src/platform_interface/platform_interface.dart';

/// The Android and iOS implementation of [UniversalStorageSpacePlatformInterface].
/// This class should be used to implement methods that are platform specific.
class UniversalStorageSpaceDesktop
    extends UniversalStorageSpacePlatformInterface {
  final _diskSpace = DiskSpace();

  /// Returns a list of [Disk] objects representing the disks on the system.
  Future<List<Disk>> _getDisks() async {
    await _diskSpace.scan();
    final localDisks = _diskSpace.disks
        .where((d) => !RegExp(r'(//|\\\\)').hasMatch(d.devicePath))
        .toList();
    for (final disk in localDisks) {
      log('Disk: ${disk.mountPath}');
      log('  Used: ${disk.usedSpace}');
      log('  Total: ${disk.totalSize}');
      log('  Path: ${disk.devicePath}');
    }
    return localDisks;
  }

  /// Returns the total storage space in bytes.
  @override
  Future<double> getTotalSpace() => _getDisks().then((disks) {
        if (disks.isEmpty) return 0;
        return disks.fold<double>(
          0,
          (prev, disk) => prev + disk.totalSize,
        );
      });

  /// Returns the free storage space in bytes.
  @override
  Future<double> getFreeSpace() => _getDisks().then((disks) {
        if (disks.isEmpty) return 0;
        return disks.fold<double>(
          0,
          (prev, disk) => prev + disk.availableSpace,
        );
      });

  /// Returns the used storage space in bytes.
  @override
  Future<double> getUsedSpace() async {
    final total = await getTotalSpace();
    final free = await getFreeSpace();
    return total - free;
  }
}
