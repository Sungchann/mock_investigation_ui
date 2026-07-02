import 'package:go_router/go_router.dart';

// screens
import 'package:mock_investigation_case/screens/cases/investigation_case.dart';
import 'package:mock_investigation_case/screens/debugging_screen.dart'; 

final router = GoRouter( 
  initialLocation: '/mock-v1',
  routes: [
    GoRoute(
      name: 'mock-v1',
      path: '/mock-v1',
      builder: (context, state) => InvestigationCaseScreen() 
    ),
    GoRoute(
      name: 'debug',
      path: '/debug',
      builder: (context, state) => DebuggingScreen()
    )
  ]
);