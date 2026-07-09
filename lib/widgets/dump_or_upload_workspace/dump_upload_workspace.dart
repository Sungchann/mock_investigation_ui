import 'package:flutter/material.dart';
import 'package:mock_investigation_case/models/collection_source.dart';

class DumpUploadWorkspace extends StatelessWidget{
  final CollectionSource dumpUploadCollectionSource; 

  const DumpUploadWorkspace({
    super.key,
    required this.dumpUploadCollectionSource
  });

  @override
  Widget build(BuildContext context){
    return Builder(
      builder: (context){
        if (dumpUploadCollectionSource.domain.isEmpty){
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x0D000000),
                    offset: Offset(0, 0),
                    blurRadius: 10.0),
              ],
            ),
            child: Center(
              child: Text("Collection Source (Domain: Personal) is empty"),
            ),
          );
        }
        return Text("dsada");
      },
    );
  }
}