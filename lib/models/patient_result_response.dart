class PatientResultResponse {
  PatientResultResponse(
      {this.resultId, this.modelResult, this.modelPercentage, this.pictureUrl});

  String? resultId;
  String? modelResult;
  double? modelPercentage;
  String? pictureUrl;

  factory PatientResultResponse.fromJson(Map<String, dynamic> json) =>
      PatientResultResponse(
        resultId: json["resultId"],
        modelResult: json["data"]["modelResult"],
        pictureUrl: json["data"]["pictureUrl"],
        modelPercentage: double.tryParse(
            json["data"]["modelPercentage"] == "string"
                ? "0"
                : json["data"]["modelPercentage"] ?? "0"),
      );

  Map<String, dynamic> toJson() => {
        "resultId": resultId,
        "data": {
          "modelResult": modelResult,
          "modelPercentage": modelPercentage,
          "pictureUrl": pictureUrl
        },
      };
}