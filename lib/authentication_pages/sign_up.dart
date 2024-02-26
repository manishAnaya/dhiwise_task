import 'package:dhiwise_task/constant/exports.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passController = TextEditingController();
  final signInkey = GlobalKey<FormState>();
  final c = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding * 2),
          child: Form(
            key: signInkey,
            child: Column(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child:
                        Image.asset('assets/images/app_logo.png', height: 185),
                  ),
                ),
                Text(
                  "Create an Account",
                  style: xLargeColorText,
                ),
                const SizedBox(height: defaultPadding * 3),
                CustomTextField(
                    controller: nameController,
                    hintText: 'Your Name',
                    iconData: Icons.account_circle),
                CustomTextField(
                    controller: emailController,
                    hintText: 'Your Email',
                    isEmail: true,
                    iconData: Icons.email),
                CustomTextField(
                    controller: mobileController,
                    hintText: 'Enter Mobile Number',
                    isPhone: true,
                    keyboardType: TextInputType.phone,
                    iconData: Icons.phone_android),
                CustomTextField(
                    controller: passController,
                    hintText: 'Enter Password',
                    isPassword: true,
                    iconData: Icons.lock),
                const SizedBox(height: defaultPadding * 2),
                signupButton(),
                // const SizedBox(height: defaultPadding),
                // signupwithGoogle(),
                const SizedBox(height: defaultPadding),
                alreadyHaveAc(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signupButton() {
    return Obx(
      () => c.isLoading.value
          ? loading
          : myButton(
              label: 'Register',
              color: primaryColor,
              style: mediumWhiteText,
              onPressed: () {
                final isValid = signInkey.currentState!.validate();
                if (isValid) {
                  c.registerUser(
                    name: nameController.text,
                    email: emailController.text,
                    password: passController.text,
                    mobileNo: mobileController.text,
                  );
                }
              },
            ),
    );
  }

  RichText alreadyHaveAc() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Already have an account ?  ",
            style: normalLightText,
          ),
          TextSpan(
            text: "Login",
            style: const TextStyle(
              fontSize: 16,
              color: primaryColor,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.to(() => SignIn()),
          ),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }
}
