import 'package:flutter/material.dart';
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:mock_investigation_case/widgets/finance_workspace/finance_table.dart';
import 'package:mock_investigation_case/widgets/logs.dart';

class FinanceWorkspace extends StatelessWidget{
  final CollectionSource financeCollectionSource;

  const FinanceWorkspace({
    super.key,
    required this.financeCollectionSource
  });

  @override
  Widget build(BuildContext context){
    return Builder(
      builder: (context){
        if (financeCollectionSource.logs.isEmpty){
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x0D000000),
                        offset: Offset(0, 0),
                        blurRadius: 10.0),
                  ],
                ),
                child: Center(
                  child: Text("Collection Source (Domain: Personal) is empty"),
                ),
              ),
            ),
          );
        }
        return _buildFinanceWorkspace(context);
      },
    );
  }

  Widget _buildFinanceWorkspace(BuildContext context){
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: FinanceTable(financeRecords: financeCollectionSource.financeRecords)
            ),
            Expanded(
              flex: 1, 
              child: Logs(logs: financeCollectionSource.logs)
            )
          ],
        ),
      ),
    );
  }
}