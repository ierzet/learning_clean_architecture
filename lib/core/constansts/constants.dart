class Urls {
  static const String baseUrl = 'https://reqres.in/api/users';
  static const String apiKey = '';
  static String currentEmployeeById(int id) => '$baseUrl/$id';
}
