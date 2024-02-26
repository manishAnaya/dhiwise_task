import 'package:dhiwise_task/constant/exports.dart';

class GoalCard extends StatelessWidget {
  const GoalCard(
      {super.key,
      required this.goalData,
      required this.index,
      required this.user});
  final User user;
  final RxList<Goal> goalData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => GoalDetails(
            goalDetail: goalData[index],
            user: user,
          )),
      child: Obx(
        () => Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: ((goalData[index].monthlyProjection *
                          (goalData[index].savingsDate.length - 1)) /
                      goalData[index].goalAmount) >=
                  0.99
              ? Colors.green.shade100
              : const Color(0xFFF7F2F9),
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: whiteColor,
                      backgroundImage: AssetImage(appLogo),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(goalData[index].goalName.toUpperCase(),
                                  style: normalColorText),
                              Text('₹${goalData[index].goalAmount.toString()}',
                                  style: normalColorText),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Obx(
                            () => AnimatedLinearIndicator(
                              percentage: ((goalData[index].monthlyProjection *
                                      (goalData[index].savingsDate.length -
                                          1)) /
                                  goalData[index].goalAmount),
                              total: goalData[index]
                                  .goalAmount
                                  .toString()
                                  .split('.')
                                  .first,
                              saved: (goalData[index].monthlyProjection *
                                      (goalData[index].savingsDate.length - 1))
                                  .toString()
                                  .split('.')
                                  .first,
                            ),
                          ),
                          const SizedBox(height: 8),
                          buildRow(
                            label: 'Monthly Saving Projection ',
                            data:
                                '₹${goalData[index].monthlyProjection.toString()}',
                            iconData: Icons.calendar_month,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(),
                buildRow(
                    label: 'Expected Duration to Complete',
                    data:
                        '${(goalData[index].goalAmount / goalData[index].monthlyProjection).toString().split('.').first} months',
                    iconData: Icons.timer),
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    convertDateTimeFormat(goalData[index].dateTime),
                    style: smallLightText,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildRow(
      {required String label,
      required String data,
      required IconData iconData}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(iconData, size: 20, color: primaryColor),
            const SizedBox(width: 4.0),
            Text(label, style: smallColorText),
          ],
        ),
        Text(data, style: smallColorText)
      ],
    );
  }
}
