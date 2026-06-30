import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:timelines_plus/timelines_plus.dart';

import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';


class Pipeline extends StatelessWidget{
  final List<String> pipelineSteps;

  Pipeline({
    required this.pipelineSteps,
    super.key
  }); 

  final ScrollController _controller = ScrollController(); 

  @override
  Widget build(BuildContext context){
    logger.i(pipelineSteps);
    return SizedBox(
      height: 50,
      width: 250,
      child: Timeline.tileBuilder(
        scrollDirection: Axis.horizontal,
        builder: TimelineTileBuilder.connected(
          itemCount: pipelineSteps.length, 
          itemExtent: 50, //spacing between nodes

          contentsBuilder: (context, index){
            return Text(
              pipelineSteps.elementAt(index).toString().titleCase,
              style: TextStyle(
                fontSize: 8
              )
            );
          },

          indicatorBuilder: (context, index){
            return DotIndicator(
              color: Colors.green, 
              size: 20,
            );
          },

          connectorBuilder: (context, index, type){
            return SolidLineConnector(
              color: Colors.grey,
            );
          }
        )
      ),
    );
  }
}