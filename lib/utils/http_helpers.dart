class HttpHelper {
  final String url = 'http://192.168.1.6:8000';
  final String development = 'http://192.168.1.6:8000/api';
  final String production = 'https://your-domain:8000/api';

  String getUri(String entpoints) {
    return development + entpoints;
  }
}
