import 'package:flutter/material.dart';
import 'package:todo_app/bloc_state_mangment/cubit.dart';

class TodoListItem extends StatelessWidget {
  Map model;
  TodoListItem(this.model);

  @override
  Widget build(BuildContext context) {
    // Key:
    // Key(model['id'].toString());
    return Dismissible(
      key: Key(model['id'].toString()),
      child: ListTile(
        leading: CircleAvatar(
          radius: 50,
          child: Text(
            '${model['time']}',
            style: TextStyle(fontSize: 12),
          ),
        ),
        title: Text('${model['title']}'),
        subtitle: Text('${model['date']}'),
        trailing: SingleChildScrollView(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.check_box),
                  onPressed: () {
                    AppCubit.get(context)
                        .updateDBState(status: 'done', id: model['id']);
                  }),
              IconButton(
                  icon: Icon(Icons.archive),
                  onPressed: () {
                    AppCubit.get(context)
                        .updateDBState(status: 'archive', id: model['id']);
                  })
            ],
          ),
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteDBState(id: model['id']);
      },
    );
  }
}
