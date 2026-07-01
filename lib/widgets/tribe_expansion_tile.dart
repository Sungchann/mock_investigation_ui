import 'package:flutter/material.dart';

import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/enums/consent_state.dart';
import 'package:mock_investigation_case/enums/tribe_type.dart'; 
import 'package:mock_investigation_case/widgets/source_expansion_tile.dart';

class TribeExpansionTile extends StatelessWidget{ 
  final String tribeCategory;
  final int tribeCount;

  const TribeExpansionTile({
    required this.tribeCategory,
    required this.tribeCount,
    super.key
  });
  
  @override
  Widget build(BuildContext context){
    return ExpansionTile(
      shape: Border(),
      showTrailingIcon: false,
      leading: Container(
        width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tribeCategory,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12
            )
          ),
          Row(
            children: [
              Container(
                width: 20,
                decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(100)
                ),
                child: Center(
                  child: Text(
                    tribeCount.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    )
                  ),
                ) 
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 18,
                ),
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (_) => const AlertDialog(
                      title: Text("Create item")
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
      children: [
        SourceExpansionTile(
          sourceName: "micosoft 365", 
          sourceSubject: "#13 ddl@bbhs.dk (22 users)", 
          tribeType: TribeType.enterprise,
          consentState: ConsentState.collecting, 
          pipelineSteps: [["dasda", "asdsada"]]
        ),
      ],
    );
  }
}