import 'package:flutter/material.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:mock_investigation_case/models/source_summary.dart';
import 'package:mock_investigation_case/services/collection.service.dart';
import 'package:mock_investigation_case/widgets/enterprise_workspace/enterprise_workspace.dart';
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

  bool isFetching = true;
  String? fetchingErrorMessage;

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
      final sources = results[1] as List<CollectionSource>;

      if (!mounted) return;
      setState(() {
        sourceSummary = summary; 
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
            child: Column(
              children: [
                TribeExpansionTile(tribeCategory: "Enterprise", tribeCount: 4),
                TribeExpansionTile(tribeCategory: "Personal", tribeCount: 2),
                TribeExpansionTile(tribeCategory: "Drive", tribeCount: 0),
                TribeExpansionTile(tribeCategory: "Finance", tribeCount: 1),
                TribeExpansionTile(tribeCategory: "Dump/Upload", tribeCount: 6),
              ],
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
                      EnterpriseWorkspace()
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

  // Widget _renderWorkspace(){

  // }
}