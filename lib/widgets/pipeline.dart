import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:recase/recase.dart';
import 'package:timelines_plus/timelines_plus.dart';

import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';

class Pipeline extends StatelessWidget {
  final ScrollController controller = ScrollController();

  final String pipelineProgress;
  final String name;

  Pipeline({
    required this.pipelineProgress,
    required this.name,

    super.key,
  });


  List<List<String>> getPipelineSteps(String name){
    if(name == "TribeType.enterprise"){
      return [
        ['ConsentState.pending', 'Consent sent'],
        ['ConsentState.granted', 'Consent granted'],
        ['ConsentState.discovering', 'Discovery'],
        ['ConsentState.collecting', 'Collecting'],
        ['ConsentState.done', 'Complete'],
      ];
    } else if(name == "TribeType.dump"){
      return [
        ['ConsentState.pending', 'Folder selected'],
        ['ConsentState.collecting', 'Transferring'],
        ['ConsentState.done', 'Processed'],
      ];
    } else if(name == "TribeType.finance"){
      return [
        ['ConsentState.pending', 'Consent sent'],
        ['ConsentState.granted', 'Consent granted'],
        ['ConsentState.ready', 'Collecting'],
        ['ConsentState.done', 'Complete'],
      ];
    }
    return [
        ['ConsentState.pending', 'Consent sent'],
        ['ConsentState.granted', 'Consent granted'],
        ['ConsentState.collecting', 'Collecting'],
        ['ConsentState.done', 'Complete'],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final steps = getPipelineSteps(name);
    return SizedBox(
      height: 50,
      width: 250,
      child:Scrollbar(
        thumbVisibility: true,
        controller: controller,
        child: SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: steps.map((step) {
              final state = step[0];
              final label = step[1];
              return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: state == pipelineProgress
                    ? Colors.blue
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: state == pipelineProgress
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            );
            }).toList(),
          )
        ),
      )
    );
  }
}