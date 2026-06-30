import 'package:flutter/material.dart';

import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/routes.dart';

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      routerConfig: router,
    );
  }
}