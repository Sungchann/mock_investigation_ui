import 'package:intl/intl.dart';

String fmtCount(int value) {
  return NumberFormat.decimalPattern('da_DK').format(value);
}