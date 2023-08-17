import 'dart:convert';

import 'package:learning_clean_architecture/core/constansts/constants.dart';
import 'package:learning_clean_architecture/core/error/exception.dart';
import 'package:learning_clean_architecture/features/employee/data/models/employee_model.dart';
import 'package:http/http.dart' as http;

abstract class AllEmployeeRemoteDataSource {
  Future<List<EmployeeModel>> getCurrentAllEmployee();
}

class AllEmployeeRemoteDataSourceImpl implements AllEmployeeRemoteDataSource {
  final http.Client client;

  AllEmployeeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EmployeeModel>> getCurrentAllEmployee() async {
    final response = await client.get(Uri.parse(Urls.currentAllEmployee()));

    if (response.statusCode == 200) {
      //final List<dynamic> employeeJson = json.decode(response.body);
      //return employeeJson.map((e) => EmployeeModel.fromJson(e)).toList();
      return EmployeeModel.fromJsonList(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
