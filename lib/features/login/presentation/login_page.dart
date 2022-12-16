import 'package:flutter/material.dart';
import 'package:flutter_web/commons/widgets/error_dialog.dart';
import 'package:flutter_web/features/activity/presentation/activity_list_page.dart';
import 'package:flutter_web/features/login/business/controllers/login_controller.dart';
import 'package:flutter_web/features/login/business/entities/user.dart';
import 'package:flutter_web/features/register/presentation/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  late Size _size;

  double get _padding => _size.shortestSide * 0.2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
              OutlinedButton(
                onPressed: _onTapLogin,
                child: const Text(
                  'Logar',
                ),
              ),
              const SizedBox(height: 32.0),
              TextButton(
                onPressed: _sendRegisterPage,
                child: const Text('Se Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapLogin() async {
    if (_formKey.currentState!.validate()) {
      LoginController()
          .login(
        User(
          login: _emailController.text,
          password: _passwordController.text,
        ),
      )
          .then((_) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ActivityListPage()),
        );
      }).catchError((error) {
        ErrorDialog.show(context, error);
      });
    }
  }

  void _sendRegisterPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RegisterPage()),
    );
  }
}
