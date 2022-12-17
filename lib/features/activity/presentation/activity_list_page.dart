import 'package:flutter/material.dart';
import 'package:flutter_web/commons/widgets/error_dialog.dart';
import 'package:flutter_web/features/activity/business/controllers/activity_controller.dart';
import 'package:flutter_web/features/activity/presentation/activity_tile.dart';
import 'package:flutter_web/features/activity/presentation/add_activity_page.dart';
import 'package:flutter_web/features/user/presentation/change_password_page.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({Key? key}) : super(key: key);

  @override
  State<ActivityListPage> createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  ActivityController controller = ActivityController();

  late Size _size;

  double get _padding => _size.shortestSide * 0.2;

  @override
  void initState() {
    super.initState();
    controller.list().catchError((error) {
      ErrorDialog.show(context, error);
    });
    controller.state.activities.addListener(() {
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
        title: const Text('Listagem'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.password),
            onPressed: _onTapChangePassword,
          ),
        ],
      ),
      body: Visibility(
        visible: !controller.state.isLoading.value,
        replacement: const LinearProgressIndicator(),
        child: SingleChildScrollView(
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
                itemCount: controller.state.activities.value.length,
                itemBuilder: (context, index) => ActivityTile(
                  controller.state.activities.value[index],
                  controller,
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapChangePassword() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ChangePasswordPage()),
    );
  }

  void _onPressedCreate() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(builder: (_) => AddActivityPage(controller)),
    )
        .then((_) async {
      await controller.list().catchError((error) {
        ErrorDialog.show(context, error);
      });
    });
  }
}
