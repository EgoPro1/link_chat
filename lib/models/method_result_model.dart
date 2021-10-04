class MethodResultModel {
  MethodResultModel (
      {
         this.pictureUrl,
         this.modelResult,
         this.modelPercentage,
         this.modelArchitecture,
      });

  String? pictureUrl;
  String? modelResult;
  String? modelPercentage;
  String? modelArchitecture;

  factory MethodResultModel .fromJson(Map<String, dynamic> json) {
    return MethodResultModel (
      pictureUrl: json["pictureUrl"],
      modelResult: json["modelResult"],
      modelPercentage: json["modelPercentage"],
      modelArchitecture: json["modelArchitecture"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pictureUrl": pictureUrl,
      "modelResult": modelResult,
      "modelPercentage": modelPercentage,
      "modelArchitecture": modelArchitecture,
    };
  }
}
