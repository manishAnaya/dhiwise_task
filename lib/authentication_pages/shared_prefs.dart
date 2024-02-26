import 'package:dhiwise_task/constant/exports.dart';

class SharedPrefs {
  static final c = Get.put(AuthController());

  static Future<void> loginSave(String email, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', email);
    preferences.setString('pass', pass);
  }

  static Future<bool> autoLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('email')) {
      String email = preferences.getString('email')!;
      String pass = preferences.getString('pass')!;
      c.authEmail.value = email;
      c.authPass.value = pass;
      return true;
    }
    return false;
  }

  static Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Get.offAll(() => SignIn(), transition: Transition.leftToRightWithFade);
  }
}
