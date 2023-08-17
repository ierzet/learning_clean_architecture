import 'package:dartz/dartz.dart';
import 'package:learning_clean_architecture/core/error/failure.dart';
import 'package:learning_clean_architecture/features/employee/domain/entities/employee.dart';
import 'package:learning_clean_architecture/features/employee/domain/repositories/employee_repository.dart';

class GetCurrentAllEmployeeUsecase {
  final EmployeeRepository employeeRepository;

  GetCurrentAllEmployeeUsecase(this.employeeRepository);
  Future<Either<Failure, List<EmployeeEntity>>> execute() {
    return employeeRepository.getCureentAllEmployees();
  }
}
