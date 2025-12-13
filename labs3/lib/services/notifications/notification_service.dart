import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../main.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          final mealId = int.parse(response.payload!);
          navigatorKey.currentState?.pushNamed(
            "/meals/details",
            arguments: {'title': 'Random Meal of the day', 'mealId': mealId},
          );
        }
      },
    );
  }

  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await _notifications.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'random_meal_channel',
          'Random Meal Notifications',
          channelDescription: 'Random meal reminder',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: payload,
    );
  }

}