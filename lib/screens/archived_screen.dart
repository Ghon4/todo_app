import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_app/bloc_state_mangment/cubit.dart';
import 'package:todo_app/bloc_state_mangment/states.dart';
import '../utils/constants.dart';
import '../widgets/todo_list_items.dart';

class ArchivedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivetasks;
        return ListView.separated(
            itemBuilder: (context, index) {
              return TodoListItem(tasks[index]);
            },
            separatorBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: 0.1,
                color: Colors.grey,
              );
            },
            itemCount: tasks.length);
      },
    );
  }
}
