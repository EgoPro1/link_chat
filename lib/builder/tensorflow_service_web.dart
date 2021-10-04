import 'package:acceso_camara/js_functions.dart';
import 'package:js/js_util.dart' as jsutil;

Future<String> loadModel(String tfliteModelName, String tfliteModelLabels) async{
  return await jsutil.promiseToFuture<String>(loadTfliteModel());
}