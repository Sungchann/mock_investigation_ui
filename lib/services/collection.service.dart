import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mock_investigation_case/core/data_discovery_lab_core/logger.dart';
import 'package:mock_investigation_case/models/collection_source.dart';
import 'package:mock_investigation_case/utils/parse_json_list.dart'; 

class CollectionService {
  final String API_BASE = "http://127.0.0.1:8000/api/v1"; 
  final String CASE_ID = "04fa2b76-a10f-4272-8328-a5a5121d15e7"; 

  Future<List<CollectionSource>> getCollectionSources() async {
    final response = await http.get(
      Uri.parse('$API_BASE/cases/$CASE_ID/sources')
    );
    
    if (response.body.isNotEmpty){
      logger.i('collection_service: fetching is done}');
      
      final Map<String, dynamic> json = jsonDecode(response.body); 
      final List<dynamic> data = json['data']; 
      
      final List<CollectionSource> sources = parseJsonList(data, CollectionSource.fromJson);
      return sources; 
    }
    
    throw Exception('Failed fetched data');
  }
}