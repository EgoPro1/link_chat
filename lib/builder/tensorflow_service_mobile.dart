import 'package:tflite/tflite.dart';

Future<String> loadModel(String tfliteModelName, String tfliteModelLabels) async{
  var res = await Tflite.loadModel(model: "assets/" + tfliteModelName, labels: "assets/" + tfliteModelLabels);
  return res!;
}