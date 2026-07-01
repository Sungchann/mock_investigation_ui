import 'package:flutter/material.dart'; 

import 'package:data_table_2/data_table_2.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';

class EnterpriseTable extends StatelessWidget{ 
  // headers checkBox, name, email, domain, status, emails, mail size, drive size, sp size, channels, calls, scope
  // freeze columns but can be overlapped by a certain length

  final enterpriseTableHeaders = {
    'name': "Name",
    'email': 'Email',
    'domain': 'Domain',
    'status': 'Status',
    'emails': 'Emails',
    'mailSize': 'Mail Size',
    'driveSize': 'Drive Size',
    'spSize': 'SP Size',
    'channels': 'Channels',
    'calls': 'Calls',
    'scope': 'scope'
  };

  EnterpriseTable({super.key});
  
  (ColumnSize, TextAlign) getColumnSizeAndTextAlign(String name){
    switch(name){
      case "name":
        return (ColumnSize.S, TextAlign.start);
      case "email":
      case "domain":
        return (ColumnSize.M, TextAlign.start);
      case "status":
        return (ColumnSize.S, TextAlign.start);
      case 'emails':
      case "mailSize":
      case "driveSize":
      case "spSize":
      case "channels":
      case "calls":
        return (ColumnSize.S, TextAlign.end); 
      case "scope": 
        return (ColumnSize.L, TextAlign.start);
      default:
        return (ColumnSize.S, TextAlign.start);
    }
  }

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 2, color: BrandingColor.grey4),
      ),
      clipBehavior: Clip.antiAlias,
      child: DataTable2(
        columnSpacing: 16,
        horizontalMargin: 12,
        minWidth: 800,
        headingRowHeight: 40,
        dataRowHeight: 28,
        headingRowColor: WidgetStateProperty.all(
          BrandingColor.blue300
        ),
        dataRowColor: WidgetStateProperty.all(
          Colors.white
        ),
        columns: [
          DataColumn2(
            fixedWidth: 50,
            label: Checkbox(
              value: false,
              onChanged: (_) {
              },
            )
          ),
          ...enterpriseTableHeaders.entries.map((header){
            final (columnSize, textAlign) = getColumnSizeAndTextAlign(header.value);
            return DataColumn2(
              size: columnSize,
              label: Text(
                header.value.toUpperCase(),
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700
                )
              ),
            );
          })
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('1')),
              DataCell(Text('2')),
              DataCell(Text('3')),
              DataCell(Text('4')),
              DataCell(Text('5')),
              DataCell(Text('6')),
              DataCell(Text('7')),
              DataCell(Text('8')),
              DataCell(Text('9')),
              DataCell(Text('10')),
              DataCell(Text('11')),
              DataCell(Text('12')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('1')),
              DataCell(Text('2')),
              DataCell(Text('3')),
              DataCell(Text('4')),
              DataCell(Text('5')),
              DataCell(Text('6')),
              DataCell(Text('7')),
              DataCell(Text('8')),
              DataCell(Text('9')),
              DataCell(Text('10')),
              DataCell(Text('11')),
              DataCell(Text('12')),
            ],
          ),
        ],
      )
    );
  } 
}