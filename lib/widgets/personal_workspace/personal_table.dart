
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/models/collection_account.dart';

class PersonalTable extends StatelessWidget{
  final List<CollectionAccount>? collectionAccount;

  PersonalTable({
    super.key,
    required this.collectionAccount
  });

  final personalTableHeaders = {
    'email': "Email Account", 
    "status": "Status",
    "items": "Items Collected", 
    "action": "Actions"
  };

  (ColumnSize, TextAlign) getColumnSizeAndTextAlign(String name) {
    switch (name) {
      case "email":
        return (ColumnSize.M, TextAlign.start);
      case "domain":
      case "status":
        return (ColumnSize.S, TextAlign.end);
      case "items":
      default:
        return (ColumnSize.S, TextAlign.start);
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
            ...personalTableHeaders.entries.map((header){
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
            ...(collectionAccount ?? []).map((account) => (
              DataRow(cells: [
                DataCell(
                  Text(
                    account.email,
                    style: TextStyle(
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ),
                DataCell(
                  Chip(
                    label: Text(
                      account.status.toString(),
                      style: TextStyle(
                        fontSize: 9,
                        color: account.status.toLowerCase() == 'done'
                        ? Colors.green
                          : account.status.toLowerCase() == 'collecting' 
                            ? BrandingColor.blue700
                              : account.status.toLowerCase() == 'error'
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
                      account.status.toLowerCase() == 'done'
                        ? Colors.green.withValues(alpha: 0.1)
                          : account.status.toLowerCase() == 'collecting' 
                            ? BrandingColor.blue700.withValues(alpha: 0.1)
                              : account.status.toLowerCase() == 'error'
                                ? Colors.red.withValues(alpha: 0.1)
                                  : Colors.grey.withValues(alpha: 0.1),
                  )
                ),
                DataCell(
                  Text(
                    account.email,
                    style: TextStyle(
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ),
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
                          color: BrandingColor.blue700 ,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text("Collect",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: Colors.white
                          ),
                        )
                      ),
                    ),
                  )
                )
              ])
            ))
          ]
        ),
      ),
    );
  }
}