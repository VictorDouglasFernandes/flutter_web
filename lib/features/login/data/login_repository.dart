import 'dart:convert';

import 'package:flutter_web/commons/utils/http_utils.dart';
import 'package:flutter_web/features/login/business/entities/user.dart';

class LoginRepository {
  static Future<void> login(User user) async {
    var response = await HttpUtils.post(
      'http://node.victor.douglas.fernandes.vms.ufsc.br:3000/login',
      jsonEncode(user.toJson()),
    );
  }

  static Future<void> post(User user) async {
    var response = await HttpUtils.post(
      'http://node.victor.douglas.fernandes.vms.ufsc.br:3000/user',
      jsonEncode(user.toJson()),
    );
  }

  static Future<void> put(User user) async {
    var response = await HttpUtils.put(
      'http://node.victor.douglas.fernandes.vms.ufsc.br:3000/user',
      jsonEncode(user.toJson()),
    );
  }
}
