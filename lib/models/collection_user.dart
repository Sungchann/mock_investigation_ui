import 'package:mock_investigation_case/enums/status.dart';
import 'package:mock_investigation_case/utils/obtain_enum_values.dart'; 

class CollectionUser {
  final int id;
  final String name;
  final String email; 
  final String domain; 
  final Status status;  
  final String? error; 
  
  // bools 
  final bool collectMail; 
  final bool collectDrive;
  final bool collectSp; 
  final bool collectTeams;
  
  // disc means disocvered?
  final int discMail; 
  final int discMailSize;
  final int discDriveSize; 
  final int discSpSize; 
  final int discTeamsCh; 
  final int discTeamsCl; 
  
  final int emailItems; 
  final int emailSizeBytes; 
  final int driveFiles;
  final int driveSizeBytes; 
  final int spSizeBytes; 

  final int teamsChannelMsg;
  final int teamsCalls; 

  final bool mailCollected; 
  final bool driveCollected; 
  final bool spCollected; 
  final bool teamsCollected; 

  const CollectionUser({
    required this.id,
    required this.name,
    required this.email,
    required this.domain, 
    required this.status,
    this.error, 

    required this.collectMail,
    required this.collectDrive,
    required this.collectSp,
    required this.collectTeams,

    required this.discMail,
    required this.discMailSize, 
    required this.discDriveSize,
    required this.discSpSize,
    required this.discTeamsCh,
    required this.discTeamsCl, 

    required this.emailItems,
    required this.emailSizeBytes,
    required this.driveFiles, 
    required this.driveSizeBytes,
    required this.spSizeBytes, 

    required this.teamsChannelMsg,
    required this.teamsCalls,

    required this.mailCollected,
    required this.driveCollected,
    required this.spCollected,
    required this.teamsCollected,
  }); 


  factory CollectionUser.fromJson(Map<String, dynamic> json){ 
    return CollectionUser(
      id: json['id'], 
      name: json['name'], 
      email: json['email'], 
      domain: json['domain'], 
      status: obtainEnumValue(Status.values, json["status"]), 
      error: json['error'],
      collectMail: json['collect_mail'], 
      collectDrive: json['collect_drive'], 
      collectSp: json['collect_sp'], 
      collectTeams: json['collect_teams'], 
      discMail: json['disc_mail'], 
      discMailSize: json['disc_mail_size'], 
      discDriveSize: json['disc_drive_sz'], 
      discSpSize: json['disc_sp_sz'], 
      discTeamsCh: json['disc_teams_ch'], 
      discTeamsCl: json['disc_teams_cl'], 
      emailItems: json['email_items'], 
      emailSizeBytes: json['email_size_bytes'], 
      driveFiles: json['drive_files'], 
      driveSizeBytes: json['drive_size_bytes'], 
      spSizeBytes: json['sp_size_bytes'], 
      teamsChannelMsg: json['teams_channel_msg'], 
      teamsCalls: json['teams_calls'], 
      mailCollected: json['mail_collected'], 
      driveCollected: json['drive_collected'], 
      spCollected: json['sp_collected'], 
      teamsCollected: json['teams_collected']
    );
  }
}
