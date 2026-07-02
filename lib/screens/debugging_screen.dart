import 'package:flutter/material.dart';
import 'package:mock_investigation_case/widgets/enterprise_workspace/enterprise_workspace.dart';
import 'package:recase/recase.dart'; 

class DebuggingScreen extends StatelessWidget{ 
  const DebuggingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: EnterpriseWorkspace(),
      ),
    );
  }
}