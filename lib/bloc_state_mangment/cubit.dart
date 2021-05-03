import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/bloc_state_mangment/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/screens/archived_screen.dart';
import 'package:todo_app/screens/done_screen.dart';
import 'package:todo_app/screens/new_tasks_screen.dart';
import 'package:todo_app/utils/constants.dart';

class AppCubit extends Cubit<AppStates> {
  Database _database;
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

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

  void changeScreens(int index) {
    currentIndex = index;
    emit(AppChangeNavBottomState());
  }

  Future<void> createDatabase() {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final stringType = 'TEXT NOT NULL';

    openDatabase(
      'todo.db',
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
      onOpen: (database) {
        getDataFromDatabase(database);
        print('DB opened');
      },
    ).then(
      (value) {
        _database = value;
        emit(AppCreateDBState());
      },
    );
  }

  getDataFromDatabase(_database) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];
    emit(AppLoadingState());
    _database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'active')
          newtasks.add(element);
        else if (element['status'] == 'done')
          donetasks.add(element);
        else
          archivetasks.add(element);
        print(element['status']);
      });
      emit(AppOpenAndReadDBState());
    });
  }

  insertDatabase(String title, String date, String time) async {
    await _database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title,date,time,status) VALUES ("$title","$date","$time","active")')
          .then((value) {
        emit(AppInsertDBState());

        getDataFromDatabase(_database);

        print('$value raw inserted');
      }).catchError((onError) {
        print('$onError raw not inserted');
      });
      return null;
    });
  }

  updateDBState({@required String status, @required int id}) {
    _database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(_database);
      emit(AppUpdateDBState());
    });
  }

  deleteDBState({@required int id}) {
    _database
      ..rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
        getDataFromDatabase(_database);
        emit(AppDeleteDBState());
      });
  }
}
