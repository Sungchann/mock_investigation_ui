import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mock_investigation_case/models/log_entry.dart';
import 'package:mock_investigation_case/widgets/enterprise_workspace/enterprise_filter_bar.dart';
import 'package:mock_investigation_case/widgets/logs.dart';
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
  List<LogEntry> logs = [];
  
  List<CollectionUser> filteredCollectionUsers = []; 

  //filters
  final List<String> statusFilters = ["all", "collecting", "done", "error"];
  List<String> domainFilters = [];

  String _selectedStatusFilter = "all";
  String _selectedDomainFilter = 'all'; 
  String _searchQuery = "";

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
        
        logs = allEnterpriseCollectionSource.expand((source) => 
          source.logs).cast<LogEntry>().toList();   

        domainFilters = obtainUniqueValuesFromList(allDomainList);
        domainFilters.insert(0, "all");  
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
  
  List<CollectionUser> get applyFilters {
    var users = allEnterpriseCollectionUser;

    users = _applyStatusFilter(users);
    users = _applyDomainFilter(users);
    users = _applySearchFilter(users);

    return users;
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

  List<CollectionUser> _applySearchFilter(List<CollectionUser> users) {
    if (_searchQuery.trim().isEmpty) return users;

    final query = _searchQuery.toLowerCase();

    return users.where((user) {
      return user.name.toLowerCase().contains(query) ||
            user.domain.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        decoration: BoxDecoration(
          color: BrandingColor.blue50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EnterpriseFilterBar(
              currentSelectedStatus: _selectedStatusFilter, 
              onChangedSelectedStatus: (status){
                setState(() {
                  _selectedStatusFilter = status;
                });
              },
              domainFilters: domainFilters,
              currentSelectedDomain: _selectedDomainFilter,
              onChangedSelectedDomain: (domain){
                setState(() {
                  _selectedDomainFilter = domain; 
                });
              },
              currentSearchQuery: _searchQuery,
              onSearchChanged: (searchQuery){
                setState(() {
                  _searchQuery = searchQuery;
                });
              },
            ),
            Expanded(
              flex: 3,
              child: Builder(
                builder: (context){
                  if (isFetching){
                    return Center(child: CircularProgressIndicator());
                  }
                  if (fetchingError != null){
                    return Center(
                      child: Text(
                        'Error: $fetchingError',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w800,
                          fontSize: 16
                        ),
                        )
                    );
                  }
                  final users = applyFilters;
                  return EnterpriseTable(collectionUsers: users);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Logs(logs: logs),
            )
          ],
        )
      )
    );
  }

}