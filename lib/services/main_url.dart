class MainUrl {
  String mainUrl = 'https://rayz.my.id/api';
  static String _token = '';

  void setToken(String? data) {
    if (data != null) {
      _token = data;
    }
  }

  String getToken() {
    return _token;
  }
}
