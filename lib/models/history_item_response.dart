class HistoryItemResponse {
  HistoryItemResponse(
      {this.resultId,
      this.modelResult,
      this.modelPercentage,
      this.pictureUrl,
      this.isPremium,
      this.diagnosisData});

  String? resultId;
  String? modelResult;
  double? modelPercentage;
  String? pictureUrl;
  bool? isPremium;
  List<DiagnosisData>? diagnosisData;

  factory HistoryItemResponse.fromJson(Map<String, dynamic> json) {
    var list = json['diagnosisData'] as List;
    List<DiagnosisData> diagnosisList =
        list.map((i) => DiagnosisData.fromJson(i)).toList();
    return HistoryItemResponse(
        resultId: json["resultId"],
        modelResult: json["resultData"]["modelResult"],
        pictureUrl: json["resultData"]["pictureUrl"],
        modelPercentage: double.tryParse(
            json["resultData"]["modelPercentage"] == "string"
                ? "0"
                : json["resultData"]["modelPercentage"] ?? "0"),
        isPremium: json["resultData"]["isPremium"],
        diagnosisData: diagnosisList);
  }

  Map<String, dynamic> toJson() => {
        "resultId": resultId,
        "resultData": {
          "modelResult": modelResult,
          "modelPercentage": modelPercentage,
          "pictureUrl": pictureUrl,
          "isPremium": isPremium,
        },
      };
}

class DiagnosisData {
  DiagnosisData({
    this.result,
    this.description,
    this.expertId,
    this.expertName
  });
 
  String? result;
  String? description;
  String? expertId;
  String? expertName;

  factory DiagnosisData.fromJson(Map<String, dynamic> json) =>
      DiagnosisData(
        result: json["result"],
        description: json["description"],
        expertId: json["expertId"],
        expertName: json["expertName"]
      );

  Map<String, dynamic> toJson() => {
          "result": result,
          "description": description,
          "expertId": expertId,
          "expertName" : expertName      
      };
}
