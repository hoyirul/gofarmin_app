class HeaderHelper {
  headersUnlogged() {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    return headers;
  }

  headersLogged(tokenType, accessToken) {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$tokenType $accessToken'
    };

    return headers;
  }
}
