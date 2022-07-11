import 'package:flutter/material.dart';
import 'package:note/view/groups_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NOTE List',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      home: GroupsScreen(),
    );
  }
}



