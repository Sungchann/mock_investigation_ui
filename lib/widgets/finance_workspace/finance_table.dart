

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/models/finance_record.dart';

class FinanceTable extends StatelessWidget{
  final List<FinanceRecord>? financeRecords;

  FinanceTable({
    super.key,
    required this.financeRecords
  });


  final financeRecordTableHeaders = {
    "type": "Record Type",
    "count": "Count",
    "range": "Date Range",
    "status": "Status",
    "action": "Action"
  };

  (ColumnSize, TextAlign) getColumnSizeAndTextAlign(String name) {
    switch (name) {
      case "type":
        return (ColumnSize.M, TextAlign.start);
      case "count": 
        return (ColumnSize.M, TextAlign.end);
      case "range":
        return (ColumnSize.M, TextAlign.start);
      case "action":
        return (ColumnSize.M, TextAlign.start);
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
    } else if (status == 'collecting' || status == "not started"){
      return (
        'Collect',
        BrandingColor.blue700,
        Colors.white
      ); 
    } else {
      return (
        'Error',
        Colors.grey.shade100,
        Colors.grey.shade800
      ); 
    }
  }
  
  @override
  Widget build(BuildContext context) {
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
            ...financeRecordTableHeaders.entries.map((record){
              final(columnSize, textAlign) = getColumnSizeAndTextAlign(record.key);
              return DataColumn2(
                size: columnSize,
                label: Text(
                  record.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: BrandingColor.blue300 
                  ),
                ),
              );
            })
          ],
          rows: [
            ...(financeRecords ?? []).map((record){
              final (label, bgColor, textColor) = getActionButtonDesign(record.status);
              return DataRow(cells: [
                DataCell(
                  Text(
                    record.type,
                    style: TextStyle(
                      fontSize: 11
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ),
                DataCell(
                  Text(
                    record.count.toString(),
                    style: TextStyle(
                      fontSize: 11
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ),
                DataCell(
                  Text(
                    record.range,
                    style: TextStyle(
                      fontSize: 11
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ),
                DataCell(
                  Chip(
                    label: Text(
                      record.status.toString(),
                      style: TextStyle(
                        fontSize: 9,
                        color: record.status.toLowerCase() == 'done'
                        ? Colors.green
                          : record.status.toLowerCase() == 'collecting' 
                            ? BrandingColor.blue700
                              : record.status.toLowerCase() == 'error'
                                ? Colors.red
                                  : Colors.grey, 
                      )
                    ),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    padding: EdgeInsets.all(0.2),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    backgroundColor: 
                      record.status.toLowerCase() == 'done'
                        ? Colors.green.withValues(alpha: 0.1)
                          : record.status.toLowerCase() == 'collecting' 
                            ? BrandingColor.blue700.withValues(alpha: 0.1)
                              : record.status.toLowerCase() == 'error'
                                ? Colors.red.withValues(alpha: 0.1)
                                  : Colors.grey.withValues(alpha: 0.1),
                  )
                ),
                DataCell(
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: (){
                    
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: textColor,
                          )
                        )
                      ),
                    ),
                  )
                )
              ]);
            })
          ],
        ),
      ),
    );
  }
}