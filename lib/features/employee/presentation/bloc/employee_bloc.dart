import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_clean_architecture/features/employee/domain/usecases/get_current_employee.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_event.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_state.dart';
import 'package:rxdart/rxdart.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetCurrentEmployeeUseCase _getCurrentEmployeeUseCase;

  EmployeeBloc(this._getCurrentEmployeeUseCase) : super(EmployeeEmpty()) {
    on<OnIdChanged>(
      (event, emit) async {
        emit(EmployeeLoading());
        final result = await _getCurrentEmployeeUseCase.execute(event.id);
        result.fold(
          (failure) => emit(EmployeeLoadFailure(failure.message)),
          (data) => emit(
            EmployeeLoaded(data),
          ),
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
