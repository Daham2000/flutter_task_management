import 'package:atlaslabs_test/db/model/task_model.dart';
import 'package:atlaslabs_test/home_page/home_bloc.dart';
import 'package:atlaslabs_test/home_page/home_provider.dart';
import 'package:atlaslabs_test/home_page/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../widgets/snackbar_factory.dart';

class AddTaskView extends StatefulWidget {
  final bool isEdit;
  final Task? task;

  const AddTaskView({Key? key, required this.isEdit, required this.task})
      : super(key: key);

  @override
  AddTaskViewState createState() => AddTaskViewState();
}

class AddTaskViewState extends State<AddTaskView> {
  final TextEditingController taskNameCtrl = TextEditingController();
  final TextEditingController taskDesCtrl = TextEditingController();
  DateTime dateDue = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  String dateDueStr = "";

  TextFormField getSearchTextField(
      TextEditingController ctrl, String hintText) {
    return TextFormField(
      controller: ctrl,
      cursorColor: Colors.black,
      onChanged: (e) async {},
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintStyle: TextStyle(color: Colors.grey[400]),
          hintText: hintText,
          fillColor: Colors.white70),
    );
  }

  @override
  void initState() {
    if (widget.isEdit) {
      if (widget.task != null) {
        taskNameCtrl.text = widget.task!.taskName;
        taskDesCtrl.text = widget.task!.taskDes;
        Future.delayed(Duration.zero, () async {
          setState(() {
            dateDueStr = widget.task!.taskDueDate;
          });
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (pre, current) =>
            pre.error != current.error ||
            pre.task != current.task ||
            pre.taskList != current.taskList ||
            pre.isLoading != current.isLoading ||
            pre.isAdded != current.isAdded,
        builder: (ctx, state) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  getSearchTextField(taskNameCtrl, "Task name"),
                  const SizedBox(
                    height: 10,
                  ),
                  getSearchTextField(taskDesCtrl, "Task Description"),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Due Date: ",
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2000, 1, 1),
                              maxTime: DateTime(2030, 1, 1),
                              onChanged: (date) {}, onConfirm: (date) {
                            setState(() {
                              dateDue = date;
                              dateDueStr = dateFormat.format(dateDue);
                            });
                            print('Date Due: $date');
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: Container(
                          width: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            child: Text(
                              dateDueStr,
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  state.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            Task task = Task(
                                taskName: taskNameCtrl.text,
                                taskDes: taskDesCtrl.text,
                                taskDueDate: dateDueStr);
                            String result;
                            if (widget.isEdit) {
                              result = await homeBloc
                                  .editTask(task, widget.task!.taskName)
                                  .toString();
                            } else {
                              result = await homeBloc.addTask(task).toString();
                            }
                            if (result != null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBarFactory().getSnackBar(
                                isFail: false,
                                title: widget.isEdit
                                    ? "Task updated"
                                    : "Task added.",
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor,
                              ));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeProvider()),
                              );
                            }
                          },
                          child: Text(
                            widget.isEdit ? "Update Task" : "Save Task",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                            ),
                          ))
                ],
              ),
            ),
          ));
        });
  }
}
