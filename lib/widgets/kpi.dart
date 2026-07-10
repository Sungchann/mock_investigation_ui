import 'package:flutter/material.dart';
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:mock_investigation_case/utils/fmt_count_conveter.dart';

class KPIValues extends StatelessWidget {
  final CollectionSource source;

  const KPIValues({
    required this.source,
    super.key,
  });

  Map<String, dynamic>? getValues(String name){
    if(name == "TribeType.enterprise" ){
      final int collectedUsers = source.users != null
       ? source.users!.where((user) => user.status.name.toString() == "done").length
        : 0;
      
      final int emailSizeBytes = source.users != null 
        ? source.users!.fold(0, (emailSize, user) => emailSize + user.discMail)
          : 0;
      
      final int driveSize = source.users != null 
        ? source.users!.fold(0, (driveFiles, user) => driveFiles + user.driveFiles)
          : 0;

      return {
        "Users": "${source.users?.length ?? 0}",
        "Collected": "$collectedUsers/${source.users?.length ?? 0}",
        "Emails": fmtCount(emailSizeBytes),
        "Drive Files": fmtCount(driveSize)
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
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        shrinkWrap: true, 
        childAspectRatio: 3,
        children: values.entries.map((entry) {
          return buildTile(entry.key, entry.value);
        }).toList(),
      )
    );
  }


  Widget buildTile(String title, dynamic value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}