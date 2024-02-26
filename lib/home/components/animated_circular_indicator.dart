import 'package:dhiwise_task/constant/exports.dart';

class AnimatedCircularIndicator extends StatelessWidget {
  final String label;
  final double percentage;
  const AnimatedCircularIndicator(
      {super.key, required this.label, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: percentage),
              duration: defaultDuration,
              builder: (context, value, child) => Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 15,
                    color: percentage >= 0.99
                        ? Colors.green.shade500
                        : primaryColor,
                    backgroundColor: bgColor,
                    value: value,
                  ),
                  const CircleAvatar(
                    backgroundColor: whiteColor,
                    backgroundImage: AssetImage(appLogo),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${(value * 100).toInt().toString()}%\nSaved',
                        style: normalText,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8)
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
