// ignore: depend_on_referenced_packages
import 'package:get_it/get_it.dart';
import 'package:learning_clean_architecture/features/employee/data/datasources/remote_data_source.dart';
import 'package:learning_clean_architecture/features/employee/data/repositories/employee_repository_impl.dart';
import 'package:learning_clean_architecture/features/employee/domain/repositories/employee_repository.dart';
import 'package:learning_clean_architecture/features/employee/domain/usecases/get_current_employee.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void init() {
  //blocs
  sl.registerFactory<EmployeeBloc>(() => EmployeeBloc(sl()));

  //usecase
  sl.registerLazySingleton(() => GetCurrentEmployeeUseCase(sl()));

  //repository
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(
      employeeRemoteDataSource: sl(),
    ),
  );

  //data source
  sl.registerLazySingleton<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceImpl(client: sl()),
  );

  //external
  sl.registerLazySingleton(() => http.Client());
}
