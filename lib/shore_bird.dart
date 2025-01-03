// class ShoreBirdCode extends GetxController {
//   var isCheckingForUpdate = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     appPrint('ShoreBirdCode onInit called:::::');
//     Get.put(SplashController());
//     checkForUpdate();
//     ShorebirdCodePush().currentPatchNumber().then((v) {
//       if (v != null) {
//         log('Current patch version: $v');
//       }
//     });
//   }

//   Future<void> checkForUpdate() async {
//     isCheckingForUpdate.value = true;
//     final isUpdateAvailable =
//         await ShorebirdCodePush().isNewPatchAvailableForDownload();
//     isCheckingForUpdate.value = false;

//     if (isUpdateAvailable) {
//       log('Update available: $isUpdateAvailable');
//       await _downloadUpdate();
//     }
//   }

//   void showDownloadingBanner() {
//     Get.snackbar(
//       'Update available',
//       'Downloading...',
//       backgroundColor: AppColors.primary,
//       animationDuration: const Duration(seconds: 2),
//       duration: const Duration(seconds: 4),
//       isDismissible: false,
//       colorText: Colors.white,
//       snackPosition: SnackPosition.TOP,
//     );
//   }

//   void showRestartBanner() {
//     Get.snackbar(
//       'Patch ready',
//       'A new patch is ready!',
//       backgroundColor: AppColors.primary,
//       animationDuration: const Duration(seconds: 2),
//       duration: const Duration(minutes: 5),
//       isDismissible: false,
//       colorText: Colors.white,
//       snackPosition: SnackPosition.TOP,
//       mainButton: const TextButton(
//         onPressed: Restart.restartApp,
//         child: Text('Restart App', style: TextStyle(color: Colors.white)),
//       ),
//     );
//   }

//   Future<void> _downloadUpdate() async {
//     showDownloadingBanner();

//     try {
//       await ShorebirdCodePush().downloadUpdateIfAvailable();
//       showRestartBanner();
//     } catch (e) {
//       log('Error downloading update: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to download update',
//         backgroundColor: Colors.red,
//         animationDuration: const Duration(seconds: 2),
//         duration: const Duration(seconds: 5),
//         isDismissible: true,
//         colorText: Colors.white,
//         snackPosition: SnackPosition.TOP,
//       );
//     }
//   }
// }
