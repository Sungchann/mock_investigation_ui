import 'package:flutter/material.dart'; 

import 'package:data_table_2/data_table_2.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/models/collection_user.dart';

class EnterpriseTable extends StatelessWidget{ 
  final List<CollectionUser>? collectionUsers; 

  EnterpriseTable({
    super.key,
    required this.collectionUsers
  });
  
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
  
  (ColumnSize?, double?, TextAlign) getColumnSizeAndTextAlign(String name) {
    switch (name) {
      case "name":
        return (null, 150, TextAlign.start);
      case "email":
      case "domain":
        return (ColumnSize.L, null, TextAlign.start);
      case "status":
      case 'emails':
      case "mailSize":
      case "driveSize":
      case "spSize":
      case "channels":
      case "calls":
        return (null, 100, TextAlign.end);
      case "scope":
        return (ColumnSize.L, null, TextAlign.start);
      default:
        return (ColumnSize.S, null, TextAlign.start);
    }
  }

  @override
  Widget build(BuildContext context){
    
    logger.i('enterprise_table ${collectionUsers?.length}'); 
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
        dataRowHeight: 40,
        headingRowColor: WidgetStateProperty.all(
          BrandingColor.blue300
        ),
        dataRowColor: WidgetStateProperty.all(
          Colors.white
        ),
        columns: [
          // DataColumn2(
          //   fixedWidth: 50,
          //   label: Checkbox(
          //     value: false,
          //     onChanged: (_) {
          //     },
          //   )
          // ),
        ...enterpriseTableHeaders.entries.map((header){
            final (columnSize, fixedWidth, textAlign) = getColumnSizeAndTextAlign(header.key);
            return DataColumn2(
              size: fixedWidth == null ? columnSize! : ColumnSize.S,
              fixedWidth: fixedWidth,
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
          ...(collectionUsers ?? []).map((user) => (
            DataRow(cells: [
              DataCell(
                Text(user.name, 
                  style: TextStyle(
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ),
              DataCell(
                Text(user.email, 
                style: TextStyle(fontSize: 11))),
              DataCell(
                Text(user.domain, 
                style: TextStyle(fontSize: 11))),
              DataCell(
                Text(user.status.name.toString(), 
                style: TextStyle(fontSize: 11))),
              DataCell(
                Text(user.discMail.toString(), 
                style: TextStyle(fontSize: 11))),
              DataCell(
                Text(user.discMailSize.toString(),
                style: TextStyle(fontSize: 11))),
              DataCell(
                Text(user.discDriveSize.toString(), 
                style: TextStyle(fontSize: 11))),
              DataCell(
                Text(user.discSpSize.toString(), 
                style: TextStyle(fontSize: 11))),
              DataCell(
                Text(user.discTeamsCh.toString(), 
                style: TextStyle(fontSize: 11))),
              DataCell(
                Text(user.discTeamsCl.toString(), 
                style: TextStyle(fontSize: 11))),
              DataCell(
                Text("scope yes scope", 
                style: TextStyle(fontSize: 11)))
            ])
          )),
          
        ],
      )
    );
  } 
}