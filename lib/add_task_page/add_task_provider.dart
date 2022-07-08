import 'package:atlaslabs_test/db/model/task_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_page/home_bloc.dart';
import 'add_task_view.dart';

class AddTaskHomeProvider extends BlocProvider<HomeBloc> {
  AddTaskHomeProvider({Key? key, bool isEdit = false, Task? task})
      : super(
          key: key,
          create: (context) => HomeBloc(context),
          child: AddTaskView(
            isEdit: isEdit,
            task: task,
          ),
        );
}
