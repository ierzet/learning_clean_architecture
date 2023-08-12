import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:learning_clean_architecture/core/error/exception.dart';
import 'package:learning_clean_architecture/core/error/failure.dart';
import 'package:learning_clean_architecture/features/employee/data/datasources/remote_data_source.dart';
import 'package:learning_clean_architecture/features/employee/domain/entities/employee.dart';
import 'package:learning_clean_architecture/features/employee/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  final EmployeeRemoteDataSource employeeRemoteDataSource;

  EmployeeRepositoryImpl({required this.employeeRemoteDataSource});

  @override
  Future<Either<Failure, EmployeeEntity>> getCurrentEmployee(int id) async {
    try {
      final result = await employeeRemoteDataSource.getCurrentEmployee(id);
      return right(result.toEntity());
    } on ServerException {
      return const Left(
        ServerFailure('an error has an acourred'),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }
}
