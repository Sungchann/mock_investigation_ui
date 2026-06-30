import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:mock_investigation_case/app.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';

void main() {
  logger.i("Mock Invesigation Case UI is running!");
  usePathUrlStrategy();
  runApp(const App());
}

