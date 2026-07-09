import 'package:flutter/material.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';
import 'package:mock_investigation_case/widgets/enterprise_workspace/enterprise_filter_bar.dart';
import 'package:mock_investigation_case/widgets/logs.dart';
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:mock_investigation_case/models/collection_user.dart';
import 'package:mock_investigation_case/widgets/enterprise_workspace/enterprise_table.dart'; 

class EnterpriseWorkspace extends StatefulWidget { 
  final CollectionSource enterpriseCollectionSource;

  const EnterpriseWorkspace({
    super.key,
    required this.enterpriseCollectionSource
  });

  @override
  State <EnterpriseWorkspace> createState() => _EnterpriseWorkspaceState();
}

class _EnterpriseWorkspaceState extends State<EnterpriseWorkspace>{
  List<CollectionUser> collectionUsers = [];
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
    _obtainData();  
  }

  void _obtainData() {
    final users = widget.enterpriseCollectionSource.users;
    if (users != null) {
      collectionUsers = users.cast<CollectionUser>();
      domainFilters = [
        "all",
        ...collectionUsers.map((u) => u.domain).toSet(),
      ];
    }
  }
  
  List<CollectionUser> get applyFilters {
    var users = collectionUsers;
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
                  if (collectionUsers.isEmpty){
                    return Center(
                      child: Text(
                        'No users available',
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
              child: Logs(logs: widget.enterpriseCollectionSource.logs),
            )
          ],
        )
      )
    );
  }

}