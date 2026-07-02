
class LogEntry {
  final String time; 
  final String message;

  const LogEntry({
    required this.time,
    required this.message
  }); 
  

  factory LogEntry.fromJson(Map<String, dynamic> json){
    return LogEntry(
      time: json['t'], 
      message: json["msg"]
    );
  }
}