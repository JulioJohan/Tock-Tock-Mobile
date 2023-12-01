import 'dart:io';

class PostDto {
  // int? idPost;
  String description;
  // int? numLike;
  File? multimedia;
  // String? share;
  int user;
  // int? type;

  PostDto(
      {
        // required this.idPost,
      required this.description,
      // required this.numLike,
      this.multimedia,
      // required this.share,
      required this.user,
      // required this.type
      });

  factory PostDto.fromJson(Map<String, dynamic> json) => PostDto(
        // idPost: json["idPost"],
        description: json["description"],
        // numLike: json["numLike"],
        multimedia: json["multimedia"],
        // share: json["share"],
        user: json["user"],
        // type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        // "idPost": idPost,
        "description": description,
        // "numLike": numLike,
        "multimedia": multimedia,
        // "share": share,
        "user": user,
        // "type": type,
      };
}
