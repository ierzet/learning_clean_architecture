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
