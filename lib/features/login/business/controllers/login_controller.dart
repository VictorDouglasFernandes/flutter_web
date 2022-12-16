import 'package:flutter_web/features/login/business/entities/user.dart';
import 'package:flutter_web/features/login/data/login_repository.dart';

class LoginState {
  User? user;
}

class LoginController {
  static final LoginController _singleton = LoginController._internal();

  factory LoginController() {
    return _singleton;
  }

  LoginController._internal();

  LoginState state = LoginState();

  Future<void> login(User user) async {
    await LoginRepository.login(user).then((_) {
      state.user = user;
    });
  }

  Future<void> post(User user) async {
    await LoginRepository.post(user);
  }

  Future<void> put(User user) async {
    await LoginRepository.put(user);
  }
}
