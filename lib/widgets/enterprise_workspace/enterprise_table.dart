import 'package:flutter/material.dart'; 

import 'package:data_table_2/data_table_2.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/models/collection_user.dart';
import 'package:mock_investigation_case/utils/fmt_bytes_coventer.dart';
import 'package:mock_investigation_case/utils/fmt_count_conveter.dart';

class EnterpriseTable extends StatelessWidget{ 
  final List<CollectionUser>? collectionUsers; 

  EnterpriseTable({
    super.key,
    required this.collectionUsers
  });
  
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
    'scope': 'Scope'
  };

  (ColumnSize, TextAlign) getColumnSizeAndTextAlign(String name) {
    switch (name) {
      case "name":
        return (ColumnSize.M, TextAlign.start);
      case "email":
      case "domain":
      case "scope":
        return (ColumnSize.L, TextAlign.start);
      case "status":
        return (ColumnSize.S, TextAlign.end);
      case 'emails':
      case "mailSize":
      case "driveSize":
      case "spSize":
      case "channels":
      case "calls":
        return (ColumnSize.S, TextAlign.end);
      default:
        return (ColumnSize.S, TextAlign.start);
    }
  }

  (String, Color, Color) getActionButtonDesign(String status){
    // label, bgcolor, textcolor
    status = status.toLowerCase();
    if (status == 'done') {
      return (
        'Export',
        Colors.green.shade100,
        Colors.green.shade800
      ); 
    } else if (status == 'error') {
      return (
        'Retry',
        Colors.red.shade100,
        Colors.red.shade800
      ); 
    } else if (status == 'collecting' || status == "not started") {
      return (
        'Collect',
        BrandingColor.blue700,
      Colors.white
      ); 
    } else {
      return (
        'Export',
        Colors.grey.shade100,
        Colors.grey.shade800
      ); 
    }
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsetsGeometry.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(  
                color: Color(0x0D000000),
                offset: Offset(0, 0),
                blurRadius: 15.0),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: DataTable2(
          columnSpacing: 16,
          horizontalMargin: 12,
          minWidth: 1000,
          headingRowHeight: 55,
          dataRowHeight: 40,
          headingRowColor: WidgetStateProperty.all(
            Colors.white
          ),
          dataRowColor: WidgetStateProperty.all(
            Colors.white
          ),
          columns: [
          ...enterpriseTableHeaders.entries.map((header){
              final (columnSize, textAlign) = getColumnSizeAndTextAlign(header.key);
              return DataColumn2(
                size: columnSize,
                label: Text(
                  header.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: BrandingColor.blue300
                  )
                ),
              );
            })
          ],
          rows: [
            ...(collectionUsers ?? []).map((user){
              final (label, bgColor, textColor) = getActionButtonDesign(user.status.name);
              return DataRow(cells: [
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
                  style: TextStyle(
                    fontSize: 11,
                    // fontFamily: 'Montserrat'
                    )
                    )
                  ),
                DataCell(
                  Text(user.domain, 
                  style: TextStyle(fontSize: 11))),
                DataCell(
                  Chip(
                    label: Text(
                      user.status.name.toString(),
                      style: TextStyle(
                        fontSize: 9,
                        color: user.status.name.toLowerCase() == 'done'
                        ? Colors.green
                          : user.status.name.toLowerCase() == 'collecting' 
                            ? BrandingColor.blue700
                              : user.status.name.toLowerCase() == 'error'
                                ? Colors.red
                                  : Colors.grey,
                      ),
                    ),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(0.2),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    backgroundColor: 
                      user.status.name.toLowerCase() == 'done'
                        ? Colors.green.withValues(alpha: 0.1)
                          : user.status.name.toLowerCase() == 'collecting' 
                            ? BrandingColor.blue700.withValues(alpha: 0.1)
                              : user.status.name.toLowerCase() == 'error'
                                ? Colors.red.withValues(alpha: 0.1)
                                  : Colors.grey.withValues(alpha: 0.1),
                    )
                  ),
                DataCell(
                  Text(fmtCount(user.discMail).toString(), 
                  style: TextStyle(fontSize: 11))),
                DataCell(
                  Text(fmtBytes(user.discMailSize).toString(),
                  style: TextStyle(fontSize: 11))),
                DataCell(
                  Text(fmtBytes(user.discDriveSize).toString(), 
                  style: TextStyle(fontSize: 11))),
                DataCell(
                  Text(fmtBytes(user.discSpSize).toString(), 
                  style: TextStyle(fontSize: 11))),
                DataCell(
                  Text(fmtCount(user.discTeamsCh).toString(), 
                  style: TextStyle(fontSize: 11))),
                DataCell(
                  Text(fmtCount(user.discTeamsCl).toString(), 
                  style: TextStyle(fontSize: 11))),
                DataCell(
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: (){
                    
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: bgColor ,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: textColor
                          ),
                        )
                      ),
                    ),
                  )
                )
              ]);
            }),
            
          ],
        )
      ),
    );
  } 
}