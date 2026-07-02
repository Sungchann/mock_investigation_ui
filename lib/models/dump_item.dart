
class DumpItem {
  final int id;
  final String fileName;
  final int sizeBytes; 
  final String status; 
  final int progressPct; 
  final String remotePath; 
  final String? error;

  const DumpItem({
    required this.id,
    required this.fileName,
    required this.sizeBytes,
    required this.status,
    required this.progressPct,
    required this.remotePath,
    this.error
  }); 
  
  factory DumpItem.fromJson(Map<String, dynamic> json){
    return DumpItem(
      id: json['id'], 
      fileName: json['filename'], 
      sizeBytes: json['size_bytes'], 
      status: json['status'], 
      progressPct: json['progress_pct'], 
      remotePath: json['remote_path'],
      error: json['error']
    );
  }
}