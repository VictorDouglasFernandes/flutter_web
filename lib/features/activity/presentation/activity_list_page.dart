import 'package:flutter/material.dart';
import 'package:flutter_web/features/activity/presentation/activity_tile.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({Key? key}) : super(key: key);

  @override
  State<ActivityListPage> createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  late Size _size;

  double get _padding => _size.shortestSide * 0.4;

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(_padding, 32.0, _padding, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: _onPressedCreate,
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
                    Icons.add,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) => const ActivityTile(),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12.0),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedCreate() {
    Navigator.of(context).pushNamed('/add_activity');
  }
}
