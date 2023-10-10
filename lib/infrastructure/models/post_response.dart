import 'package:toktok/infrastructure/models/user_response.dart';

class Post {
    int idPost;
    String description;
    int numLike;
    String multimedia;
    String share;
    int type;
    User? user;
    DateTime? dateRegistration;

    Post({
        required this.idPost,
        required this.description,
        required this.numLike,
        required this.multimedia,
        required this.share,
        required this.type,
        this.user,
        this.dateRegistration,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        idPost: json["idPost"],
        description: json["description"],
        numLike: json["numLike"],
        multimedia: json["multimedia"],
        share: json["share"],
        type: json["type"],
        user: User.fromJson(json["user"]),
        dateRegistration: DateTime.parse(json["dateRegistration"]),
    );

    Map<String, dynamic> toJson() => {
        "idPost": idPost,
        "description": description,
        "numLike": numLike,
        "multimedia": multimedia,
        "share": share,
        "type": type,
        "user": user!.toJson(),
        "dateRegistration": dateRegistration!.toIso8601String(),
    };
}