
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 
import 'package:mock_investigation_case/models/source_summary.dart';
import 'package:mock_investigation_case/utils/fmt_bytes_coventer.dart';
import 'package:mock_investigation_case/utils/fmt_count_conveter.dart';
import 'package:recase/recase.dart';

class StatisticsTab extends StatelessWidget{
  final SourceSummary sourceSummary ;

  const StatisticsTab({
    super.key,
    required this.sourceSummary,
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: _statisticCard(
              context,
              'Users',
              fmtCount(sourceSummary.users).toString(),
              const Icon(
                Icons.people_alt_rounded,
                size: 36,
                color: Color(0xFF1440CD),
              ),
              // Image.asset(
              //   Assets.pNGIcUser2x,
              //   color: BrandingColor.blue700,
              // ),
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: _statisticCard(
              context,
              'Domains',
              fmtCount(sourceSummary.domains).toString(),
              const Icon(
                Icons.language,
                size: 36,
                color: Color(0xFF1440CD),
              ),
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: _statisticCard(
              context,
              'Emails',
              fmtCount(sourceSummary.emails).toString(),
              const Icon(
                Icons.mail_outline_rounded,
                size: 36,
                color: Color(0xFF1440CD),
              ),
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: _statisticCard(
              context,
              'Mail Size',
              fmtBytes(sourceSummary.mailSize).toString(),
              const Icon(
                Icons.mail_outline_rounded,
                size: 36,
                color: Color(0xFF1440CD),
              ),
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: _statisticCard(
              context,
              'Drive Files',
              fmtCount(sourceSummary.driveFiles).toString(),
              const FaIcon(
                FontAwesomeIcons.googleDrive,
                size: 34,
                color: Color(0xFF1440CD),
              ),
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: _statisticCard(
              context,
              'Drive Size',
              fmtBytes(sourceSummary.driveSize).toString(),
              const FaIcon(
                FontAwesomeIcons.googleDrive,
                size: 34,
                color: Color(0xFF1440CD),
              ),
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: _statisticCard(
              context,
              'SharePoint',
              fmtBytes(sourceSummary.sharepoint).toString(),
              const Icon(
                Icons.folder_shared_outlined,
                size: 36,
                color: Color(0xFF1440CD),
              ),
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: _statisticCard(
              context,
              'Finance',
              sourceSummary.finance.toString(),
              const Icon(
                Icons.description_outlined,
                size: 36,
                color: Color(0xFF1440CD),
              ),
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: _statisticCard(
              context,
              'Uploads',
              sourceSummary.uploads.toString(),
              const Icon(
                Icons.cloud_upload_outlined,
                size: 36,
                color: Color(0xFF1440CD),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

  Widget _statisticCard(BuildContext context, String title, String value, Widget asset){
    return Container(
      padding: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Color(0x0D000000),
              offset: Offset(0, 0),
              blurRadius: 15.0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.titleCase,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              asset,
              SizedBox(width: 8),
              Text(
                // value.toString().toLowerCase(), 
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22
                )
              )
            ],
          )
        ],
      ),
    );
  }