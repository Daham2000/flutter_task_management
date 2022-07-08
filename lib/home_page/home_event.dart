import 'package:atlaslabs_test/db/model/task_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeEvent {}

class EditTaskEvent extends HomeEvent {
  final Task task;

  EditTaskEvent(this.task);
}

class DeleteTaskEvent extends HomeEvent {
  final Task task;

  DeleteTaskEvent(this.task);
}

class GetTaskEvent extends HomeEvent {
  final String query;

  GetTaskEvent(this.query);
}

class LoadingEvent extends HomeEvent {
  final bool isLoading;

  LoadingEvent(this.isLoading);
}

class GetWeather extends HomeEvent {
}
