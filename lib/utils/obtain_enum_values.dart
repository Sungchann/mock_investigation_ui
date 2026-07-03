T obtainEnumValue<T extends Enum>(List<T> values, String data) {
  return values.firstWhere(
    (e) => e.name == data,
    orElse: () => values.first, 
  );
}