import 'package:flutter/material.dart';

class ActivityDetailPage extends StatefulWidget {
  const ActivityDetailPage({Key? key}) : super(key: key);

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  late Color textColor;

  late Size _size;

  double get _padding => _size.shortestSide * 0.4;

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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(_padding, _padding, _padding, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID',
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 32.0),
            Text(
              'Title',
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 32.0),
            Text(
              'Description',
              style: TextStyle(color: textColor),
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

  void _onTapChange() {
    Navigator.of(context).pushNamed('/change_activity');
  }

  void _onTapDelete() {
    // TODO:
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
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
