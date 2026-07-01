
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
  
}