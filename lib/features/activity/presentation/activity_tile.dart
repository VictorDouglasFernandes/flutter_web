import 'package:flutter/material.dart';
import 'package:flutter_web/features/activity/business/controllers/activity_controller.dart';
import 'package:flutter_web/features/activity/business/entities/activity.dart';
import 'package:flutter_web/features/activity/presentation/activity_detail_page.dart';

class ActivityTile extends StatefulWidget {
  final Activity activity;
  final ActivityController controller;
  const ActivityTile(this.activity, this.controller, {Key? key})
      : super(key: key);

  @override
  State<ActivityTile> createState() => _ActivityTileState();
}

class _ActivityTileState extends State<ActivityTile> {
  Activity get activity => widget.activity;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onPressedTile,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activity.title ?? '- - -'),
                  Text(activity.description ?? '- - -'),
                  Visibility(
                    visible: activity.share != null,
                    child: Text('Compartilhado por: ${activity.share}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedTile() {
    // TODO:
    Navigator.of(context)
        .push(
      MaterialPageRoute(
          builder: (_) => ActivityDetailPage(activity, widget.controller)),
    )
        .then((_) {
      widget.controller.list().whenComplete(() {
        setState(() {});
      });
    });
  }
}
