import 'package:flutter/material.dart';
import 'package:mock_investigation_case/core/data_discovery_lab_core/theme.dart';
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:mock_investigation_case/models/dump_item.dart';
import 'package:mock_investigation_case/utils/fmt_bytes_coventer.dart';
import 'package:mock_investigation_case/widgets/logs.dart';
import 'package:recase/recase.dart';

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
        return _buildDumpUploadWorkspace(context);
      },
    );
  }

  Widget _buildDumpUploadWorkspace(BuildContext context){
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          dumpUploadCollectionSource.name.titleCase,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          dumpUploadCollectionSource.dumpPath,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (dumpUploadCollectionSource.dumpItems != null)
                          ...dumpUploadCollectionSource.dumpItems!.map((dumpItem) => (
                            _buildDumpItems(context, dumpItem)
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Logs(logs: dumpUploadCollectionSource.logs),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget _buildDumpItems(BuildContext conntext, DumpItem dumpItem){
    return Padding(
      padding: EdgeInsetsGeometry.only(top: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dumpItem.fileName,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  fmtBytes(dumpItem.sizeBytes), 
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            LinearProgressIndicator(
                value: dumpItem.progressPct.toDouble(),
                minHeight: 8,
                borderRadius: BorderRadius.circular(8),
                backgroundColor: BrandingColor.blue100,
                valueColor: AlwaysStoppedAnimation<Color>(BrandingColor.blue700),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              dumpItem.status.toLowerCase() == "pending" 
                ? "Queued"
                  : dumpItem.status.toLowerCase() == "transferring"
                    ? "Transferring"
                      : dumpItem.status.toLowerCase() == "done"
                        ? "Transferred"
                          : "Transfer failed",
              style: TextStyle(
                fontSize: 12
              ),
            )
          ],
        ),
      ),
    );
  }
}