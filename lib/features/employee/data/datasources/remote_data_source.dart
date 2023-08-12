import 'dart:convert';

import 'package:learning_clean_architecture/core/constansts/constants.dart';
import 'package:learning_clean_architecture/core/error/exception.dart';
import 'package:learning_clean_architecture/features/employee/data/models/employee_model.dart';
import 'package:http/http.dart' as http;

abstract class EmployeeRemoteDataSource {
  Future<EmployeeModel> getCurrentEmployee(int id);
}

class EmployeeRemoteDataSourceImpl extends EmployeeRemoteDataSource {
  final http.Client client;

  EmployeeRemoteDataSourceImpl({required this.client});

  @override
  Future<EmployeeModel> getCurrentEmployee(int id) async {
    final response = await client.get(Uri.parse(Urls.currentEmployeeById(id)));
    if (response.statusCode == 200) {
      return EmployeeModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
