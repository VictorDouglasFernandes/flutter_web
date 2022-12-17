import 'package:flutter/foundation.dart';
import 'package:flutter_web/features/activity/business/entities/activity.dart';
import 'package:flutter_web/features/activity/data/activity_repository.dart';

class ActivityState {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<List<Activity>> activities = ValueNotifier([]);
}

class ActivityController {
  ActivityState state = ActivityState();

  Future<void> list() async {
    state.isLoading.value = true;
    state.activities.value = await ActivityRepository.list().whenComplete(() {
      state.isLoading.value = false;
    });
  }

  Future<void> post(Activity activity) async {
    state.isLoading.value = true;
    await ActivityRepository.post(activity).whenComplete(() {
      state.isLoading.value = false;
    });
  }

  Future<Activity> put(Activity activity) async {
    state.isLoading.value = true;
    Activity newActivity =
        await ActivityRepository.put(activity).whenComplete(() {
      state.isLoading.value = false;
    });
    return newActivity;
  }

  Future<void> delete(Activity activity) async {
    state.isLoading.value = true;
    await ActivityRepository.delete(activity).whenComplete(() {
      state.isLoading.value = false;
    });
  }
}
