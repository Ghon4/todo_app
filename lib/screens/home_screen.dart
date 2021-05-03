import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:todo_app/bloc_state_mangment/cubit.dart';
import 'package:todo_app/bloc_state_mangment/states.dart';
import 'package:todo_app/widgets/components.dart';

class HomeScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var titlecontroller = TextEditingController();
  var tasktimecontroller = TextEditingController();
  var taskdatecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () => showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        content: Form(
                          key: formkey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    'Add Task',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10),
                                defaultFormField(
                                  prefixicon: Icons.title,
                                  controller: titlecontroller,
                                  title: 'Title',
                                  validate: (title) {
                                    if (title.isEmpty) {
                                      return 'The title cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                defaultFormField(
                                    controller: tasktimecontroller,
                                    title: 'Task Time',
                                    validate: (String time) {
                                      if (time.isEmpty) {
                                        return 'time cannot be empty';
                                      }
                                      return null;
                                    },
                                    prefixicon: Icons.date_range,
                                    ontapfunction: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then(
                                        (value) => {
                                          tasktimecontroller.text =
                                              value.format(context).toString()
                                        },
                                      );
                                    }),
                                SizedBox(height: 10),
                                defaultFormField(
                                  controller: taskdatecontroller,
                                  title: 'Task Date',
                                  validate: (String date) {
                                    if (date.isEmpty) {
                                      return 'Date cannot be empty';
                                    }
                                    return null;
                                  },
                                  prefixicon: Icons.date_range,
                                  ontapfunction: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2021-07-01'),
                                    ).then((value) {
                                      print(DateFormat.yMMMd().format(value));
                                      taskdatecontroller.text =
                                          DateFormat.yMMMd().format(value);
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black)),
                                    onPressed: () => {
                                      if (formkey.currentState.validate())
                                        {
                                          cubit.insertDatabase(
                                            titlecontroller.text,
                                            taskdatecontroller.text,
                                            tasktimecontroller.text,
                                          ),
                                          Navigator.pop(context),
                                          print('title is $titlecontroller')
                                        }
                                      else
                                        {}
                                    },
                                    child: Text(
                                      'Save',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            body: ConditionalBuilder(
                condition: state is! AppLoadingState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    )),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(0.7),
              onTap: (index) {
                cubit.changeScreens(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archived'),
              ],
            ),
          );
        },
      ),
    );
  }
}
