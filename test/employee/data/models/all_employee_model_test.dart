import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:learning_clean_architecture/features/employee/data/models/employee_model.dart';

import '../../../helpers/json_reader.dart';

void main() {
  const testAllEmployeeDetail = [
    EmployeeModel(
      id: 7,
      email: "michael.lawson@reqres.in",
      firstName: "Michael",
      lastName: "Lawson",
      avatar: "https://reqres.in/img/faces/7-image.jpg",
    ),
    EmployeeModel(
      id: 8,
      email: "lindsay.ferguson@reqres.in",
      firstName: "Lindsay",
      lastName: "Ferguson",
      avatar: "https://reqres.in/img/faces/8-image.jpg",
    ),
    EmployeeModel(
      id: 9,
      email: "tobias.funke@reqres.in",
      firstName: "Tobias",
      lastName: "Funke",
      avatar: "https://reqres.in/img/faces/9-image.jpg",
    ),
    EmployeeModel(
      id: 10,
      email: "byron.fields@reqres.in",
      firstName: "Byron",
      lastName: "Fields",
      avatar: "https://reqres.in/img/faces/10-image.jpg",
    ),
    EmployeeModel(
      id: 11,
      email: "george.edwards@reqres.in",
      firstName: "George",
      lastName: "Edwards",
      avatar: "https://reqres.in/img/faces/11-image.jpg",
    ),
    EmployeeModel(
      id: 12,
      email: "rachel.howell@reqres.in",
      firstName: "Rachel",
      lastName: "Howell",
      avatar: "https://reqres.in/img/faces/12-image.jpg",
    ),
  ];

  test(
    'should be a list of EmployeeEntity instances',
    () async {
      for (var employee in testAllEmployeeDetail) {
        expect(employee, isA<EmployeeModel>());
      }
    },
  );

  test(
    'should return a valid model from json',
    () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('helpers/dummy_data/dummy_all_employee_response.json'),
      );
      final result = EmployeeModel.fromJsonList(jsonMap);
      expect(result, equals(testAllEmployeeDetail));
    },
  );
}
