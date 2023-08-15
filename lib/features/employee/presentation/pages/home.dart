import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_event.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final employeeBloc = BlocProvider.of<EmployeeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter Employee ID:'),
            const SizedBox(height: 10),
            EmployeeIdInput(),
            const SizedBox(height: 10),
            const EmployeeResult(),
          ],
        ),
      ),
    );
  }
}

class EmployeeIdInput extends StatelessWidget {
  final _controller = TextEditingController();

  EmployeeIdInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
          width: 100,
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            final id = int.tryParse(_controller.text);
            if (id != null) {
              context.read<EmployeeBloc>().add(OnIdChanged(id));
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class EmployeeResult extends StatelessWidget {
  const EmployeeResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        if (state is EmployeeLoading) {
          return const CircularProgressIndicator();
        } else if (state is EmployeeLoaded) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Employee ID: ${state.result.id}'),
                const SizedBox(height: 8),
                Text(
                    'Name: ${state.result.firstName} ${state.result.lastName}'),
                const SizedBox(height: 8),
                Text('Email: ${state.result.email}'),
                Text('avatar: ${state.result.avatar}'),
                Image.network(
                  state.result.avatar,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          );
        } else if (state is EmployeeLoadFailure) {
          return Text(state.message);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
