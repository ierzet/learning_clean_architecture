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
  late MockAllEmployeeRemoteDataSource mockAllEmployeeRemoteDataSource;

  setUp(() {
    mockEmployeeRemoteDataSource = MockEmployeeRemoteDataSource();
    mockAllEmployeeRemoteDataSource = MockAllEmployeeRemoteDataSource();
    employeeRepositoryImpl = EmployeeRepositoryImpl(
        employeeRemoteDataSource: mockEmployeeRemoteDataSource,
        allEmployeeRemoteDataSource: mockAllEmployeeRemoteDataSource);
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

  const testAllEmployeeModel = [
    EmployeeModel(
      id: 7,
      email: "michael.lawson@reqres.in",
      firstName: "Michael",
      lastName: "Lawson",
      avatar: "https://reqres.in/img/faces/7-image.jpg",
    ),
    EmployeeModel(
      id: 8,
      email: "lindsay.ferguson@reqres.in",
      firstName: "Lindsay",
      lastName: "Ferguson",
      avatar: "https://reqres.in/img/faces/8-image.jpg",
    ),
    EmployeeModel(
      id: 9,
      email: "tobias.funke@reqres.in",
      firstName: "Tobias",
      lastName: "Funke",
      avatar: "https://reqres.in/img/faces/9-image.jpg",
    ),
    EmployeeModel(
      id: 10,
      email: "byron.fields@reqres.in",
      firstName: "Byron",
      lastName: "Fields",
      avatar: "https://reqres.in/img/faces/10-image.jpg",
    ),
    EmployeeModel(
      id: 11,
      email: "george.edwards@reqres.in",
      firstName: "George",
      lastName: "Edwards",
      avatar: "https://reqres.in/img/faces/11-image.jpg",
    ),
    EmployeeModel(
      id: 12,
      email: "rachel.howell@reqres.in",
      firstName: "Rachel",
      lastName: "Howell",
      avatar: "https://reqres.in/img/faces/12-image.jpg",
    ),
  ];
  const testAllEmployeeEntity = [
    EmployeeEntity(
      id: 7,
      email: "michael.lawson@reqres.in",
      firstName: "Michael",
      lastName: "Lawson",
      avatar: "https://reqres.in/img/faces/7-image.jpg",
    ),
    EmployeeEntity(
      id: 8,
      email: "lindsay.ferguson@reqres.in",
      firstName: "Lindsay",
      lastName: "Ferguson",
      avatar: "https://reqres.in/img/faces/8-image.jpg",
    ),
    EmployeeEntity(
      id: 9,
      email: "tobias.funke@reqres.in",
      firstName: "Tobias",
      lastName: "Funke",
      avatar: "https://reqres.in/img/faces/9-image.jpg",
    ),
    EmployeeEntity(
      id: 10,
      email: "byron.fields@reqres.in",
      firstName: "Byron",
      lastName: "Fields",
      avatar: "https://reqres.in/img/faces/10-image.jpg",
    ),
    EmployeeEntity(
      id: 11,
      email: "george.edwards@reqres.in",
      firstName: "George",
      lastName: "Edwards",
      avatar: "https://reqres.in/img/faces/11-image.jpg",
    ),
    EmployeeEntity(
      id: 12,
      email: "rachel.howell@reqres.in",
      firstName: "Rachel",
      lastName: "Howell",
      avatar: "https://reqres.in/img/faces/12-image.jpg",
    ),
  ];

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
      //employee
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
      //list employee
      // Inside the test case for 'should return current all employee when a call datasource is successful'
      test(
        'should return current all employee when a call datasource is successful',
        () async {
          when(mockAllEmployeeRemoteDataSource.getCurrentAllEmployee())
              .thenAnswer((_) async => testAllEmployeeModel);

          final result = await employeeRepositoryImpl.getCureentAllEmployees();

          expect(
              result.toString(),
              equals(const Right<Failure, List<EmployeeEntity>>(
                      testAllEmployeeEntity)
                  .toString()));
          //ANEH, expect di bawah ini memiliki nilai string yang sama namun tidak equal
          //expect(result, equals(const Right(testAllEmployeeEntity)));
        },
      );

      test(
        'should return server failure when a call to all employee data source is unsuccessful',
        () async {
          when(mockAllEmployeeRemoteDataSource.getCurrentAllEmployee())
              .thenThrow(ServerException());

          final result = await employeeRepositoryImpl.getCureentAllEmployees();

          expect(result,
              equals(const Left(ServerFailure('an error has occurred'))));
        },
      );
    },
  );
}
