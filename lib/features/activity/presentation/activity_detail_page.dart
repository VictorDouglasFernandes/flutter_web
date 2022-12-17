import 'package:flutter/material.dart';
import 'package:flutter_web/commons/widgets/error_dialog.dart';
import 'package:flutter_web/features/activity/business/controllers/activity_controller.dart';
import 'package:flutter_web/features/activity/business/entities/activity.dart';
import 'package:flutter_web/features/activity/presentation/change_activity_page.dart';

class ActivityDetailPage extends StatefulWidget {
  final Activity activity;
  final ActivityController controller;
  const ActivityDetailPage(this.activity, this.controller, {Key? key})
      : super(key: key);

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  Activity get activity => widget.activity;

  late Color textColor;

  late Size _size;

  double get _padding => _size.shortestSide * 0.2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _shareController = TextEditingController();

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;

    textColor = Theme.of(context).primaryColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _onTapShare,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(_padding, _padding, _padding, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.title ?? '- - -',
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 32.0),
            Text(
              activity.description ?? '- - -',
              style: TextStyle(color: textColor),
            ),
            Visibility(
              visible: activity.share != null,
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Text(
                  'Compartilhado por: ${activity.share}',
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            TextButton(
              onPressed: _onTapChange,
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
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            TextButton(
              onPressed: _onTapDelete,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Excluir',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapShare() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Compartilhar'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
            controller: _shareController,
            validator: (value) => value?.isEmpty ?? true ? 'Obrigatório' : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.controller.post(
                  Activity(
                    title: activity.title,
                    description: activity.description,
                    user: _shareController.text,
                    share: activity.user,
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Compartilhar'),
          )
        ],
      ),
    );
  }

  void _onTapChange() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (_) => ChangeActivityPage(activity, widget.controller),
      ),
    )
        .then((newActivity) {
      if (newActivity != null) {
        setState(() {
          activity
            ..title = newActivity.title
            ..description = newActivity.description
            ..share = newActivity.share;
        });
      }
    });
  }

  void _onTapDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir'),
        content: const Text('Tem certeza que deseja excluir ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await widget.controller.delete(widget.activity).then((_) {
                Navigator.pop(context);
                Navigator.pop(context);
              }).catchError((error) {
                ErrorDialog.show(context, error);
              });
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
