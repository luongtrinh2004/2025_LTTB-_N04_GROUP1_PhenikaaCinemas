/// Format currency value: 123456 -> "123,456 đ"
String fmtCurrency(num v) {
  final s = v.toStringAsFixed(0);
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final revIndex = s.length - 1 - i;
    buf.write(s[i]);
    final left = s.length - i - 1;
    if (left > 0 && revIndex % 3 == 0) buf.write(',');
  }
  return '${buf.toString()} đ';
}