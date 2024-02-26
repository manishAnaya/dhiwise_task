import 'package:dhiwise_task/constant/exports.dart';

class GoalController extends GetxController {
  RxList<Goal> allGoals = <Goal>[].obs;
  RxList<SavingsDate> allDates = <SavingsDate>[].obs;
  RxBool isLoading = false.obs;
  RxBool isSaveLoading = false.obs;

  Future setUserGoal(String userId, Map<String, dynamic> goalData) async {
    await FirebaseFirestore.instance
        .collection('userGoals')
        .doc(userId)
        .set(goalData);
  }

  Future<void> addGoal(String userId, Goal goal) async {
    try {
      isLoading.value = true;
      // Reference to the user's document
      DocumentReference<Map<String, dynamic>> userDocRef =
          FirebaseFirestore.instance.collection('userGoals').doc(userId);

      // Get the current data
      DocumentSnapshot<Map<String, dynamic>> userData = await userDocRef.get();

      // Check if the user document exists
      if (userData.exists) {
        // If it exists, update the 'goals' field with the new goal data
        List<Map<String, dynamic>> currentGoals =
            List.from(userData.data()!['goals'] ?? []);

        // Find the index of the goal to update
        int goalIndex = currentGoals.indexWhere(
            (existingGoal) => existingGoal['goalName'] == goal.goalName);

        if (goalIndex != -1) {
          // If the goal exists, update the 'savingsDate' field
          List<String> currentSavingsDate =
              List.from(currentGoals[goalIndex]['savingsDate'] ?? []);
          currentSavingsDate.addAll(goal.savingsDate);

          // Update the 'savingsDate' for the specific goal
          currentGoals[goalIndex]['savingsDate'] = currentSavingsDate;
        } else {
          // If the goal doesn't exist, add it to the 'goals' list
          currentGoals.add({
            'goalId': goal.goalId,
            'goalName': goal.goalName,
            'goalAmount': goal.goalAmount,
            'dateTime': goal.dateTime,
            'savingsDate': goal.savingsDate,
            'monthlyProjection': goal.monthlyProjection,
          });
        }
        // Update the document with the new 'goals' list
        await userDocRef.update({'goals': currentGoals});
        allGoals.add(Goal(
            goalId: goal.goalId,
            goalName: goal.goalName,
            goalAmount: goal.goalAmount,
            dateTime: goal.dateTime,
            savingsDate: goal.savingsDate,
            monthlyProjection: goal.monthlyProjection));
      } else {
        // If the user document doesn't exist, create a new document with the 'goals' field
        await userDocRef.set({
          'goals': [
            {
              'goalId': goal.goalId,
              'goalName': goal.goalName,
              'goalAmount': goal.goalAmount,
              'dateTime': goal.dateTime,
              'savingsDate': goal.savingsDate,
              'monthlyProjection': goal.monthlyProjection,
            }
          ],
        });
        allGoals.add(Goal(
            goalId: goal.goalId,
            goalName: goal.goalName,
            goalAmount: goal.goalAmount,
            dateTime: goal.dateTime,
            savingsDate: goal.savingsDate,
            monthlyProjection: goal.monthlyProjection));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Goal>> fetchUserGoal(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('userGoals')
          .doc(userId)
          .get();

      if (userData.exists) {
        // If the user document exists, retrieve the 'goals' field
        List<dynamic> goalsData = userData.data()!['goals'] ?? [];

        // Convert the list of dynamic to a list of Goal objects
        List<Goal> userGoals = goalsData.map((goal) {
          return Goal(
            goalId: goal['goalId'],
            goalName: goal['goalName'],
            goalAmount: goal['goalAmount'],
            monthlyProjection: goal['monthlyProjection'],
            dateTime: goal['dateTime'],
            savingsDate: List<String>.from(goal['savingsDate']),
          );
        }).toList();
        allGoals.value = userGoals;
        return userGoals;
      } else {
        return <Goal>[];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return <Goal>[];
    }
  }

  Future<void> addSavingsDate(
      String userId, String uniqueGoalId, String newSavingsDate) async {
    try {
      isSaveLoading.value = true;
      isLoading.value = true;
      DocumentReference<Map<String, dynamic>> userDocRef =
          FirebaseFirestore.instance.collection('userGoals').doc(userId);

      DocumentSnapshot<Map<String, dynamic>> userData = await userDocRef.get();

      if (userData.exists) {
        List<Map<String, dynamic>> currentGoals =
            List.from(userData.data()!['goals'] ?? []);

        int goalIndex = currentGoals.indexWhere(
            (existingGoal) => existingGoal['goalId'] == uniqueGoalId);

        if (goalIndex != -1) {
          // If the goal exists, update its savingsDate
          List<String> currentSavingsDate =
              List.from(currentGoals[goalIndex]['savingsDate'] ?? []);
          currentSavingsDate.add(newSavingsDate);

          // Update the 'savingsDate' for the specific goal
          currentGoals[goalIndex]['savingsDate'] = currentSavingsDate;

          // Update the document with the new 'goals' list
          await userDocRef.update({'goals': currentGoals});
          Goal? goalToUpdate =
              allGoals.firstWhere((goal) => goal.goalId == uniqueGoalId);
          goalToUpdate.savingsDate.add(newSavingsDate);
        } else {
          Fluttertoast.showToast(msg: 'Goal with ID $uniqueGoalId not found.');
        }
      } else {
        Fluttertoast.showToast(msg: 'User document not found.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isSaveLoading.value = false;
      isLoading.value = false;
    }
  }
}

class Goal {
  String goalId;
  String goalName;
  double goalAmount;
  double monthlyProjection;
  String dateTime;
  List<String> savingsDate;
  Goal(
      {required this.goalId,
      required this.goalName,
      required this.goalAmount,
      required this.dateTime,
      required this.savingsDate,
      required this.monthlyProjection});

  void addDate(String date) {
    savingsDate.add(date);
  }
}

class SavingsDate {
  String date;
  SavingsDate({required this.date});
}
