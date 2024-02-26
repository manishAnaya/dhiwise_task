import 'package:dhiwise_task/constant/exports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.userData});

  final User userData;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/images/app_logo.png'),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome,',
                        style: mediumColorText,
                      ),
                      SizedBox(
                        width: 175,
                        child: Text(
                          'Mr. ${userData.name}',
                          style: smallLightText,
                        ),
                      ),
                      SizedBox(
                        width: 175,
                        child: Text(
                          userData.email,
                          style: smallLightText,
                        ),
                      ),
                      SizedBox(
                        width: 175,
                        child: Text(
                          userData.phone,
                          style: smallLightText,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
