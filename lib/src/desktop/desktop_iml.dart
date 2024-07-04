import 'dart:developer';
import 'dart:io';

import 'package:universal_disk_space/universal_disk_space.dart';
import 'package:universal_storage_space/src/platform_interface/platform_interface.dart';

/// The Android and iOS implementation of [UniversalStorageSpacePlatformInterface].
/// This class should be used to implement methods that are platform specific.
class UniversalStorageSpaceDesktop
    extends UniversalStorageSpacePlatformInterface {
  /// The path to the directory for which the storage space should be calculated.
  UniversalStorageSpaceDesktop({required this.path}) : super(path: path);

  final DiskSpace _diskSpace = DiskSpace();
  final String path;

  /// Returns a list of [Disk] objects representing the disks on the system.
  Future<List<Disk>> _getDisks() async {
    await _diskSpace.scan();
    try {
      final disk = _diskSpace.getDisk(Directory(path));
      return [disk];
    } catch (e) {
      log('Error: $e');
    }
    // Filter out network drives
    return _diskSpace.disks
        .where((d) => !RegExp(r'(//|\\\\)').hasMatch(d.devicePath))
        .toList();
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
