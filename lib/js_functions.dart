@JS()
library main;

import 'package:js/js.dart';

@JS('buildAndRunModel')
external String executeModel();

@JS('loadTfliteModel')
external String loadTfliteModel();