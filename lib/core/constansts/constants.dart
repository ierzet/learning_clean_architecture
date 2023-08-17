class Urls {
  static const String baseUrlEmployee = 'https://reqres.in/api/users';
  static const String baseUrlUrlAllEmployee =
      'https://reqres.in/api/users?page=1';
  static const String apiKey = '';
  static String currentEmployeeById(int id) => '$baseUrlEmployee/$id';
  static String currentAllEmployee() => baseUrlUrlAllEmployee;
}
