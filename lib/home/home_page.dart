import 'package:dhiwise_task/constant/exports.dart';
import 'package:dhiwise_task/home/components/goal_card.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final c = Get.put(AuthController());
  final goalC = Get.put(GoalController());
  final goalNameController = TextEditingController();
  final goalAmountController = TextEditingController();
  final monthlyProController = TextEditingController();
  final goalKey = GlobalKey<FormState>();

  String generateGoalId() {
    const uuid = Uuid();
    return uuid.v4();
  }

  @override
  void initState() {
    goalC.fetchUserGoal(widget.user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userData = widget.user;
    final goalData = goalC.allGoals;
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD', style: largeText),
        actions: [
          IconButton(
            onPressed: () => logoutfn(),
            icon: const Icon(Icons.logout, size: 20),
          )
        ],
      ),
      drawer: MyDrawer(userData: userData),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
          () => goalData.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'You have not started saving yet... Please click on + button to get started',
                      style: mediumColorText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : goalC.isLoading.value
                  ? loading
                  : ListView.builder(
                      itemCount: goalData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => GoalCard(
                        goalData: goalData,
                        index: index,
                        user: userData,
                      ),
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialogToAddGoals(),
        child: const Icon(Icons.add),
      ),
    );
  }

  showDialogToAddGoals() {
    goalAmountController.clear();
    goalNameController.clear();
    monthlyProController.clear();
    Get.defaultDialog(
      titlePadding: const EdgeInsets.symmetric(vertical: 18),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18),
      title: 'Create Your New Goal',
      titleStyle: mediumColorText,
      content: Form(
        key: goalKey,
        child: Column(
          children: [
            CustomTextField(
              controller: goalNameController,
              hintText: 'Goal Name',
              iconData: Icons.flag,
            ),
            CustomTextField(
              controller: goalAmountController,
              hintText: 'Goal Amount',
              iconData: Icons.payment,
              isNumeric: true,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              controller: monthlyProController,
              hintText: 'Your monthly projection of savings',
              iconData: Icons.savings,
              isNumeric: true,
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                final isValid = goalKey.currentState!.validate();
                if (isValid) {
                  goalC.addGoal(
                    widget.user.uid,
                    Goal(
                      goalName: goalNameController.text,
                      goalAmount: double.parse(goalAmountController.text),
                      monthlyProjection:
                          double.parse(monthlyProController.text),
                      dateTime: DateTime.now().toString(),
                      savingsDate: [DateTime.now().toString()],
                      goalId: generateGoalId(),
                    ),
                  );
                  Get.back();
                }
              },
              child: Text('Submit', style: normalWhiteText),
            ),
          ],
        ),
      ),
    );
  }
}
