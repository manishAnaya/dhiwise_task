import 'package:dhiwise_task/constant/exports.dart';

class AnimatedLinearIndicator extends StatelessWidget {
  final double percentage;
  final String total;
  final String saved;
  const AnimatedLinearIndicator(
      {super.key,
      required this.percentage,
      required this.total,
      required this.saved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: percentage),
        duration: defaultDuration,
        builder: (context, value, child) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${(value * 100).toInt().toString()}% Goal Achieved',
                    style: normalColorText),
                Text('₹$saved/₹$total', style: smallColorText)
              ],
            ),
            const SizedBox(height: 8.0),
            LinearProgressIndicator(
              value: value,
              color: percentage >= 0.99 ? Colors.green.shade500 : primaryColor,
              backgroundColor: bgColor,
            ),
          ],
        ),
      ),
    );
  }
}
