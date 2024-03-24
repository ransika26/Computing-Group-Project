import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Initialize the notification plugin
void initializeNotifications() async {
  final initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final initializationSettingsIOS = IOSInitializationSettings();
  final initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// Sending a notification message
Future<void> sendNotification(String category) async {
  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'expense_wise_channel', // Channel ID
    'Expense Wise', // Channel name
    channelDescription: 'Notification Channel for Expense Wise', // Channel description
    importance: Importance.high,
    priority: Priority.high,
    showWhen: false,
    icon: '@mipmap/ic_launcher',
  );

  final iOSPlatformChannelSpecifics = IOSNotificationDetails();
  final platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    'Goal Reached!',
    'You have reached 80% of your goal for the $category category.',
    platformChannelSpecifics,
    payload: 'expense_wise_payload',
  );
}


void checkTransactionsAgainstGoals() async {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final transactionsQuery = FirebaseFirestore.instance.collection('users').doc(userId).collection('transactions');
  final transactionsSnapshot = await transactionsQuery.get();

  final goalsQuery = FirebaseFirestore.instance.collection('users').doc(userId).collection('goals');
  final goalsSnapshot = await goalsQuery.get();

  // Create a map to store the total amount for each category
  Map<String, double> categoryTotalAmounts = {};

  // Iterate, calculate the total amount for each category
  transactionsSnapshot.docs.forEach((transactionDoc) {
    final transactionCategory = transactionDoc['category'];
    final transactionAmount = transactionDoc['amount'];


    final double amount = transactionAmount.toDouble();


    if (categoryTotalAmounts.containsKey(transactionCategory)) {
      // Add the transaction amount to the existing total amount for the category
      categoryTotalAmounts[transactionCategory] = (categoryTotalAmounts[transactionCategory] ?? 0.0) + amount;
    } else {

      categoryTotalAmounts[transactionCategory] = amount;
    }
  });

  // Iterate through each goal to check if the total amount for the category exceeds 80% of the goal amount
  goalsSnapshot.docs.forEach((goalDoc) {
    final goalCategory = goalDoc['category'];
    final goalAmount = goalDoc['amount'];


    final double goal = goalAmount.toDouble();

    final totalAmountForCategory = categoryTotalAmounts[goalCategory] ?? 0.0;


    final goalPercentage = 0.8;
    final goalReachedAmount = goal * goalPercentage;
    if (totalAmountForCategory >= goalReachedAmount) {
      // Send a notification message
      sendNotification(goalCategory);
    }
  });
}
