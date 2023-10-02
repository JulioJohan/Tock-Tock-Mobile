class User {
    int idUser;
    String name;
    String email;
    String password;
    bool confirmed;
    String emailVerified;
    String multiFactorAuthentication;
    String? fatherLastName;
    String? motherLastName;
    int? age;
    DateTime? dateBirth;
    String avatar;

    User({
        required this.idUser,
        required this.name,
        required this.email,
        required this.password,
        required this.confirmed,
        required this.emailVerified,
        required this.multiFactorAuthentication,
        required this.fatherLastName,
        required this.motherLastName,
        required this.age,
        this.dateBirth,
        this.avatar = '',
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["idUser"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        confirmed: json["confirmed"],
        emailVerified: json["emailVerified"],
        multiFactorAuthentication: json["multiFactorAuthentication"],
        fatherLastName: json["fatherLastName"],
        motherLastName: json["motherLastName"],
        age: json["age"],
        dateBirth: json["dateBirth"] == null ? null : DateTime.parse(json["dateBirth"]),
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "name": name,
        "email": email,
        "password": password,
        "confirmed": confirmed,
        "emailVerified": emailVerified,
        "multiFactorAuthentication": multiFactorAuthentication,
        "fatherLastName": fatherLastName,
        "motherLastName": motherLastName,
        "age": age,
        "dateBirth": dateBirth,
        "avatar": avatar,
    };
}
