import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_clean_architecture/features/employee/domain/usecases/get_current_employee.dart';
import 'package:learning_clean_architecture/features/employee/domain/usecases/get_current_list_employee.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_event.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_state.dart';
import 'package:rxdart/rxdart.dart';

//Employee
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetCurrentEmployeeUseCase _getCurrentEmployeeUseCase;

  EmployeeBloc(
    this._getCurrentEmployeeUseCase,
  ) : super(EmployeeEmpty()) {
    on<OnIdChanged>(
      _onIdChanged,
      transformer: debounce(const Duration(milliseconds: 1000)),
    );
  }

  void _onIdChanged(OnIdChanged event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());

    final result = await _getCurrentEmployeeUseCase.execute(event.id);
    result.fold(
      (failure) => emit(EmployeeLoadFailure(failure.message)),
      (data) => emit(EmployeeLoaded(data)),
    );
  }
}

//All Employee
class AllEmployeeBloc extends Bloc<AllEmployeeEvent, AllEmployeeState> {
  final GetCurrentAllEmployeeUsecase _getCurrentAllEmployeeUsecase;

  AllEmployeeBloc(
    this._getCurrentAllEmployeeUsecase,
  ) : super(AllEmployeeEmpty()) {
    on<GetAllEmployee>(_getAllEmployee,
        transformer: debounce(const Duration(milliseconds: 1000)));
  }

  void _getAllEmployee(
      GetAllEmployee event, Emitter<AllEmployeeState> emit) async {
    emit(AllEmployeeLoading());
    final result = await _getCurrentAllEmployeeUsecase.execute();
    result.fold(
      (failure) => emit(AllEmployeeLoadFailure(failure.message)),
      (data) => emit(AllEmployeeLoaded(data)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
