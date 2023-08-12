import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:learning_clean_architecture/features/employee/data/models/employee_model.dart';
import 'package:learning_clean_architecture/features/employee/domain/entities/employee.dart';

import '../../../helpers/json_reader.dart';

void main() {
  const testEmployeeModel = EmployeeModel(
    id: 2,
    email: 'janet.weaver@reqres.in',
    firstName: 'Janet',
    lastName: 'Weaver',
    avatar: 'https://reqres.in/img/faces/2-image.jpg',
  );
  test(
    'should be a subclass of employee entity',
    () async {
      expect(testEmployeeModel, isA<EmployeeEntity>());
    },
  );

  test(
    'should return a valid model from json',
    () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('helpers/dummy_data/dummy_employe_response.json'),
      );
      final result = EmployeeModel.fromJson(jsonMap);

      expect(result, equals(testEmployeeModel));
    },
  );
  test(
    'should return a json map containing proper data',
    () async {
      final result = testEmployeeModel.toJson();
      final expectedJsonmap = {
        "data": {
          "id": 2,
          "email": "janet.weaver@reqres.in",
          "first_name": "Janet",
          "last_name": "Weaver",
          "avatar": "https://reqres.in/img/faces/2-image.jpg"
        },
        "support": {
          "url": "https://reqres.in/#support-heading",
          "text":
              "To keep ReqRes free, contributions towards server costs are appreciated!"
        }
      };
      expect(result, equals(expectedJsonmap));
    },
  );
}

// /Users/erzets/dev/learning_clean_architecture/test/helpers/dummy_data/dummy_employe_response.json