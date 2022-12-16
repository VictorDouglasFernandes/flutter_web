import 'dart:convert';

import 'package:flutter_web/commons/utils/http_utils.dart';
import 'package:flutter_web/features/activity/business/entities/activity.dart';
import 'package:flutter_web/features/login/business/controllers/login_controller.dart';

class ActivityRepository {
  static Future<List<Activity>> list() async {
    var response = await HttpUtils.get(
      'http://node.victor.douglas.fernandes.vms.ufsc.br:3000/activities/${LoginController().state.user?.login}',
    );

    List<dynamic> list = jsonDecode(response.body);

    List<Activity> activities = [];

    list.forEach((item) {
      activities.add(Activity.fromJson(item));
    });

    return activities;
  }

  static Future<Activity> post(Activity activity) async {
    var response = await HttpUtils.post(
      'http://node.victor.douglas.fernandes.vms.ufsc.br:3000/activity',
      jsonEncode(activity.toJson()),
    );

    return Activity.fromJson(jsonDecode(response.body));
  }

  static Future<Activity> put(Activity activity) async {
    var response = await HttpUtils.put(
      'http://node.victor.douglas.fernandes.vms.ufsc.br:3000/activity',
      jsonEncode(activity.toJson()),
    );

    return Activity.fromJson(jsonDecode(response.body));
  }

  static Future<Activity> delete(Activity activity) async {
    var response = await HttpUtils.delete(
      'http://node.victor.douglas.fernandes.vms.ufsc.br:3000/activity',
      jsonEncode(activity.toJson()),
    );

    return Activity.fromJson(jsonDecode(response.body));
  }
}
