class HttpHelper {
  final String url = 'https://services.gofarmin.com';
  final String development = 'http://192.168.1.6:8000/api';
  final String production = 'https://services.gofarmin.com/api';

  String getUri(String entpoints) {
    return production + entpoints;
  }
}
