import 'package:mock_investigation_case/enums/status.dart'; 

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
  
}
