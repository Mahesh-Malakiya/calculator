import 'package:flutter_calculator/data/app_prefrance.dart';
import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    PackageInfo.fromPlatform().then((packageInfo) {
      appVersionStatus.value = VersionStatus(
        appStoreLink: '',
        localVersion: packageInfo.version,
        storeVersion: packageInfo.version,
        releaseNotes: '',
        originalStoreVersion: '',
      );
    });
    checkVersion();
  }

  RxString appVersion = RxString('');

  final newVersionPlus = NewVersionPlus(
      // iOSId: 'com.disney.disneyplus',
      // androidId: 'com.cloud.thingslinker',
      // androidPlayStoreCountry: 'AU',
      // androidHtmlReleaseNotes: true,
      );
  Rxn<VersionStatus> appVersionStatus = Rxn<VersionStatus>();

  final AppPreferences appPreferences = AppPreferences();

  Future<void> checkVersion() async {
    final response = await newVersionPlus.getVersionStatus();
    if (response != null) {
      appVersion.value = response.localVersion;
      appVersionStatus.value = response;
    }
  }
}
