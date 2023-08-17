import 'package:flutter_test/flutter_test.dart';
import 'package:learning_clean_architecture/core/constansts/constants.dart';
import 'package:learning_clean_architecture/core/error/exception.dart';
import 'package:learning_clean_architecture/features/employee/data/datasources/remote_data_source_all_employee.dart';
import 'package:learning_clean_architecture/features/employee/data/models/employee_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late AllEmployeeRemoteDataSourceImpl allEmployeeRemoteDataSourceImpl;

  group(
    'get currrent all employee',
    () {
      setUp(() {
        mockHttpClient = MockHttpClient();
        allEmployeeRemoteDataSourceImpl = AllEmployeeRemoteDataSourceImpl(
          client: mockHttpClient,
        );
      });

      test('should return all employee model when the response code is 200',
          () async {
        when(mockHttpClient.get(Uri.parse(Urls.currentAllEmployee())))
            .thenAnswer((_) async => http.Response(
                readJson('helpers/dummy_data/dummy_all_employee_response.json'),
                200));

        final result =
            await allEmployeeRemoteDataSourceImpl.getCurrentAllEmployee();

        expect(result, isA<List<EmployeeModel>>());
      });

      test(
        'should throw a server exception when the response code is 404 or other',
        () async {
          when(mockHttpClient.get(Uri.parse(Urls.currentAllEmployee())))
              .thenAnswer((_) async => http.Response('not found', 404));

          Future<void> result() async {
            await allEmployeeRemoteDataSourceImpl.getCurrentAllEmployee();
          }

          expect(result, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
