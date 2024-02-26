import 'package:dhiwise_task/constant/exports.dart';

class MyController extends GetxController {
  //location services
  RxString city = ''.obs;
  RxString location = ''.obs;
  RxBool isLocationLoading = false.obs;

  //custom textfield
  Rx<DateTime> startDate = DateTime(1999).obs;
}
