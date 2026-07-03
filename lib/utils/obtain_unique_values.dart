List<T> obtainUniqueValuesFromList<T>(List<T> list){
  return list.toSet().toList();
}