import 'package:flutter/material.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/models/collection_source.dart'; 
import 'package:mock_investigation_case/widgets/source_expansion_tile.dart';

class TribeExpansionTile extends StatefulWidget{
  final String tribeName; 
  final List<CollectionSource> collectionSources; 
  final int currentSelectedSourceId; 
  final ValueChanged<int> onChangedSelectedSourceId; 

  const TribeExpansionTile({
    super.key, 
    required this.tribeName,
    required this.collectionSources,
    required this.currentSelectedSourceId, 
    required this.onChangedSelectedSourceId
  });

  @override
  State<TribeExpansionTile> createState() => _TribeExpansionTileState();

}
class _TribeExpansionTileState extends State<TribeExpansionTile>{ 
  final ExpansibleController _controller = ExpansibleController();

  bool get _isSelected => widget.collectionSources
      .any((source) => source.id == widget.currentSelectedSourceId);
  
  @override
  void didUpdateWidget(covariant TribeExpansionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    final wasSelected = oldWidget.collectionSources
        .any((source) => source.id == oldWidget.currentSelectedSourceId);
    if (_isSelected && !wasSelected) {
      _controller.expand();
    } else if (!_isSelected && wasSelected) {
      _controller.collapse();
    }
  }
  
  @override
  Widget build(BuildContext context){
    return ExpansionTile(
      controller: _controller,
      initiallyExpanded: _isSelected,
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
            widget.tribeName,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12
            )
          ),
          Row(
            children: [
              // Container(
              //   width: 20,
              //   decoration: BoxDecoration(
              //   color: Colors.grey.shade200,
              //   borderRadius: BorderRadius.circular(100)
              //   ),
              //   child: Center(
              //     child: Text(
              //       widget.collectionSources.length.toString(),
              //       style: TextStyle(
              //         fontSize: 12,
              //         fontWeight: FontWeight.w700,
              //       )
              //     ),
              //   ) 
              // ),
              Chip(
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
                backgroundColor: BrandingColor.grey4,
                label: Text(
                  widget.collectionSources.length.toString(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700
                  ),
                ),
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
        ...widget.collectionSources.map((source) => (
          SourceExpansionTile(
            collectionSource: source,
            currentSelectedSourceId: widget.currentSelectedSourceId,
            onChangedSelectedSourceId: widget.onChangedSelectedSourceId
          )
        ))
      ],
    );
  }
}