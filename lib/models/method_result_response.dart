class MethodResultResponse {
  MethodResultResponse({
    this.value,
    this.msg,
    this.code,
  });

  String? value;
  String? msg;
  int? code;

  factory MethodResultResponse.fromJson(Map<String, dynamic> json) => MethodResultResponse(
        value: json["value"],
        msg: json["msg"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "msg": msg,
        "code": code
      };
}
