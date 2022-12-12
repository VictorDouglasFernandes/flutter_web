import 'package:flutter/material.dart';
import 'package:flutter_web/features/activity/presentation/activity_detail_page.dart';

class ActivityTile extends StatefulWidget {
  const ActivityTile({Key? key}) : super(key: key);

  @override
  State<ActivityTile> createState() => _ActivityTileState();
}

class _ActivityTileState extends State<ActivityTile> {
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
                children: const [
                  Text('Title'),
                  Text('Description'),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            IconButton(
              splashRadius: 16.0,
              onPressed: _onPressedIcon,
              icon: const Icon(Icons.circle_outlined),
            )
          ],
        ),
      ),
    );
  }

  void _onPressedTile() {
    // TODO:
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ActivityDetailPage()),
    );
  }

  void _onPressedIcon() {
    // TODO:
  }
}
