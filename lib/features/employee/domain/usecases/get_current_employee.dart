import 'package:dartz/dartz.dart';
import 'package:learning_clean_architecture/core/error/failure.dart';
import 'package:learning_clean_architecture/features/employee/domain/entities/employee.dart';
import 'package:learning_clean_architecture/features/employee/domain/repositories/employee_repository.dart';

class GetCurrentEmployeeUseCase {
  final EmployeeRepository employeeRepository;

  GetCurrentEmployeeUseCase(this.employeeRepository);
  Future<Either<Failure, EmployeeEntity>> execute(int id) {
    return employeeRepository.getCurrentEmployee(id);
  }
}
