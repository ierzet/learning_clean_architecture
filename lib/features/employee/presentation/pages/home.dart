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
            const EmployeeResult(),
            const SizedBox(height: 10),
            EmployeeIdInput(),
            const SizedBox(height: 20), // Add some spacing
            const Expanded(child: AllEmployeeList()), // Display all employees
          ],
        ),
      ),
    );
  }
}

class AllEmployeeList extends StatelessWidget {
  const AllEmployeeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AllEmployeeBloc>().add(const GetAllEmployee());

    return BlocBuilder<AllEmployeeBloc, AllEmployeeState>(
      builder: (context, state) {
        if (state is AllEmployeeLoading) {
          return const CircularProgressIndicator();
        } else if (state is AllEmployeeLoaded) {
          final allEmployees = state.result;

          return ListView.builder(
            itemCount: allEmployees.length,
            itemBuilder: (context, index) {
              final employee = allEmployees[index];

              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(employee.avatar),
                ),
                title: Text('${employee.firstName} ${employee.lastName}'),
                subtitle: Text('Email: ${employee.email}'),
              );
            },
          );
        } else if (state is AllEmployeeLoadFailure) {
          return Text(state.message);
        } else {
          return const SizedBox();
        }
      },
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
        const Text('Enter Employee ID:'),
        const SizedBox(width: 10),
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
          final employee = state.result;

          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(employee.avatar),
                  radius: 50, // Adjust the radius as needed
                ),
                Text('Employee ID: ${employee.id}'),
                const SizedBox(height: 8),
                Text('Name: ${employee.firstName} ${employee.lastName}'),
                const SizedBox(height: 8),
                Text('Email: ${employee.email}'),
                const SizedBox(height: 8),
              ],
            ),
          );
        } else if (state is EmployeeLoadFailure) {
          return Text(state.message);
        } else {
          return Container(
            padding: const EdgeInsets.all(16),
            child: const Column(
              children: [
                Icon(
                  Icons.person, // Change to the desired Flutter icon
                  size: 100, // Adjust the size of the icon
                ),
                Text('Employee ID:'),
                SizedBox(height: 8),
                Text('Name: '),
                SizedBox(height: 8),
                Text('Email: '),
                SizedBox(height: 8),
              ],
            ),
          );
        }
      },
    );
  }
}
