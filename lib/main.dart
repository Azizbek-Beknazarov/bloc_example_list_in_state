import 'package:bloc_task_sample/bloc/bloc.dart';
import 'package:bloc_task_sample/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (_) => TodoBloc(),
        child: HomePage(),
      ),
    );
  }
}