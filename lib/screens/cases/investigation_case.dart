import 'package:flutter/material.dart'; 

// styling
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';

// widgets 
import 'package:mock_investigation_case/widgets/tribe_expansion_tile.dart';

class InvestigationCaseScreen extends StatelessWidget { 
  const InvestigationCaseScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                width: 300,
                child: TribeExpansionTile(tribeCategory: "Enterprise", tribeCount: 4)
              ),
              SizedBox(
                width: 300,
                child: TribeExpansionTile(tribeCategory: "Enterprise", tribeCount: 4)
              )
            ],            
          ),
          SizedBox(width: 25), 

          Text(
            "Investigation Case",
            style: TextStyle(
              color: BrandingColor.blue900,
              fontWeight: FontWeight.w900,
              fontSize: 24.0
            )
          ),
        ]
      )
    );
  }
}