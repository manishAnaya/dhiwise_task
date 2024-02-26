import 'package:dhiwise_task/constant/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final c = Get.put(AuthController());
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      c.loginUser(c.authEmail.value, c.authPass.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.2),
          image: const DecorationImage(
            image: AssetImage(appLogo),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(appLogo, height: 100),
              Text('Establish the habit of\nsaving money',
                  style: mediumColorText),
            ],
          ),
        ),
      ),
    );
  }
}
