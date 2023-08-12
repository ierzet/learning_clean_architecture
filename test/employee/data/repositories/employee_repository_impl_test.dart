import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_clean_architecture/core/error/exception.dart';
import 'package:learning_clean_architecture/core/error/failure.dart';
import 'package:learning_clean_architecture/features/employee/data/models/employee_model.dart';
import 'package:learning_clean_architecture/features/employee/data/repositories/employee_repository_impl.dart';
import 'package:learning_clean_architecture/features/employee/domain/entities/employee.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockEmployeeRemoteDataSource mockEmployeeRemoteDataSource;
  late EmployeeRepositoryImpl employeeRepositoryImpl;

  setUp(() {
    mockEmployeeRemoteDataSource = MockEmployeeRemoteDataSource();
    employeeRepositoryImpl = EmployeeRepositoryImpl(
        employeeRemoteDataSource: mockEmployeeRemoteDataSource);
  });

  const testEmployeeModel = EmployeeModel(
    id: 2,
    email: 'janet.weaver@reqres.in',
    firstName: 'Janet',
    lastName: 'Weaver',
    avatar: 'https://reqres.in/img/faces/2-image.jpg',
  );
  const testEmployeeEntity = EmployeeEntity(
    id: 2,
    email: 'janet.weaver@reqres.in',
    firstName: 'Janet',
    lastName: 'Weaver',
    avatar: 'https://reqres.in/img/faces/2-image.jpg',
  );
  const testId = 2;
  group(
    'get currrent employee',
    () {
      test(
        'should return current employee when a call datasource is successful',
        () async {
          when(mockEmployeeRemoteDataSource.getCurrentEmployee(testId))
              .thenAnswer((_) async => testEmployeeModel);

          final result =
              await employeeRepositoryImpl.getCurrentEmployee(testId);
          expect(result, equals(const Right(testEmployeeEntity)));
        },
      );
      test(
        'should return server failure when a call datasource is unsuccessful',
        () async {
          when(mockEmployeeRemoteDataSource.getCurrentEmployee(testId))
              .thenThrow(ServerException());

          final result =
              await employeeRepositoryImpl.getCurrentEmployee(testId);

          expect(result,
              equals(const Left(ServerFailure('an error has an acourred'))));
        },
      );
      test(
        'should return connection failure when the device has no internet',
        () async {
          when(mockEmployeeRemoteDataSource.getCurrentEmployee(testId))
              .thenThrow(
                  const SocketException('failed connect to the network'));

          final result =
              await employeeRepositoryImpl.getCurrentEmployee(testId);

          expect(
              result,
              equals(const Left(
                  ConnectionFailure('failed connect to the network'))));
        },
      );
    },
  );
}
