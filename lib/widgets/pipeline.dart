import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:timelines_plus/timelines_plus.dart';

import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';

class Pipeline extends StatelessWidget {
  final List<String> pipelineSteps;

  const Pipeline({
    required this.pipelineSteps,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return SizedBox(
      height: 50,
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
              itemCount: pipelineSteps.length,
              itemExtent: 50,
              nodePositionBuilder: (context, index) => 0,
              contentsBuilder: (context, index) {
                return Text(
                  pipelineSteps.elementAt(index).toString().titleCase,
                  style: const TextStyle(fontSize: 8),
                );
              },

              indicatorBuilder: (context, index) {
                return const DotIndicator(
                  color: Colors.green,
                  size: 20,
                );
              },

              connectorBuilder: (context, index, type) {
                return const SolidLineConnector(
                  color: Colors.grey,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}