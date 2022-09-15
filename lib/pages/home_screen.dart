import 'package:flutter/material.dart';
import 'package:testing/cubit/test_state.dart';
import 'package:testing/cubit/test_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/models/test.dart';
import 'package:testing/pages/process_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TestCubit testCubit = context.watch<TestCubit>();

    return Scaffold(
      appBar: AppBar(title: Text('Home screen')),
      body: BlocBuilder<TestCubit, TestState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                            Text('Set valid API base URL in order to continue'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: TextField(
                          decoration: InputDecoration(
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Icon(Icons.compare_arrows, size: 20),
                            ),
                          ),
                          controller: _controller,
                        ),
                      ),
                      state is TestLoadingState
                          ? Expanded(
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : state is TestErrorState
                              ? Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    '${state.error}',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'Start counting process',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: state is! TestLoadingState
                        ? () async {
                            var _testList = await testCubit
                                .obtainDataForProcessing(_controller.text);
                            if (_testList != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProcessScreen()),
                              );
                              await testCubit.calculateData(_testList);
                            }
                          }
                        : null,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
