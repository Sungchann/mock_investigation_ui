import 'package:flutter/material.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:mock_investigation_case/models/collection_user.dart';
import 'package:mock_investigation_case/services/collection.service.dart';
import 'package:mock_investigation_case/widgets/enterprise_workspace/enterprise_table.dart'; 

import 'dart:convert'; 

class EnterpriseWorkspace extends StatefulWidget { 
  const EnterpriseWorkspace({super.key});

  @override
  State <EnterpriseWorkspace> createState() => _EnterpriseWorkspaceState();
}

class _EnterpriseWorkspaceState extends State<EnterpriseWorkspace>{
  final CollectionService _collectionService = CollectionService(); 
  List<CollectionSource> enterpriseCollectionSource = [];
  List<CollectionUser> collectionUsers = []; 

  late Future<List<CollectionSource>> collectionSource;  

  @override
  void initState(){
    super.initState(); 
    collectionSource = _collectionService.getCollectionSources();  
    // [INITIAL IMPLEMENTATION - Manual state state]
    // collectionSource.then((collectionSource) {
    //   logger.i('enterprise_workshop: {collectionSource.length}');
    //   // if(collectionSource.isNotEmpty){
    //   //   const encoder = JsonEncoder.withIndent(' '); 
    //   //   final jsonList = collectionSource.map((e) => e.toJson()).toList(); 
    //   //   debugPrint(encoder.convert(jsonList));
    //   // }
    //   enterpriseCollectionSource = collectionSource.where((collSource) => collSource.tribeType.name.toString() == "enterprise").toList(); 
    //   if(enterpriseCollectionSource.isNotEmpty){
    //     const encoder = JsonEncoder.withIndent(' '); 
    //     debugPrint(encoder.convert(enterpriseCollectionSource));
    //   }
    //   collectionUsers = enterpriseCollectionSource.expand((source) => source.users ?? []).cast<CollectionUser>().toList();
    //   logger.i(collectionUsers.length); 
    // });
  }



  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: BrandingColor.blue50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Investigation Case",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20
              ),
            ),
            Expanded(
              child: FutureBuilder<List<CollectionSource>>(
                future: collectionSource, 
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError){
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final sources = snapshot.data ?? [];
                  final List<CollectionSource> enterpriseSources = sources.where((s) => s.tribeType.name.toString() == "enterprise").toList();
                  final List<CollectionUser> users = enterpriseSources.expand((s) => s.users ?? []).cast<CollectionUser>().toList();
                  return EnterpriseTable(collectionUsers: users);
                }
              ),
            )
          ],
        )
      )
    );
  }

}