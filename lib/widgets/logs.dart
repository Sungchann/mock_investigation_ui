import 'package:flutter/material.dart';
import 'package:mock_investigation_case/models/log_entry.dart'; 
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';


class Logs extends StatelessWidget { 
  final List<LogEntry> logs; 

  const Logs({
    super.key, 
    required this.logs, 
  }); 


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(top: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: BrandingColor.blue900,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0D000000),
                offset: Offset(0, 0),
                blurRadius: 10.0),
          ],
        ),
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          child: ListView(
            children: logs.map((log) {
              return Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      log.time,
                      style: TextStyle(
                        color: BrandingColor.grey3,
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      log.message,
                      style: TextStyle(
                        color: BrandingColor.grey2,
                        fontSize: 12 
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

}