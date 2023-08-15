import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:learning_clean_architecture/features/employee/presentation/pages/home.dart';
import 'package:learning_clean_architecture/injection_container.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<EmployeeBloc>(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee App',
        home: Home(),
      ),
    );
  }
}
