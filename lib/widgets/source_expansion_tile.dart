import 'package:flutter/material.dart';
import 'package:recase/recase.dart'; 

import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';

import 'package:mock_investigation_case/enums/tribe_type.dart';
import 'package:mock_investigation_case/enums/consent_state.dart';
import 'package:mock_investigation_case/widgets/pipeline.dart'; 

// if state is pending or dump then comfirm granted
// if state is ready then start collection
// if state is collecting then can pause
// if state is done then can do export and worflow
(Color, Color) getPillBackgroundColorAndTextColor(ConsentState consentState){
  if(ConsentState.collecting == consentState){
    return (Color(0xFFEFF6FF), Color(0xFF1D4ED8));
  }
  else if(ConsentState.done == consentState){
    return (Color(0xFFF0FDF4), Color(0xFF15803D));
  }
  return (Color(0xFFFFF7ED), Color(0xFF92400E)); 
}

class SourceExpansionTile extends StatelessWidget{ 
  final String? sourceLogoName;
  final String sourceName; 
  final String sourceSubject;
  final TribeType tribeType;
  final ConsentState consentState; 
  final List<List<String>> pipelineSteps;

  const SourceExpansionTile({
    this.sourceLogoName,
    required this.sourceName,
    required this.sourceSubject,
    required this.tribeType,
    required this.consentState,
    required this.pipelineSteps, 
    super.key
  }); 

  @override
  Widget build(BuildContext context){
    final (backgroundColor, textColor) = getPillBackgroundColorAndTextColor(consentState);
    logger.i("Source expansion tile dart!");
    return ExpansionTile(
      showTrailingIcon: false,
      leading: Container(
        width: 30,
        height: 15,
        decoration: BoxDecoration(
          image: sourceLogoName != null ? DecorationImage(
            image: AssetImage(sourceLogoName!), 
            fit: BoxFit.contain,
          )
          : null,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sourceName.toString().titleCase,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                )
              ),
               Text(
                sourceSubject.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 9,
                  color: BrandingColor.grey2
                )
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Text(
                consentState.name.toString().titleCase,
                style: TextStyle(
                  fontSize: 11, 
                  fontWeight: FontWeight.w500, 
                  color: textColor
                )
              )
            )
          )
        ],
      ),
      children: [
        Pipeline(pipelineSteps: ["Agwa", "Core", "Icon", "Agwa", "Core", "Icon", "Agwa", "Core", "Icon", "Agwa", "Core", "Icon", "Agwa", "Core", "Icon", "Agwa", "Core", "Icon"])
      ],
    ); 
  }
}