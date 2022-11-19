import 'package:flutter_web/features/activity/presentation/activity_detail_page.dart';
import 'package:flutter_web/features/activity/presentation/activity_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/features/activity/presentation/add_activity_page.dart';
import 'package:flutter_web/features/activity/presentation/change_activity_page.dart';
import 'package:flutter_web/features/login/presentation/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/activity_list', //'/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/activity_list': (context) => const ActivityListPage(),
        '/activity_detail': (context) => const ActivityDetailPage(),
        '/add_activity': (context) => const AddActivityPage(),
        '/change_activity': (context) => const ChangeActivityPage(),
      },
    );
  }
}
