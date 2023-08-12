import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  const EmployeeEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id, email, firstName, lastName, avatar];
}
