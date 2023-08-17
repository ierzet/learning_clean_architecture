import 'package:learning_clean_architecture/features/employee/domain/entities/employee.dart';

class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required String avatar,
  }) : super(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          avatar: avatar,
        );
  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json['data']['id'],
        email: json['data']['email'],
        firstName: json['data']['first_name'],
        lastName: json['data']['last_name'],
        avatar: json['data']['avatar'],
      );

  static List<EmployeeModel> fromJsonList(dynamic jsonList) {
    final List<EmployeeModel> employeeList = [];

    if (jsonList is Map<String, dynamic> && jsonList.containsKey('data')) {
      final dataJsonList = jsonList['data'] as List<dynamic>;
      for (var json in dataJsonList) {
        employeeList.add(EmployeeModel(
          id: json['id'],
          email: json['email'],
          firstName: json['first_name'],
          lastName: json['last_name'],
          avatar: json['avatar'],
        ));
      }
    }

    return employeeList;
  }

  // static List<EmployeeModel> fromJsonList(List<dynamic> jsonList) {
  //   return jsonList
  //       .map((json) => EmployeeModel(
  //             id: json['id'],
  //             email: json['email'],
  //             firstName: json['first_name'],
  //             lastName: json['last_name'],
  //             avatar: json['avatar'],
  //           ))
  //       .toList();
  // }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'avatar': avatar,
      },
      'support': {
        'url': 'https://reqres.in/#support-heading',
        'text':
            'To keep ReqRes free, contributions towards server costs are appreciated!',
      },
    };
  }

  EmployeeEntity toEntity() => EmployeeEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar);

  static List<EmployeeEntity> toEntityList(List<EmployeeModel> models) {
    final List<EmployeeEntity> entities = [];

    for (var model in models) {
      final entity = model.toEntity();
      entities.add(entity);
    }

    return entities;
  }
  // static List<EmployeeEntity> toEntityList(List<EmployeeModel> models) {
  //   return models.map((model) => model.toEntity()).toList();
  // }
}
