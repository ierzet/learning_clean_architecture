// create testing EmployeeBloc which has result initial state should be empty

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_clean_architecture/core/error/failure.dart';
import 'package:learning_clean_architecture/features/employee/domain/entities/employee.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_event.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_state.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockGetCurrentEmployeeUseCase mockGetCurrentEmployeeUseCase;
  late EmployeeBloc employeeBloc;

  setUp(() {
    mockGetCurrentEmployeeUseCase = MockGetCurrentEmployeeUseCase();
    employeeBloc = EmployeeBloc(mockGetCurrentEmployeeUseCase);
  });

  const testEmployeeEntity = EmployeeEntity(
    id: 2,
    email: 'janet.weaver@reqres.in',
    firstName: 'Janet',
    lastName: 'Weaver',
    avatar: 'https://reqres.in/img/faces/2-image.jpg',
  );
  const int testId = 2;

  test(
    'initial state should be empty',
    () async {
      expect(employeeBloc.state, equals(EmployeeEmpty()));
    },
  );

  blocTest<EmployeeBloc, EmployeeState>(
    'should emit [EmployeeLoading, EmployeeLoaded] when data is fetched successfully',
    build: () {
      when(mockGetCurrentEmployeeUseCase.execute(testId))
          .thenAnswer((_) async => const Right(testEmployeeEntity));
      return employeeBloc;
    },
    act: (bloc) => bloc.add(const OnIdChanged(testId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      EmployeeLoading(),
      const EmployeeLoaded(testEmployeeEntity),
    ],
  );
  blocTest<EmployeeBloc, EmployeeState>(
    'should emit [EmployeeLoading, EmployeeLoaded] when data is  unsuccessfully',
    build: () {
      when(mockGetCurrentEmployeeUseCase.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('server failure')));
      return employeeBloc;
    },
    act: (bloc) => bloc.add(const OnIdChanged(testId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      EmployeeLoading(),
      const EmployeeLoadFailure('server failure'),
    ],
  );
}
