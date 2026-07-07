String fmtBytes(num bytes) {
  if (bytes == 0) return '0 B';
  if (bytes >= 1_000_000_000) {
    return '${(bytes / 1_000_000_000).toStringAsFixed(1)} GB';
  }
  if (bytes >= 1_000_000) {
    return '${(bytes / 1_000_000).toStringAsFixed(1)} MB';
  }
  if (bytes >= 1_000) {
    return '${(bytes / 1_000).toStringAsFixed(1)} KB';
  }
  return '${bytes.toInt()} B';
}