import '../api_service.dart';
import 'notification_service.dart';

class RandomMealNotification {
  static bool _started = false;

  static Future<void> start({required int seconds}) async {
    if (_started) return;
    _started = true;

    final apiService = ApiService();

    Future<void> send() async {
      final meal = await apiService.loadRandomMealDetails();
      if (meal != null) {
        await NotificationService.instance.showNotification(
          title: 'Random Meal of the day',
          body: meal.name,
          payload: meal.id.toString(),
        );
      }
    }

    await send();

    Stream.periodic(Duration(seconds: seconds)).listen((_) {
      send();
    });
  }
}
