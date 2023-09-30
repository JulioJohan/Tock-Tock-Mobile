class Response<T> {
    String status;
    String message;
    List<T>? list;
    int count;
    T? data;

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
        list: List<T>.from(json["list"]),
        count: json["count"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "list": List<T>.from(list!),
        "count": count,
        "data": data,
    };

    void setList(List<T>? tmp) {
      if (tmp != null) {
        this.list = List<T>.from(tmp);
      }
    }

    List<T>? getList() {
      if (this.list != null) {
        return List<T>.from(this.list!);
      }
      return null;
    }
}
