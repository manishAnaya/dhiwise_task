import 'dart:io';
import 'package:dhiwise_task/constant/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyCiWeu2PrXFoFrW6TlaDB8cF-QTRq5NtKc',
            appId: '1:341510303493:android:340c0fce4436d9cd51116c',
            messagingSenderId: '341510303493',
            projectId: 'dhiwise-task-db',
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: myTheme(),
      home: autoLoginSystem(),
    );
  }

  FutureBuilder<bool> autoLoginSystem() {
    return FutureBuilder(
      future: SharedPrefs.autoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.data == true) {
            return const SplashScreen();
          } else {
            return const Welcome();
          }
        }
      },
    );
  }
}
