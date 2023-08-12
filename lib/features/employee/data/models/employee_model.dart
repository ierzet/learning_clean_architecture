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
}
