class DiagnosisResponse {
  DiagnosisResponse({
    this.value,
    this.msg,
    this.code,
  });

  String? value;
  String? msg;
  int? code;

  factory DiagnosisResponse.fromJson(Map<String, dynamic> json) => DiagnosisResponse(
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
