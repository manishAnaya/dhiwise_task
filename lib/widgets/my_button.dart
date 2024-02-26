import 'package:dhiwise_task/constant/exports.dart';

Widget myButton({
  required void Function() onPressed,
  required String label,
  required Color color,
  required TextStyle style,
}) {
  return SizedBox(
    height: 40,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        maximumSize: const Size(double.infinity, 40),
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: style,
      ),
    ),
  );
}
