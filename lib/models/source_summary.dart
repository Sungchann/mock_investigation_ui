
class SourceSummary {
  final int users; 
  final int domains;
  final int emails; 
  final int mailSize;
  final int driveFiles; 
  final int driveSize;
  final int sharepoint; 
  final int finance; 
  final int uploads;

  const SourceSummary({
    required this.users,
    required this.domains,
    required this.emails,
    required this.mailSize, 
    required this.driveFiles,
    required this.driveSize,
    required this.sharepoint,
    required this.finance,
    required this.uploads
  });


  factory SourceSummary.fromJson(Map<String, dynamic> json){
    return SourceSummary(
      users: json['users'], 
      domains: json['domains'], 
      emails: json['emails'], 
      mailSize: json['mail_size'], 
      driveFiles: json['drive_files'], 
      driveSize: json['drive_size'], 
      sharepoint: json['sharepoint'], 
      finance: json['finance'], 
      uploads: json['uploads'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'users': users,
      'domains': domains,
      'emails': emails,
      'mail_size': mailSize,
      'drive_files': driveFiles,
      'drive_size': driveSize,
      'sharepoint': sharepoint,
      'finance': finance,
      'uploads': uploads,
    };
  }

  Map<String, int> toMap() {
    return {
      'Users': users,
      'Domains': domains,
      'Emails': emails,
      'Mail Size': mailSize,
      'Drive Files': driveFiles,
      'Drive Size': driveSize,
      'SharePoint': sharepoint,
      'Finance': finance,
      'Uploads': uploads,
    };
  }

}