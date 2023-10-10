class ResponseData<T> {
    String status;
    String message;
    List<dynamic>? list;
    int count;
    T? data;

    ResponseData({
        required this.status,
        required this.message,
        this.list,
        required this.count,
        this.data,
    });

    factory ResponseData.fromJson(Map<String, dynamic> json, Function fromJson) {
    return ResponseData(
    status: json["status"],
    message: json["message"],
    list: json["list"] != null ? List.from(json["list"]).map((item) => fromJson(item)).toList() :null,
    count: json["count"],
    data: json["data"] != null ? fromJson(json["data"]) : null,
    );
  }


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
