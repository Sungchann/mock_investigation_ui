
class CollectionAccount {
  final int id; 
  final String email; 
  final String status; 
  final int items; 
  final String added; 
  final String? error; 

  const CollectionAccount({
    required this.id,
    required this.email,
    required this.status,
    required this.items,
    required this.added,
    this.error
  });

  factory CollectionAccount.fromJson(Map<String, dynamic> json){
    return CollectionAccount(
      id: json['id'], 
      email: json['email'], 
      status: json['status'], 
      items: json['items'], 
      added: json['added']
    );
  }
}