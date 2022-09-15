import 'package:testing/models/test.dart';

abstract class TestState {}

class TestInitState extends TestState {}

class TestLoadingState extends TestState {}

class TestCalculatingState extends TestState {}

class TestLoadedState extends TestState {
  List<Test> tests;

  TestLoadedState({required this.tests});
}

class TestErrorState extends TestState {
  dynamic error;

  TestErrorState({this.error});
}

class TestErrorLoadedState extends TestLoadedState {
  dynamic error;

  TestErrorLoadedState({this.error, tests}) : super(tests: tests);
}
