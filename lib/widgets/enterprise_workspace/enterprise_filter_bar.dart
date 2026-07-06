import 'package:flutter/material.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:recase/recase.dart'; 

class EnterpriseFilterBar extends StatelessWidget{ 
  final String currentSelectedStatus;
  final ValueChanged<String> onChangedSelectedStatus;

  const EnterpriseFilterBar({
    super.key, 
    required this.currentSelectedStatus,
    required this.onChangedSelectedStatus 
  }); 

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        _statusFilterChip(context, 'all', currentSelectedStatus),
        const SizedBox(width: 8),
        _statusFilterChip(context, 'collecting', currentSelectedStatus),
        const SizedBox(width: 8),
        _statusFilterChip(context, 'done', currentSelectedStatus),
        const SizedBox(width: 8),
        _statusFilterChip(context, 'error', currentSelectedStatus)
      ],
    );
  }

  Widget _statusFilterChip(BuildContext context, String label, String currentSelectedFilter){
    final bool selected = label.toLowerCase() == currentSelectedFilter;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: (){
        onChangedSelectedStatus(label.toLowerCase());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? BrandingColor.blue700 : BrandingColor.blue100.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(label.titleCase,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: selected ? Colors.white : BrandingColor.blue700
              ),
            )
          ],
        )
      ),
    );
  }
}