import 'package:platform/platform.dart';
import 'package:universal_storage_space/src/android_ios/android_ios_impl.dart';
import 'package:universal_storage_space/src/desktop/desktop_iml.dart';
import 'package:universal_storage_space/src/platform_interface/platform_interface.dart';

class UniversalStorageSpace implements UniversalStorageSpacePlatformInterface {
  UniversalStorageSpace() {
    if (_platform.isAndroid || _platform.isIOS) {
      _platformInterface = UniversalStorageSpaceAndroidIos();
    } else if (_platform.isWindows || _platform.isLinux || _platform.isMacOS) {
      _platformInterface = UniversalStorageSpaceDesktop();
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  final Platform _platform = const LocalPlatform();
  late final UniversalStorageSpacePlatformInterface _platformInterface;

  @override
  Future<double> getFreeSpace() {
    return _platformInterface.getFreeSpace();
  }

  @override
  Future<double> getTotalSpace() {
    return _platformInterface.getTotalSpace();
  }

  @override
  Future<double> getUsedSpace() {
    return _platformInterface.getUsedSpace();
  }
}
