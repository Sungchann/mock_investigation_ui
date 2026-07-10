import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';

class Pipeline extends StatelessWidget {
  final String currentState;
  final String tribeType;

  const Pipeline({
    required this.currentState,
    required this.tribeType, 
    super.key,
  });

  List<List<String>> getPipelineSteps(String name){
    if(name == "enterprise"){
      return [
        ['pending', 'Consent sent'],
        ['granted', 'Consent granted'],
        ['discovering', 'Discovery'],
        ['collecting', 'Collecting'],
        ['done', 'Complete'],
      ];
    } else if(name == "dump"){
      return [
        ['pending', 'Folder selected'],
        ['collecting', 'Transferring'],
        ['done', 'Processed'],
      ];
    } else if(name == "finance"){
      return [
        ['pending', 'Consent sent'],
        ['granted', 'Consent granted'],
        ['ready', 'Collecting'],
        ['done', 'Complete'],
      ];
    }
    return [
        ['pending', 'Consent sent'],
        ['granted', 'Consent granted'],
        ['collecting', 'Collecting'],
        ['done', 'Complete'],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final steps = getPipelineSteps(tribeType);
    bool isStatePassed = false; 
    return SizedBox(
      height: 55,
      width: 250,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: Scrollbar(
          controller: controller,
          thumbVisibility: true,
          trackVisibility: true,
          child: Timeline.tileBuilder(
            scrollDirection: Axis.horizontal,
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
            builder: TimelineTileBuilder.connected(
              itemCount: steps.length,
              itemExtent: 60,
              nodePositionBuilder: (context, index) => 0,
              contentsBuilder: (context, index) {
                return Text(
                  steps.elementAt(index)[1].toString().titleCase,
                  style: TextStyle(
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                );
              },

              indicatorBuilder: (context, index) {
                final state = steps[index][1].toLowerCase();
                final indicator = DotIndicator(
                  size: 25,
                  color: isStatePassed == true
                    ? Colors.green
                      : state == currentState.toLowerCase()
                        ? BrandingColor.blue700
                          : Colors.grey,
                );

                if(state == currentState.toLowerCase()){
                  isStatePassed = true;
                }
                return indicator; 
              },

              connectorBuilder: (context, index, type) {
                return SolidLineConnector(
                  color: BrandingColor.blue300,
                  thickness: .5,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}