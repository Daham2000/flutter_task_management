import 'dart:async';

import 'package:atlaslabs_test/db/api/task_api.dart';
import 'package:atlaslabs_test/db/api/weather_api.dart';
import 'package:atlaslabs_test/db/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(BuildContext context) : super(HomeState.initialState);

  Future addTask(Task task) async {
    add(LoadingEvent(true));
    final doc = await TaskApi().addTaskEnd(task);
    add(LoadingEvent(false));
    return doc;
  }

  Future editTask(Task task,String taskName) async {
    add(LoadingEvent(true));
    final doc = await TaskApi().updateTask(task,taskName);
    add(LoadingEvent(false));
    return doc;
  }

  Future deleteTask(Task task) async {
    add(LoadingEvent(true));
    final doc = await TaskApi().deleteTask(task);
    add(LoadingEvent(false));
    return doc;
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType) {
      case LoadingEvent:
        final data = event as LoadingEvent;
        yield state.clone(isLoading: data.isLoading);
        break;

      case GetTaskEvent:
        final data = event as GetTaskEvent;
        yield state.clone(isLoading: true);
        final taskList = await TaskApi().getAllTasks(query: data.query);
        yield state.clone(isLoading: false, taskList: taskList);
        break;

      case EditTaskEvent:
        final data = event as EditTaskEvent;
        yield state.clone(task: data.task);
        break;

      case GetWeather:
        final double temp = await WeatherAPI().getWeather();
        yield state.clone(temp: temp);
        break;
    }
  }
}
