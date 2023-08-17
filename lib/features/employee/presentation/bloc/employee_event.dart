import 'package:equatable/equatable.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class OnIdChanged extends EmployeeEvent {
  final int id;

  const OnIdChanged(this.id);

  @override
  List<Object> get props => [id];
}

//////////////
abstract class AllEmployeeEvent extends Equatable {
  const AllEmployeeEvent();

  @override
  List<Object> get props => [];
}

class GetAllEmployee extends AllEmployeeEvent {
  const GetAllEmployee();

  @override
  List<Object> get props => [];
}
