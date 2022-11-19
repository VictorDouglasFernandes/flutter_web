import 'package:flutter/material.dart';

class ChangeActivityPage extends StatefulWidget {
  const ChangeActivityPage({Key? key}) : super(key: key);

  @override
  State<ChangeActivityPage> createState() => _ChangeActivityPageState();
}

class _ChangeActivityPageState extends State<ChangeActivityPage> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  late Size _size;

  double get _padding => _size.shortestSide * 0.4;

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
        title: const Text('Alterar'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(_padding, _padding, _padding, 0.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Título',
                ),
                controller: _titleController,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 32.0),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descrição',
                ),
                controller: _descriptionController,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 32.0),
              TextButton(
                onPressed: _onTapSave,
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Salvar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapSave() {
    if (_formKey.currentState!.validate()) {
      try {
        //
      } catch (e) {
        //
      }
    }
  }
}
