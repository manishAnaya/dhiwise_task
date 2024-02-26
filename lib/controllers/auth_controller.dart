import 'package:dhiwise_task/constant/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  RxString authEmail = ''.obs;
  RxString authPass = ''.obs;
  RxBool isLoading = false.obs;

  Future<void> registerUser(
      {required String name,
      required String email,
      required String password,
      required String mobileNo}) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String userId = userCredential.user?.uid ?? '';
      saveUserToDB(userId, {
        'name': name,
        'email': email,
        'phone': mobileNo,
        'password': password,
      });
      SharedPrefs.loginSave(email, password);
      Fluttertoast.showToast(msg: 'Registration successful');
      User user = User(uid: userId, name: name, email: email, phone: mobileNo);
      Get.offAll(() => HomePage(user: user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Weak password entered');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Account Already exists');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future saveUserToDB(String userId, Map<String, dynamic> userInfo) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .set(userInfo);
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(msg: 'Logged in');
      String userId = userCredential.user?.uid ?? '';
      // Retrieve user data from Firestore
      Map<String, dynamic> userData = await fetchUserData(userId);
      User user = User(
        uid: userId,
        name: userData['name'] ?? '',
        email: userData['email'] ?? '',
        phone: userData['phone'] ?? '',
      );
      SharedPrefs.loginSave(email, password);
      Get.offAll(() => HomePage(user: user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No Account exists with this email-id');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Incorrect password');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('User').doc(userId).get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        return userData;
      } else {
        return {};
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error getting user data: $e');
      return {};
    }
  }
}

class User {
  final String uid;
  final String name;
  final String email;
  final String phone;

  User(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phone});
}
