import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:learning_clean_architecture/core/error/exception.dart';
import 'package:learning_clean_architecture/core/error/failure.dart';
import 'package:learning_clean_architecture/features/employee/data/datasources/remote_data_source.dart';
import 'package:learning_clean_architecture/features/employee/data/datasources/remote_data_source_all_employee.dart';
import 'package:learning_clean_architecture/features/employee/data/models/employee_model.dart';
import 'package:learning_clean_architecture/features/employee/domain/entities/employee.dart';
import 'package:learning_clean_architecture/features/employee/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  final EmployeeRemoteDataSource employeeRemoteDataSource;
  final AllEmployeeRemoteDataSource allEmployeeRemoteDataSource;

  EmployeeRepositoryImpl(
      {required this.employeeRemoteDataSource,
      required this.allEmployeeRemoteDataSource});

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

  @override
  Future<Either<Failure, List<EmployeeEntity>>> getCureentAllEmployees() async {
    try {
      final result = await allEmployeeRemoteDataSource.getCurrentAllEmployee();
      //print('result: $result');
      final List<EmployeeEntity> entityList =
          EmployeeModel.toEntityList(result);
      //final entityList = result.map((model) => model.toEntity()).toList();
      //print('entityList: $entityList');
      return right(entityList);
    } on ServerException {
      return const Left(
        ServerFailure('an error has occurred'),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('failed connect to the network'),
      );
    }
  }
}
