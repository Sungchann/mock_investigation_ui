import 'package:flutter/material.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:mock_investigation_case/models/collection_user.dart';
import 'package:mock_investigation_case/models/source_summary.dart';

class KPIValues extends StatelessWidget {
  final CollectionSource source;
  final SourceSummary? summary;

  KPIValues({
    required this.source,
    required this.summary,
    super.key,
  });



  Map<String, dynamic>? getValues(String name){
    if(name == "TribeType.enterprise" ){
      return{
        "Users": summary?.users,
        "Collected": "0/${summary?.users}", // e compute pani atay
        "Emails": summary?.emails,
        "Drive Files": summary?.driveFiles
      };
    } else if(name == "TribeType.personal"){
        return {
        "Accounts": 0, // pwede rasad e compute pero kaulion nako -_-
        "Items": 0
        };
    } else if(name == "TribeType.finance"){
      return{
        "Records" : 3,
        "Collected" : 1,
      };
    } else if(name == "TribeType.dump"){
      return{
        "Files": 1,
        "Status": "done"
      };
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    final values = getValues(source.tribeType.toString()) ?? {};
    // logger.i("summary check ${summary?.emails}");
    // logger.i("source check ${source.users}");
    // logger.i((users.id));
    // print(getValues(source.tribeType.toString()));
    return Padding(
      padding:const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        shrinkWrap: true,
        children: values.entries.map((entry) {
          return buildTile(entry.key, entry.value);
        }).toList(),
      )
    );
  }


  Widget buildTile(String title, dynamic value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}