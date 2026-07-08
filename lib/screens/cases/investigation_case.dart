import 'package:flutter/material.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/enums/tribe_type.dart';
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:mock_investigation_case/models/source_summary.dart';
import 'package:mock_investigation_case/services/collection.service.dart';
import 'package:mock_investigation_case/widgets/drive_workspace/drive_workspace.dart';
import 'package:mock_investigation_case/widgets/dump_or_upload_workspace/dump_upload_workspace.dart';
import 'package:mock_investigation_case/widgets/enterprise_workspace/enterprise_workspace.dart';
import 'package:mock_investigation_case/widgets/finance_workspace/finance_workspace.dart';
import 'package:mock_investigation_case/widgets/personal_workspace/personal_workspace.dart';
import 'package:mock_investigation_case/widgets/tribe_expansion_tile.dart';
import 'package:mock_investigation_case/widgets/statistics_tab.dart';

class InvestigationCaseScreen extends StatefulWidget{
  const InvestigationCaseScreen({super.key});

  @override
  State <InvestigationCaseScreen> createState() => _InvestigationCaseScreenState();
}

class _InvestigationCaseScreenState extends State<InvestigationCaseScreen> { 
  final CollectionService _collectionService = CollectionService();
  late List<CollectionSource> collectionSource;
  late SourceSummary sourceSummary; 

  List<CollectionSource> enterpriseCollectionSource = []; 
  List<CollectionSource> personalCollectionSource = [];  
  List<CollectionSource> driveCollectionSource = []; 
  List<CollectionSource> financeCollectionSource = []; 
  List<CollectionSource> dumpOrUploadCollectionSource = [];

  bool isFetching = true;
  String? fetchingErrorMessage;

  int _currentSelectedSourceId= 0;

  @override
  void initState(){
    super.initState();
    _fetchCollectionSourceAndSummary();
  }

  Future<void> _fetchCollectionSourceAndSummary() async {
    setState(() {
      isFetching = true;
      fetchingErrorMessage = null;
    });

    try {
      final results = await Future.wait([
        _collectionService.getCollectionSummary(),
        _collectionService.getCollectionSources(),
      ]);

      final summary = results[0] as SourceSummary;
      final allCollectionSource = results[1] as List<CollectionSource>;

      if (!mounted) return;
      setState(() {
        sourceSummary = summary; 
        collectionSource = allCollectionSource;

        enterpriseCollectionSource = allCollectionSource.where((source) => 
          source.tribeType.name.toLowerCase().toString() == 'enterprise').toList();

        personalCollectionSource = allCollectionSource.where((source) => 
          source.tribeType.name.toLowerCase().toString() == 'personal').toList(); 

        driveCollectionSource = allCollectionSource.where((source) => 
          source.tribeType.name.toLowerCase().toString() == 'drive').toList(); 

        financeCollectionSource = allCollectionSource.where((source) => 
          source.tribeType.name.toLowerCase().toString() == 'finance').toList(); 

        dumpOrUploadCollectionSource = allCollectionSource.where((source) => 
          source.tribeType.name.toLowerCase().toString() == 'dump').toList(); 
        
        enterpriseCollectionSource.isNotEmpty 
          ? _currentSelectedSourceId = enterpriseCollectionSource.first.id
            : personalCollectionSource.isNotEmpty 
              ? _currentSelectedSourceId = personalCollectionSource.first.id
                : driveCollectionSource.isNotEmpty 
                  ? _currentSelectedSourceId = driveCollectionSource.first.id
                    : financeCollectionSource.isNotEmpty 
                      ?  _currentSelectedSourceId = financeCollectionSource.first.id
                        :  _currentSelectedSourceId = dumpOrUploadCollectionSource.first.id;
        
        isFetching = false;
      });
    } catch(e){
      if (!mounted) return; 
      setState(() {
        fetchingErrorMessage = e.toString(); 
        isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: BrandingColor.grey1, width: 1),
            ),
            child: Builder(
              builder: (context){
                if (isFetching){
                  return Center(child: CircularProgressIndicator());
                }
                if (fetchingErrorMessage != null){
                  return Center(
                    child: Text(
                      'Error Fetching Failed!',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w800,
                        fontSize: 16
                      ),
                      )
                  );
                }
                return _sideBar(context);
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: BrandingColor.blue50,
              ),
              child: Builder(
                builder: (context){
                  if (isFetching){
                    return Center(child: CircularProgressIndicator());
                  }
                  if (fetchingErrorMessage != null){
                    return Center(child: 
                      Text(
                        'Error: $fetchingErrorMessage',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w800,
                          fontSize: 16
                        ),
                      )
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Investigation Case",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20
                        ),
                      ),
                      SizedBox(height: 5),
                      StatisticsTab(sourceSummary: sourceSummary),
                      _buildWorkspace()
                    ],
                  );
                }
              )
            )
          )
        ],
      ),
    );
  }

  Widget _sideBar(BuildContext context){
    return Column(
      children: [
        TribeExpansionTile(
          tribeName: "Enterprise", 
          collectionSources: enterpriseCollectionSource, 
          currentSelectedSourceId: _currentSelectedSourceId, 
          onChangedSelectedSourceId: (selectedSourceId){
            setState(() {
              _currentSelectedSourceId = selectedSourceId;
            });
          }
        ),
        TribeExpansionTile(
          tribeName: "Personal", 
          collectionSources: personalCollectionSource, 
          currentSelectedSourceId: _currentSelectedSourceId, 
          onChangedSelectedSourceId: (selectedSourceId){
            setState(() {
              _currentSelectedSourceId = selectedSourceId;
            });
          }
        ),
        TribeExpansionTile(
          tribeName: "Drive", 
          collectionSources: driveCollectionSource, 
          currentSelectedSourceId: _currentSelectedSourceId, 
          onChangedSelectedSourceId: (selectedSourceId){
            setState(() {
              _currentSelectedSourceId = selectedSourceId;
            });
          }
        ),
        TribeExpansionTile(
          tribeName: "Finance", 
          collectionSources: financeCollectionSource, 
          currentSelectedSourceId: _currentSelectedSourceId, 
          onChangedSelectedSourceId: (selectedSourceId){
            setState(() {
              _currentSelectedSourceId = selectedSourceId;
            });
          }
        ),
        TribeExpansionTile(
          tribeName: "Dump / Upload", 
          collectionSources: dumpOrUploadCollectionSource, 
          currentSelectedSourceId: _currentSelectedSourceId, 
          onChangedSelectedSourceId: (selectedSourceId){
            setState(() {
              _currentSelectedSourceId = selectedSourceId;
            });
          }
        ),
      ],
    );
  }
  Widget _buildWorkspace(){
    if (isFetching){
      return Center(child: CircularProgressIndicator());
    }
    String tribeType = collectionSource.firstWhere((source) => 
    source.id == _currentSelectedSourceId).tribeType.name;
  
    CollectionSource selectedSelectionSource = collectionSource.firstWhere((source) => 
      source.id == _currentSelectedSourceId);

    switch(tribeType){
      case "enterprise": 
        return EnterpriseWorkspace(enterpriseCollectionSource: selectedSelectionSource);
      case "personal":
        return PersonalWorkspace(personalCollectionSource: selectedSelectionSource);
      case "drive":
        return DriveWorkspace(driveCollectionSource: selectedSelectionSource);
      case "finance":
        return FinanceWorkspace(financeCollectionSource: selectedSelectionSource);
      case "dump":
        return DumpUploadWorkspace(dumpUploadCollectionSource: selectedSelectionSource);
      default:
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
  }
}