//create state class that exactly like event
import 'package:equatable/equatable.dart';
import 'package:learning_clean_architecture/features/employee/domain/entities/employee.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeEmpty extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final EmployeeEntity result;

  const EmployeeLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class EmployeeLoadFailure extends EmployeeState {
  final String message;

  const EmployeeLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

////////////////
abstract class AllEmployeeState extends Equatable {
  const AllEmployeeState();

  @override
  List<Object> get props => [];
}

class AllEmployeeEmpty extends AllEmployeeState {}

class AllEmployeeLoading extends AllEmployeeState {}

class AllEmployeeLoaded extends AllEmployeeState {
  final List<EmployeeEntity> result;

  const AllEmployeeLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class AllEmployeeLoadFailure extends AllEmployeeState {
  final String message;

  const AllEmployeeLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
