import 'package:flutter/material.dart';
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:mock_investigation_case/widgets/logs.dart';
import 'package:mock_investigation_case/widgets/personal_workspace/personal_table.dart';

class PersonalWorkspace extends StatelessWidget{
  final CollectionSource personalCollectionSource; 

  const PersonalWorkspace({
    super.key,
    required this.personalCollectionSource
  });

  @override
  Widget build(BuildContext context){
    return Builder(
      builder: (context){
        if (personalCollectionSource.domain.isEmpty){
          Container(
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
          );
        }
        return _buildPersonalWorkspace(context);
      },
    );
  }


  Widget _buildPersonalWorkspace(BuildContext context){ 
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: PersonalTable(collectionAccount: personalCollectionSource.accounts)
            ),
            Expanded(
              flex: 1,
              child: Logs(logs: personalCollectionSource.logs)
            )
          ],
        ),
      ),
    );
  }
}