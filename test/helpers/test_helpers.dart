import 'package:learning_clean_architecture/features/employee/data/datasources/remote_data_source.dart';
import 'package:learning_clean_architecture/features/employee/domain/repositories/employee_repository.dart';
import 'package:learning_clean_architecture/features/employee/domain/usecases/get_current_employee.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    EmployeeRepository,
    EmployeeRemoteDataSource,
    GetCurrentEmployeeUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
