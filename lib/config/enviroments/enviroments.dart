/// Environment variables and shared app constants.
class Enviroment {
  final String url;

  Enviroment({this.url = 'https://social-hub-backend.hop.sh'});

  String getUrl() {
    return url;
  }
}
