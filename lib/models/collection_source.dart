import 'package:mock_investigation_case/enums/consent_state.dart';
import 'package:mock_investigation_case/enums/tribe_type.dart';
import 'package:mock_investigation_case/models/collection_account.dart';
import 'package:mock_investigation_case/models/collection_user.dart';
import 'package:mock_investigation_case/models/dump_item.dart';
import 'package:mock_investigation_case/models/finance_record.dart';
import 'package:mock_investigation_case/models/log_entry.dart';
import 'package:mock_investigation_case/utils/obtain_enum_values.dart';
import 'package:mock_investigation_case/utils/parse_json_list.dart';

class CollectionSource {
  final int id; 
  final TribeType tribeType;
  final String providerKey; 
  final String name; 
  final String? logo; 
  final String subject; 
  final String domain; 
  final ConsentState consentState;
  
  // bools 
  final bool scopeMail; 
  final bool scopeDrive; 
  final bool scopeSp; 
  
  final int items;
  final String added;
  final String tenantId; 
  final String dateFrom; 
  final String dateTo;
  
  // imap
  final String imapHost; 
  final int imapPort; 
  
  final String dumpPath;
  final bool? dumpSimulated; 
  final List<DumpItem>? dumpItems; 
  final bool? discoveryLive; 
  final List<CollectionUser>? users;
  final List<CollectionAccount>? accounts; 
  final List<FinanceRecord>? financeRecords; 
  final List<LogEntry> logs;

  const CollectionSource({
    required this.id,
    required this.tribeType,
    required this.providerKey,
    required this.name,
    this.logo,
    required this.subject,
    required this.domain,
    required this.consentState,

    required this.scopeMail,
    required this.scopeDrive,
    required this.scopeSp,

    required this.items,
    required this.added,
    required this.tenantId,
    required this.dateFrom,
    required this.dateTo,

    required this.imapHost,
    required this.imapPort,

    required this.dumpPath,
    this.dumpSimulated,
    this.dumpItems,
    this.discoveryLive,
    this.users,
    this.accounts,
    this.financeRecords,
    required this.logs
  });

  factory CollectionSource.fromJson(Map<String, dynamic> json){
    return CollectionSource(
      id: json['id'] ?? '', 
      tribeType: obtainEnumValue(TribeType.values, json['tribe_id']), 
      providerKey: json['provider_key'], 
      name: json['name'], 
      logo: json['logo'],
      subject: json['subject'], 
      domain: json['domain'], 
      consentState: obtainEnumValue(ConsentState.values, json['consent_state']), 
      scopeMail: json['scope_mail'], 
      scopeDrive: json['scope_drive'], 
      scopeSp: json['scope_sp'], 
      items: json['items'], 
      added: json['added'], 
      tenantId: json['tenant_id'], 
      dateFrom: json['date_from'], 
      dateTo: json['date_to'], 
      imapHost: json['imap_host'], 
      imapPort: json['imap_port'], 
      dumpPath: json['dump_path'], 

      dumpSimulated: json["dump_simulated"],
      dumpItems: json["dump_items"] != null ? (parseJsonList(json["dump_items"], DumpItem.fromJson)) : null, 
      discoveryLive: json["discovery_line"], 
      users: json["users"] != null ? (parseJsonList(json['users'], CollectionUser.fromJson)) : null, 
      accounts: json["accounts"] != null ? (parseJsonList(json["accounts"], CollectionAccount.fromJson)) : null, 
      financeRecords: json["finance_records"] != null ? (parseJsonList(json['finance_records'], FinanceRecord.fromJson)) : null, 

      logs: parseJsonList(json["log"], LogEntry.fromJson),
    );
  }
}