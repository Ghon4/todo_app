import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:bloc/bloc.dart';

import 'bloc_state_mangment/bloc_observe.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Color(0xFFf6f5ee),
      ),
      home: HomeScreen(),
    );
  }
}
