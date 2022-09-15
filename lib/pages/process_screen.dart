import 'package:flutter/material.dart';
import 'package:testing/cubit/test_state.dart';
import 'package:testing/cubit/test_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/pages/result_list_screen.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({Key? key}) : super(key: key);

  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  Widget build(BuildContext context) {
    final TestCubit testCubit = context.watch<TestCubit>();

    return Scaffold(
      appBar: AppBar(title: Text('Process screen')),
      body: BlocBuilder<TestCubit, TestState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: state is TestCalculatingState
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: SizedBox(
                              height: 96,
                              width: 96,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          Text('Calculation...'),
                        ],
                      )
                    : state is TestLoadingState
                        ? Center(child: CircularProgressIndicator())
                        : state is TestErrorLoadedState
                            ? Center(
                                child: Text(
                                  '${state.error}',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    'All calculations has finished, you can send your results to server',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  height: 48,
                  width: double.infinity,
                  child: state is! TestCalculatingState
                      ? ElevatedButton(
                          child: Text(
                            'Send results to server',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: state is TestLoadedState
                              ? () async {
                                  var _checked = await testCubit
                                      .sendResultsToServer(state.tests);
                                  if (_checked) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ResultListScreen(state.tests)),
                                    );
                                  }
                                }
                              : null,
                        )
                      : Container(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
