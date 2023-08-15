import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_event.dart';
import 'package:learning_clean_architecture/features/employee/presentation/bloc/employee_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';

class MockEmployeeBloc extends MockBloc<EmployeeEvent, EmployeeState>
    implements EmployeeBloc {}

class FakeEmployeeState extends Fake implements EmployeeState {}

class FakeEmployeeEvent extends Fake implements EmployeeEvent {}

void main() {
  late MockEmployeeBloc mockEmployeeBloc;
  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeEmployeeState());
    registerFallbackValue(FakeEmployeeEvent());

    final sl = GetIt.instance;
    sl.registerFactory(() => mockEmployeeBloc);
  });

  setUp(() {
    mockEmployeeBloc = MockEmployeeBloc();
  });

/*
  testWidgets(
    'text field should trigger state to change from empty to loading',
    (WidgetTester tester) async {
      // arrange
      when(() => mockEmployeeBloc.state).thenReturn(EmployeeEmpty());

      // act
      await tester.pumpWidget(_makeTestableWidget(const Home()));
      await tester.enterText(find.byType(TextField), '2');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // assert
      verify(() => mockEmployeeBloc.add(const OnIdChanged(2))).called(1);
      expect(find.byType(TextField), equals(findsOneWidget));
    },
  );

*/
}
