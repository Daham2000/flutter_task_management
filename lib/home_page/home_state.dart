import 'package:atlaslabs_test/db/model/task_model.dart';

class HomeState {
  String? error;
  bool isLoading;
  bool isAdded;
  List<Task>? taskList;
  Task? task;
  double? temp;

  HomeState({
    this.error,
    required this.isLoading,
    required this.isAdded,
    this.taskList,
    this.task,
    this.temp,
  });

  HomeState.init()
      : this(
          error: "",
          isLoading: false,
          isAdded: false,
          taskList: [],
          task: null,
          temp: 0,
        );

  HomeState clone({
    String? error,
    bool? isLoading,
    bool? isAdded,
    List<Task>? taskList,
    Task? task,
    double? temp,
  }) {
    return HomeState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isAdded: isAdded ?? this.isAdded,
      taskList: taskList ?? this.taskList,
      task: task ?? this.task,
      temp: temp ?? this.temp,
    );
  }

  static HomeState get initialState => HomeState(
        error: "",
        isLoading: false,
        isAdded: false,
        taskList: [],
        task: null,
        temp: 0,
      );
}
