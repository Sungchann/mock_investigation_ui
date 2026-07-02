import 'package:flutter/material.dart'; 

// styling
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/widgets/enterprise_workspace/enterprise_workspace.dart';

// widgets 
import 'package:mock_investigation_case/widgets/tribe_expansion_tile.dart';

class InvestigationCaseScreen extends StatelessWidget { 
  const InvestigationCaseScreen({super.key});

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
          // goes to the tribeCategory workspace
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: BrandingColor.blue50,
              ),
              child: Column(
                children: [
                  EnterpriseWorkspace()
                ],
              )
            )
          )
        ],
      ),
    );
  }
}