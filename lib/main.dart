import 'package:flutter/material.dart';
import 'package:testing/cubit/test_cubit.dart';
import 'package:testing/pages/home_screen.dart';
import 'package:testing/services/test_api_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TestCubit>(
      create: (context) => TestCubit(TestProvider()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
