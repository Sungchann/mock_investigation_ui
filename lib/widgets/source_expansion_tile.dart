import 'package:flutter/material.dart';
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:mock_investigation_case/models/source_summary.dart';
import 'package:recase/recase.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/enums/consent_state.dart';
import 'package:mock_investigation_case/widgets/pipeline.dart';
import 'package:mock_investigation_case/widgets/kpi.dart';

(Color, Color) getPillBackgroundColorAndTextColor(ConsentState consentState) {
  if (ConsentState.collecting == consentState) {
    return (Color(0xFFEFF6FF), Color(0xFF1D4ED8));
  } else if (ConsentState.done == consentState) {
    return (Color(0xFFF0FDF4), Color(0xFF15803D));
  }
  return (Color(0xFFFFF7ED), Color(0xFF92400E));
}

class SourceExpansionTile extends StatefulWidget {
  final CollectionSource collectionSource;
  final int currentSelectedSourceId;
  final ValueChanged<int> onChangedSelectedSourceId;
  final SourceSummary? summary;

  const SourceExpansionTile({
    super.key,
    required this.collectionSource,
    required this.currentSelectedSourceId,
    required this.onChangedSelectedSourceId,
    required this.summary,
  });

  @override

  State<SourceExpansionTile> createState() => _SourceExpansionTileState();
}

class _SourceExpansionTileState extends State<SourceExpansionTile> {
  final ExpansibleController _controller = ExpansibleController();

  bool get _isSelected =>
      widget.currentSelectedSourceId == widget.collectionSource.id;

  @override

  void didUpdateWidget(covariant SourceExpansionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    final wasSelected =
        oldWidget.currentSelectedSourceId == oldWidget.collectionSource.id;
    if (_isSelected && !wasSelected) {
      _controller.expand();
    } else if (!_isSelected && wasSelected) {
      _controller.collapse();
    }
  }

  String mapLogoPath(String path) {
    return path.replaceAll(
      '/logos',
      'assets/icons/collection_logo',
    );
  }

  @override
  
  Widget build(BuildContext context) {


    final (backgroundColor, textColor) =
        getPillBackgroundColorAndTextColor(widget.collectionSource.consentState);
    final isSelected = _isSelected;

    return ExpansionTile(
      controller: _controller,
      initiallyExpanded: isSelected,
      shape: const Border(),
      showTrailingIcon: false,
      backgroundColor: isSelected ? BrandingColor.blue50 : null,
      onExpansionChanged: (expanded) {
        if (expanded) {
          widget.onChangedSelectedSourceId(widget.collectionSource.id);
        }
      },
      leading: Container(
        width: 30,
        height: 15,
        decoration: BoxDecoration(
          image: widget.collectionSource.logo != null
              ? DecorationImage(
                  image: AssetImage(mapLogoPath(widget.collectionSource.logo!)),
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
                widget.collectionSource.name.toString(),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.collectionSource.id.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 9, color: BrandingColor.grey2),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.collectionSource.subject.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 9, color: BrandingColor.grey2),
                  ),
                ],
              ),
            ],
          ),
          Chip(
            side: BorderSide.none, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(0.2),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            backgroundColor: backgroundColor,
            label: Text(
              widget.collectionSource.consentState.name.toString().titleCase,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: textColor
              )
            ),
          )
        ],
      ),
      children: [
        Pipeline(
          pipelineProgress: widget.collectionSource.consentState.toString(),
          name: widget.collectionSource.tribeType.toString()
          ),
        SizedBox(height: 50,),
        KPIValues(
          source: widget.collectionSource,
          summary: widget.summary,
          ),
      ],
    );
  }
}