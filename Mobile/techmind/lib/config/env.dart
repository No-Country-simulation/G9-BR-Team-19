abstract class Env {
  static const apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://192.168.1.50:8080/api',
  );

  static String? customApiUrl;

  static String get baseUrl {
    return customApiUrl ?? apiUrl;
  }
}
