import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_clean_architecture/features/employee/domain/entities/employee.dart';
import 'package:learning_clean_architecture/features/employee/domain/usecases/get_current_list_employee.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late GetCurrentAllEmployeeUsecase getCurrentAllEmployeeUsecase;
  late MockEmployeeRepository mockEmployeeRepository;

  setUp(() {
    mockEmployeeRepository = MockEmployeeRepository();
    getCurrentAllEmployeeUsecase =
        GetCurrentAllEmployeeUsecase(mockEmployeeRepository);
  });

  const testAllEmployeeDetail = [
    EmployeeEntity(
      id: 2,
      email: 'janet.weaver@reqres.in',
      firstName: 'Janet',
      lastName: 'Weaver',
      avatar: 'https://reqres.in/img/faces/2-image.jpg',
    ),
    EmployeeEntity(
      id: 3,
      email: 'budi.weaver@reqres.in',
      firstName: 'Budi',
      lastName: 'Weaver',
      avatar: 'https://reqres.in/img/faces/3-image.jpg',
    ),
  ];
  test('should get all employee detail from repository', () async {
    when(mockEmployeeRepository.getCureentAllEmployees())
        .thenAnswer((_) async => const Right(testAllEmployeeDetail));

    final result = await getCurrentAllEmployeeUsecase.execute();
    expect(result, const Right(testAllEmployeeDetail));
  });
}
