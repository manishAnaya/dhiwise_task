import 'package:dhiwise_task/constant/exports.dart';
import 'package:dhiwise_task/home/components/animated_circular_indicator.dart';

class GoalDetails extends StatelessWidget {
  final User user;
  final Goal goalDetail;
  const GoalDetails({super.key, required this.goalDetail, required this.user});

  @override
  Widget build(BuildContext context) {
    final gc = Get.put(GoalController());
    String amountSaved =
        (goalDetail.monthlyProjection * (goalDetail.savingsDate.length - 1))
            .toString();
    String remainingAmt = goalDetail.goalAmount - double.parse(amountSaved) >= 0
        ? (goalDetail.goalAmount - double.parse(amountSaved)).toString()
        : '0';

    return Scaffold(
      appBar: AppBar(
        title: Text(goalDetail.goalName.toUpperCase(), style: largeText),
      ),
      body: Obx(
        () => gc.isLoading.value
            ? loading
            : SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: defaultPadding * 2),
                      AnimatedCircularIndicator(
                        label: goalDetail.goalName,
                        percentage: ((goalDetail.monthlyProjection *
                                (goalDetail.savingsDate.length - 1)) /
                            goalDetail.goalAmount),
                      ),
                      const SizedBox(height: defaultPadding),
                      Card(
                        margin: const EdgeInsets.all(defaultPadding),
                        child: Container(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            children: [
                              Text('Total Saved Amount'.toUpperCase(),
                                  style: normalLightText),
                              Text(
                                  '₹${(goalDetail.monthlyProjection * (goalDetail.savingsDate.length - 1)).toString()}',
                                  style: largeColorText),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Remaining'.toUpperCase(),
                                          style: normalLightText),
                                      Text(
                                          '₹${goalDetail.goalAmount - double.parse(amountSaved) >= 0 ? (goalDetail.goalAmount - (goalDetail.monthlyProjection * (goalDetail.savingsDate.length - 1))).toString() : '0'}',
                                          style: normalColorText)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('Goal'.toUpperCase(),
                                          style: normalLightText),
                                      Text(
                                        '₹${goalDetail.goalAmount.toString()}',
                                        style: normalColorText,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: defaultPadding),
                              Text('Monthly Saving Projection'.toUpperCase(),
                                  style: normalLightText),
                              Text(
                                  '₹${goalDetail.monthlyProjection.toString()}',
                                  style: normalColorText)
                            ],
                          ),
                        ),
                      ),
                      ((goalDetail.monthlyProjection *
                                      (goalDetail.savingsDate.length - 1)) /
                                  goalDetail.goalAmount) >=
                              0.99
                          ? Text(
                              'Congratulations!!! You have saved for your ${goalDetail.goalName}',
                              style: largeGreenText,
                              textAlign: TextAlign.center,
                            )
                          : ElevatedButton(
                              onPressed: () => gc.addSavingsDate(
                                user.uid,
                                goalDetail.goalId,
                                DateTime.now().toString(),
                              ),
                              child: Text(
                                '+ Add Saving',
                                style: normalWhiteText,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => gc.isSaveLoading.value
                              ? loading
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('  Saving History', style: mediumText),
                                    ListView.builder(
                                      itemCount:
                                          goalDetail.savingsDate.length - 1,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => Card(
                                        child: Container(
                                          padding: const EdgeInsets.all(
                                              defaultPadding),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Monthly Saving Projection Amount',
                                                      style: normalColorText),
                                                  Text(
                                                    convertDateTimeFormat(
                                                        goalDetail.savingsDate[
                                                            index + 1]),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                  goalDetail.monthlyProjection
                                                      .toString(),
                                                  style: normalColorText),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
