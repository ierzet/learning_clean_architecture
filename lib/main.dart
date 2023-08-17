import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:learning_clean_architecture/features/employee/presentation/pages/home.dart';
import 'package:learning_clean_architecture/injection_container.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
  //getWordsData();

  //runApp(MyApp2());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<EmployeeBloc>()),
        BlocProvider(create: (context) => di.sl<AllEmployeeBloc>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee App',
        home: Home(),
      ),
    );
  }
}


// Your code looks great! You've implemented the BLoC pattern for both 
//individual employee data and all employee data. The UI components are 
//interacting with the BLoCs to display the data and handle user interactions.

// A few things to consider for further improvements:

// TODO: Debouncing: You've already defined the debounce function and are using it as
// a transformer for your events. This is good for preventing unnecessary API 
//calls in quick succession. Just make sure that it's working as expected and 
//providing the desired behavior.

// Context Read vs. Watch: In your UI components, you're using context.read to 
//dispatch events to your BLoCs. This is fine for your current use case, but as 
//your app grows, you might need to consider using context.watch for scenarios 
//where you need to rebuild your UI in response to changes in the state without
// needing to trigger new events.

// Error Handling: You've already handled the EmployeeLoadFailure and 
//AllEmployeeLoadFailure states in your UI components. This is good for 
//displaying error messages to users. Additionally, you could consider adding 
//more detailed error handling and logging at different levels in your app to 
//help diagnose issues during development and user feedback.

// Optimization: Your code is functional and follows best practices for the 
//BLoC pattern. However, as your app evolves, you might want to consider 
//optimizations such as code splitting, lazy loading, and memoization to 
//improve performance and maintainability.

// Overall, you've done a great job implementing the BLoC pattern in your app. 
//It's well-structured and follows the best practices. If you have any more 
//questions or need further assistance, feel free to ask!