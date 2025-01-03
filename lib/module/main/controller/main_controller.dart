import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt selectedIndex = RxInt(0);
  RxInt editIndexedData = RxInt(0);

  void changeIndex(int index) {
    selectedIndex.value = index;
    update();
  }
}
