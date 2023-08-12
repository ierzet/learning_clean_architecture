import 'package:dartz/dartz.dart';
import 'package:learning_clean_architecture/core/error/failure.dart';
import 'package:learning_clean_architecture/features/employee/domain/entities/employee.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, EmployeeEntity>> getCurrentEmployee(int id);
}
