class Response {
    String status;
    String message;
    List<dynamic> list;
    int count;
    dynamic data;

    Response({
        required this.status,
        required this.message,
        required this.list,
        required this.count,
        required this.data,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        status: json["status"],
        message: json["message"],
        list: List<dynamic>.from(json["list"]),
        count: json["count"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "list": List<dynamic>.from(list),
        "count": count,
        "data": data,
    };
}
