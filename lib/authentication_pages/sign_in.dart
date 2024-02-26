import 'package:dhiwise_task/constant/exports.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final loginKey = GlobalKey<FormState>();
  final c = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child:
                        Image.asset('assets/images/app_logo.png', height: 185)),
              ),
              Text(
                "Welcome Back",
                style: xLargeColorText,
              ),
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 36),
                child: Text(
                  "Good to see you again,",
                  textAlign: TextAlign.center,
                  style: normalLightText,
                ),
              ),
              CustomTextField(
                controller: emailController,
                hintText: 'Your Email',
                iconData: Icons.email,
                isEmail: true,
              ),
              CustomTextField(
                controller: passController,
                hintText: 'Enter Password',
                iconData: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: defaultPadding),
              forgetPass(),
              const SizedBox(height: defaultPadding * 2),
              loginButton(),
              const SizedBox(height: defaultPadding * 2),
              loginwithGoogleFb(),
              const SizedBox(height: defaultPadding * 2),
              donthaveAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Row forgetPass() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => Get.to(() {}),
          child: Text(
            "Forgot Password ?",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: normalColorText,
          ),
        ),
      ],
    );
  }

  Widget loginButton() {
    return Obx(
      () => c.isLoading.value
          ? loading
          : myButton(
              label: 'Login',
              color: primaryColor,
              style: mediumWhiteText,
              onPressed: () {
                final isValid = loginKey.currentState!.validate();
                if (isValid) {
                  c.loginUser(emailController.text, passController.text);
                }
              },
            ),
    );
  }

  Column loginwithGoogleFb() {
    return Column(
      children: [
        Text('------------  or continue with  ------------',
            style: normalBoldText),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: bgColor),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.google,
                    color: Color(0xFFEA4335),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    " Google ",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: normalLightText,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: bgColor),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.facebook,
                    color: Color(0xFF316FF6),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Facebook",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: normalLightText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  RichText donthaveAccount() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account yet?  ",
            style: normalLightText,
          ),
          TextSpan(
            text: "Sign Up",
            style: const TextStyle(
              color: primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.to(() => SignUp()),
          )
        ],
      ),
      textAlign: TextAlign.left,
    );
  }
}
