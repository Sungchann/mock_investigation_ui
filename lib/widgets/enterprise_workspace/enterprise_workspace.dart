import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recase/recase.dart'; 

// core
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';

// models
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:mock_investigation_case/models/collection_user.dart';

// services 
import 'package:mock_investigation_case/services/collection.service.dart';

// widgets
import 'package:mock_investigation_case/widgets/enterprise_workspace/enterprise_table.dart'; 

//utils 
import 'package:mock_investigation_case/utils/obtain_unique_values.dart';

class EnterpriseWorkspace extends StatefulWidget { 
  const EnterpriseWorkspace({super.key});

  @override
  State <EnterpriseWorkspace> createState() => _EnterpriseWorkspaceState();
}

class _EnterpriseWorkspaceState extends State<EnterpriseWorkspace>{
  final CollectionService _collectionService = CollectionService();
  late List<CollectionSource> allCollectionSource; 
  bool isFetching = true; 
  String? fetchingError;

  List<CollectionSource> allEnterpriseCollectionSource = [];
  List<CollectionUser> allEnterpriseCollectionUser = [];

  List<CollectionUser> filteredCollectionUsers = []; 

  //filters
  final List<String> statusFilters = ["all", "collecting", "done", "error"];
  String _selectedStatusFilter = "all";
  List<String> domainFilters = [];
  String _selectedDomainFilter = 'All'; 


  @override
  void initState(){
    super.initState(); 
    _fetchCollectionSources();  
  }

  Future<void> _fetchCollectionSources() async {
    setState(() {
      isFetching = true;
      fetchingError = null;
    });

    try {
      final result = await _collectionService.getCollectionSources();
      if (!mounted) return;

      setState(() {
        allCollectionSource = result;
        allEnterpriseCollectionSource = allCollectionSource.where((s) => 
          s.tribeType.name.toString() == "enterprise").toList();
        
        allEnterpriseCollectionUser = allEnterpriseCollectionSource.expand((source) =>
          source.users ?? []).cast<CollectionUser>().toList();

        // var encoder = JsonEncoder.withIndent(' ');
        // String prettyString = encoder.convert(allEnterpriseCollectionSource);
        // print(prettyString);
        
        final List<String> allDomainList = allEnterpriseCollectionUser.map((source) => 
          source.domain).toList();
        
        domainFilters = obtainUniqueValuesFromList(allDomainList);
        domainFilters.insert(0, "all");
        print(domainFilters); 
        isFetching = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        fetchingError = e.toString();
        isFetching = false;
      });
    }
  }
  
  List<CollectionUser> _applyStatusFilter(List<CollectionUser> users){
    if (_selectedStatusFilter== "all") return users; 
    return users.where((u) => 
      u.status.name.toString().toLowerCase() == _selectedStatusFilter.toLowerCase()).toList();
  }

  List<CollectionUser> _applyDomainFilter(List<CollectionUser> users){
    if (_selectedDomainFilter == 'all') return users; 
    return users.where((user) => 
      user.domain.toLowerCase() == _selectedDomainFilter.toLowerCase()).toList();
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
            Row(
              children: [
                ...statusFilters.map((statusFilter) => (
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                    onPressed: (){
                      setState(() {
                        _selectedStatusFilter = statusFilter;
                      });
                    },
                    child: Text(statusFilter.titleCase)
                  )
                )),
                PopupMenuButton<String>(
                  color: Colors.white, 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)), 
                  onSelected: (String value){
                    setState(() {
                      _selectedDomainFilter = value;
                    });
                  },
                  itemBuilder: (context) => [
                    ...domainFilters.map((domain) => PopupMenuItem<String>(
                        value: domain.titleCase,
                        child: Text(
                          domain.titleCase, 
                          style: TextStyle(fontSize: 12)
                        )
                    ))
                  ],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(_selectedDomainFilter,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_drop_down, color: BrandingColor.blue700)
                    ],
                  )
                )
              ],
            ),
            Expanded(
              child: Builder(
                builder: (context){
                  if (isFetching){
                    return Center(child: CircularProgressIndicator());
                  }
                  if (fetchingError != null){
                    return Center(child: Text('Error: $fetchingError'));
                  }
                  final users = _applyStatusFilter(allEnterpriseCollectionUser);
                  return EnterpriseTable(collectionUsers: users);
                },
              ),
            )
          ],
        )
      )
    );
  }

}