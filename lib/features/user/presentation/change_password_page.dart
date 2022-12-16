import 'package:flutter/material.dart';
import 'package:flutter_web/commons/widgets/error_dialog.dart';
import 'package:flutter_web/features/login/business/controllers/login_controller.dart';
import 'package:flutter_web/features/login/business/entities/user.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();

  late Size _size;

  double get _padding => _size.shortestSide * 0.2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar Senha'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(_padding, _padding, _padding, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
                controller: _passwordController,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 32.0),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirme a Senha',
                ),
                controller: _passwordConfirmationController,
                validator: (value) {
                  if ((value?.isEmpty ?? true) ||
                      value != _passwordController.text) {
                    return 'Senha diferente';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 32.0),
              OutlinedButton(
                onPressed: _onTapChangePassword,
                child: const Text(
                  'Alterar Senha',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapChangePassword() {
    if (_formKey.currentState!.validate()) {
      LoginController()
          .put(
        User(
          login: LoginController().state.user?.login,
          password: _passwordController.text,
        ),
      )
          .then((_) {
        Navigator.pop(context);
      }).catchError((error) {
        ErrorDialog.show(context, error);
      });
    }
  }
}
