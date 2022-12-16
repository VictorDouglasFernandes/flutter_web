import 'package:flutter_web/features/activity/business/entities/activity.dart';
import 'package:flutter_web/features/activity/data/activity_repository.dart';

class ActivityState {
  List<Activity> activities = [];
}

class ActivityController {
  ActivityState state = ActivityState();

  Future<void> list() async {
    state.activities = await ActivityRepository.list();
  }

  Future<void> post(Activity activity) async {
    await ActivityRepository.post(activity);
  }

  Future<void> put(Activity activity) async {
    await ActivityRepository.put(activity);
  }

  Future<void> delete(Activity activity) async {
    await ActivityRepository.delete(activity);
  }
}
