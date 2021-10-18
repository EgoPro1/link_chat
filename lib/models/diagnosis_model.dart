class DiagnosisModel {
  DiagnosisModel({
    required this.result,
    required this.description,
  });

  String? result;
  String? description;

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
      result: json["result"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "result": result,
      "description": description,
    };
  }
}

