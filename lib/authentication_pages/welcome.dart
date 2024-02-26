import 'package:dhiwise_task/constant/exports.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SizedBox(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 160),
            SizedBox(
              height: 300,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset('assets/images/app_logo.png',
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),
            Text("Discover your\nShopping Here",
                textAlign: TextAlign.center, style: xLargeBoldColorText),
            const SizedBox(height: 80),
            Text(
                "It is a long established fact that a reader\nwill be distracted by the readable\ncontent of a page.",
                textAlign: TextAlign.center,
                style: normalLightText),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor),
                      onPressed: () => Get.to(
                        () => SignUp(),
                        transition: Transition.leftToRight,
                      ),
                      child: Text(
                        "Register",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: mediumWhiteText,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: bgColor),
                      onPressed: () => Get.to(
                        () => SignIn(),
                        transition: Transition.rightToLeft,
                      ),
                      child: Text(
                        "Login",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: mediumLightText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
