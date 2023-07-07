class HttpHelper {
  final String baseUrl = 'https://localhost:8000/api';

  String getUri(String entpoints) {
    return baseUrl + entpoints;
  }
}
