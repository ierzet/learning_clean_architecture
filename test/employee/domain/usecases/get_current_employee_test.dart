import 'package:dartz/dartz.dart';
import 'package:learning_clean_architecture/features/employee/domain/entities/employee.dart';
import 'package:learning_clean_architecture/features/employee/domain/usecases/get_current_employee.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late GetCurrentEmployeeUseCase getCurrentEmployeeUseCase;
  late MockEmployeeRepository mockEmployeeRepository;

  setUp(() {
    mockEmployeeRepository = MockEmployeeRepository();
    getCurrentEmployeeUseCase =
        GetCurrentEmployeeUseCase(mockEmployeeRepository);
  });

  const testEmployeeDetail = EmployeeEntity(
    id: 2,
    email: 'janet.weaver@reqres.in',
    firstName: 'Janet',
    lastName: 'Weaver',
    avatar: 'https://reqres.in/img/faces/2-image.jpg',
  );
  const int testId = 2;
  test('should get employee detail from repository', () async {
    when(mockEmployeeRepository.getCurrentEmployee(testId))
        .thenAnswer((_) async => const Right(testEmployeeDetail));

    final result = await getCurrentEmployeeUseCase.execute(testId);
    expect(result, const Right(testEmployeeDetail));
  });
}
