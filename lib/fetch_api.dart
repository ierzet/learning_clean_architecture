import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_clean_architecture/core/constansts/constants.dart';
import 'package:learning_clean_architecture/core/error/exception.dart';
import 'package:learning_clean_architecture/features/employee/data/models/employee_model.dart';

Future<List<EmployeeModel>> getWordsData() async {
  final client = http.Client();
  final response = await client.get(Uri.parse(Urls.currentAllEmployee()));

  if (response.statusCode == 200) {
    //final List<dynamic> employeeJson = json.decode(response.body);
    //return employeeJson.map((e) => EmployeeModel.fromJson(e)).toList();
    return EmployeeModel.fromJsonList(json.decode(response.body));
  } else {
    throw ServerException();
  }
}

//https://reqres.in/api/users?page=2

class MyApp2 extends StatelessWidget {
  final Future<List<EmployeeModel>> employeeData;

  MyApp2({Key? key})
      : employeeData = getWordsData(), // Initialize the Future with the data
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Employee List'),
        ),
        body: FutureBuilder<List<EmployeeModel>>(
          future: employeeData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              // Build your ListView.builder here using snapshot.data
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final employee = snapshot.data![index];
                  return ListTile(
                    title: Text(employee.firstName),
                    subtitle: Text(employee.email),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(employee.avatar),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
