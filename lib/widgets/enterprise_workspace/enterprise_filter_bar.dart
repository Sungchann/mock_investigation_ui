import 'package:flutter/material.dart'; 

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
    return Text("hello world");
  }


}