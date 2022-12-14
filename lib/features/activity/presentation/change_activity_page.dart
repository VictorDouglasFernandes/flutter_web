import 'package:flutter/material.dart';
import 'package:flutter_web/commons/widgets/error_dialog.dart';
import 'package:flutter_web/features/activity/business/controllers/activity_controller.dart';
import 'package:flutter_web/features/activity/business/entities/activity.dart';

class ChangeActivityPage extends StatefulWidget {
  final Activity activity;
  final ActivityController controller;
  const ChangeActivityPage(this.activity, this.controller, {Key? key})
      : super(key: key);

  @override
  State<ChangeActivityPage> createState() => _ChangeActivityPageState();
}

class _ChangeActivityPageState extends State<ChangeActivityPage> {
  Activity get activity => widget.activity;

  late TextEditingController _titleController;

  late TextEditingController _descriptionController;

  late Size _size;

  double get _padding => _size.shortestSide * 0.2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: activity.title);
    _descriptionController = TextEditingController(text: activity.description);
    widget.controller.state.isLoading.addListener(() {
      setState(() {});
    });
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
        title: const Text('Alterar'),
        centerTitle: true,
      ),
      body: Visibility(
        visible: !widget.controller.state.isLoading.value,
        replacement: const LinearProgressIndicator(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(_padding, _padding, _padding, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'T??tulo',
                  ),
                  controller: _titleController,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Obrigat??rio' : null,
                ),
                const SizedBox(height: 32.0),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descri????o',
                  ),
                  controller: _descriptionController,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Obrigat??rio' : null,
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
      ),
    );
  }

  void _onTapSave() async {
    if (_formKey.currentState!.validate()) {
      await widget.controller
          .put(
        Activity(
          id: activity.id,
          title: _titleController.text,
          description: _descriptionController.text,
          user: activity.user,
          share: activity.share,
        ),
      )
          .then((newActivity) {
        Navigator.of(context).pop(newActivity);
      }).catchError((error) {
        ErrorDialog.show(context, error);
      });
    }
  }
}
