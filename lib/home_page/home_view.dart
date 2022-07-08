import 'package:atlaslabs_test/add_task_page/add_task_provider.dart';
import 'package:atlaslabs_test/theme/colors.dart';
import 'package:atlaslabs_test/widgets/task_widget.dart';
import 'package:atlaslabs_test/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/add_task_button.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final TextEditingController searchFieldCtrl = TextEditingController();
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetTaskEvent(""));
    homeBloc.add(GetWeather());
    super.initState();
  }

  TextFormField getSearchTextField() {
    return TextFormField(
      controller: searchFieldCtrl,
      cursorColor: Colors.black,
      onChanged: (e) async {
        homeBloc.add(GetTaskEvent(e.toLowerCase()));
      },
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintStyle: TextStyle(color: Colors.grey[400]),
          hintText: "Search tasks",
          fillColor: Colors.white70),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (pre, current) =>
            pre.error != current.error ||
            pre.temp != current.temp ||
            pre.taskList != current.taskList ||
            pre.isLoading != current.isLoading,
        builder: (ctx, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    child: WeatherWidget(
                        temperature: state.temp?.toStringAsFixed(0) ?? "",
                        city: "Your city temperature"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 12.0),
                    child: getSearchTextField(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Pending tasks",
                    style: GoogleFonts.roboto(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  state.isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Column(
                          children: [
                            for (final t in state.taskList ?? [])
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 12.0),
                                child: TaskWidget(
                                  task: t,
                                  homeBloc: homeBloc,
                                  editButtonOnClick: () {
                                    homeBloc.add(EditTaskEvent(t));
                                    Navigator.push(
                                        ctx,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddTaskHomeProvider(
                                                  isEdit: true,
                                                  task: t,
                                                )));
                                  },
                                  deleteButtonOnClick: () async {
                                    await homeBloc.deleteTask(t);
                                    homeBloc.add(GetTaskEvent(""));
                                  },
                                ),
                              ),
                          ],
                        ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTaskHomeProvider()),
                        );
                      },
                      child: const AddTaskBtn(
                        color: ThemeColors.themeColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
