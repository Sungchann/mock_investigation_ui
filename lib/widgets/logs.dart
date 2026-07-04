import 'package:flutter/material.dart';
import 'package:mock_investigation_case/models/log_entry.dart'; 

class Logs extends StatelessWidget { 
  final List<LogEntry> logs; 

  const Logs({
    super.key, 
    required this.logs, 
  }); 


  @override
  Widget build(BuildContext context){
    return Text("hello world");
  }

}