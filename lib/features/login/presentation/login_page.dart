import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  late Size _size;

  double get _padding => _size.shortestSide * 0.4;

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
            ],
          ),
        ),
      ),
    );
  }

  void _onTapLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        //
      } catch (e) {
        //
      }
    }
  }
}
