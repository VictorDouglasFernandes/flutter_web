import 'package:flutter/material.dart';
import 'package:flutter_web/commons/widgets/error_dialog.dart';
import 'package:flutter_web/features/login/business/controllers/login_controller.dart';
import 'package:flutter_web/features/login/business/entities/user.dart';
import 'package:flutter_web/features/login/presentation/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
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
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(_padding, _padding, _padding, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: _emailController,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 32.0),
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
                onPressed: _onTapRegister,
                child: const Text(
                  'Cadastrar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapRegister() async {
    if (_formKey.currentState!.validate()) {
      await LoginController()
          .post(
        User(
          login: _emailController.text,
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
