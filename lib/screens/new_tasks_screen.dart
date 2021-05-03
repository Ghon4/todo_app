import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_app/bloc_state_mangment/cubit.dart';
import 'package:todo_app/bloc_state_mangment/states.dart';
import '../utils/constants.dart';
import '../widgets/todo_list_items.dart';

class NewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newtasks;
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

//
// StaggeredGridView.countBuilder(
// padding: EdgeInsets.all(8),
// staggeredTileBuilder: (index)=>StaggeredTile.fit(2),
// crossAxisCount: 2,
//
// crossAxisSpacing: 10,
// mainAxisSpacing: 12,
// itemCount: 20,
// itemBuilder: (context, index) {
// return Container(
// decoration: BoxDecoration(
// color: Colors.transparent,
// borderRadius: BorderRadius.all(
// Radius.circular(15))
// ),
// child: ,
// );
// },
// );
