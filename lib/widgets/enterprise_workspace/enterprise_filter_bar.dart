import 'package:flutter/material.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:recase/recase.dart'; 

class EnterpriseFilterBar extends StatelessWidget{ 
  final String currentSelectedStatus;
  final ValueChanged<String> onChangedSelectedStatus;

  final List<String> domainFilters; 
  final String currentSelectedDomain;
  final ValueChanged<String> onChangedSelectedDomain;

  final String currentSearchQuery;
  final ValueChanged<String> onSearchChanged;

  const EnterpriseFilterBar({
    super.key, 
    required this.currentSelectedStatus,
    required this.onChangedSelectedStatus,

    required this.domainFilters,
    required this.currentSelectedDomain, 
    required this.onChangedSelectedDomain,

    required this.currentSearchQuery,
    required this.onSearchChanged,
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
        _statusFilterChip(context, 'error', currentSelectedStatus),
        const SizedBox(width: 8),
        _searchBar(context),
        const SizedBox(width: 8),
        _domainDropdownChip(context, currentSelectedDomain),
      ],
    );
  }

  Widget _statusFilterChip(BuildContext context, String label, String currentSelectedFilter){
    final bool selected = label.toLowerCase() == currentSelectedFilter;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: (){
        onChangedSelectedStatus(label);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? BrandingColor.blue700 : BrandingColor.blue100.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0D000000),
                offset: Offset(0, 0),
                blurRadius: 10.0),
          ],
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

  Widget _domainDropdownChip(BuildContext context, String label){ 
    return PopupMenuButton<String>(
      color: Colors.white, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
        // side: BorderSide(
        //   color: BrandingColor.blue300,
        //   width: 1
        // )
      ), 
      onSelected: (String value){
        onChangedSelectedDomain(value); 
      },
      itemBuilder: (context) => [
        ...domainFilters.map((domain) => PopupMenuItem<String>(
            value: domain,
            child: Text( domain, 
              style: TextStyle(
                fontSize: 12,
              )
            )
        ))
      ],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        width: 250,
        decoration: BoxDecoration(
            border: Border.all(
              color: BrandingColor.blue300,
              width: 1
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x0D000000),
                  offset: Offset(0, 0),
                  blurRadius: 10.0),
            ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: BrandingColor.blue700
                  ),
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_drop_down, color: BrandingColor.blue700)
          ],
        ),
      )
    );
  }


  Widget _searchBar(BuildContext context){
    return Container(
      width: 500,
      color: Colors.white,
      child: TextField(
        onChanged: (value){
          onSearchChanged(value);
        },
        style: TextStyle(
          fontSize: 11,
        ),
        decoration: InputDecoration(
          hintText: 'Search by name/email',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 11,
          ),

          prefixIcon: const Icon(
            Icons.search, 
            size: 18,
          ),
          
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: BrandingColor.blue300,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: BrandingColor.blue300,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}