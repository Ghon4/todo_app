import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'archived_screen.dart';
import 'done_screen.dart';
import 'new_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List screens = [
    NewTaskScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];
  List titles = [
    'New Tasks',
    'Done',
    'Archived',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    creatDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
        //  onPressed: creatDatabase,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archived'),
        ],
      ),
    );
  }

  Future<void> creatDatabase() async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final stringType = 'TEXT NOT NULL';
    final intType = 'INTEGER NOT NULL';

    var database = await openDatabase('todo.db',
        version: 1,
        onCreate: (database, version) async {
          await database
              .execute(
            'CREATE TABLE tasks (id $idType, title $stringType, date $stringType, time $stringType, status $stringType)',
          )
              .then((value) {
            print('database created');
          }).catchError((error) => print('onError $error'));
        },
        onOpen: (database) => print('DB opened'));
  }
}
