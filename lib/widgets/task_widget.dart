import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';

import '../db/model/task_model.dart';
import '../home_page/home_bloc.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final HomeBloc homeBloc;
  final VoidCallback editButtonOnClick;
  final VoidCallback deleteButtonOnClick;

  const TaskWidget({
    Key? key,
    required this.task,
    required this.homeBloc,
    required this.editButtonOnClick,
    required this.deleteButtonOnClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            task.taskName,
                            style: GoogleFonts.roboto(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0, bottom: 2.0),
                        child: Container(
                          width: 150,
                          child: Text(
                            task.taskDueDate,
                            style: GoogleFonts.roboto(
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 2.0),
                    child: Container(
                      width: 200,
                      height: 50,
                      child: Text(
                        task.taskDes,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.roboto(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      editButtonOnClick();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.edit),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      deleteButtonOnClick();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.delete),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await FlutterShare.share(
                          title: task.taskName,
                          text: task.taskDes,
                          linkUrl: 'https://flutter.dev/',
                          chooserTitle: task.taskDes);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.share),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
