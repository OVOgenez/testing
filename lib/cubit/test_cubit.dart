import 'package:testing/models/test.dart';
import 'package:testing/cubit/test_state.dart';
import 'package:testing/services/test_api_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestCubit extends Cubit<TestState> {
  final TestProvider testProvider;

  TestCubit(this.testProvider) : super(TestInitState());

  Future<List<Test>?> obtainDataForProcessing(link) async {
    try {
      emit(TestLoadingState());
      final List<Test> _testList = await testProvider.getData(link);
      emit(TestInitState());
      return _testList;
    } catch (e) {
      emit(TestErrorState(error: e));
      return null;
    }
  }

  Future<void> calculateData(tests) async {
    try {
      emit(TestCalculatingState());
      tests.forEach((e) => e.calculatePath());
      await Future.delayed(Duration(milliseconds: 1000));
      emit(TestLoadedState(tests: tests));
    } catch (e) {
      emit(TestErrorState(error: e));
    }
  }

  Future<bool> sendResultsToServer(tests) async {
    try {
      emit(TestLoadingState());
      await testProvider.postData(tests);
      emit(TestLoadedState(tests: tests));
      return true;
    } catch (e) {
      emit(TestErrorLoadedState(tests: tests, error: e));
      return false;
    }
  }
}
