
class FinanceRecord {
  final int id;
  final String type; 
  final int count; 
  final String range; 
  final String status; 

  const FinanceRecord({
    required this.id, 
    required this.type,
    required this.count, 
    required this.range,
    required this.status
  }); 
  
  factory FinanceRecord.fromJson(Map<String, dynamic> json){
    return FinanceRecord(
      id: json['id'], 
      type: json['type'], 
      count: json['count'], 
      range: json['range'], 
      status: json['status']
    );
  }
}