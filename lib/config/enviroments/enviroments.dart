/// Environment variables and shared app constants.
class Enviroment {
  final String url;

  Enviroment({this.url = 'http://192.168.6.19:8081'});

  String getUrl() {
    return url;
  }
}
