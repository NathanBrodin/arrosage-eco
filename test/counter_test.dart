import 'package:arrosage_eco/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Counter value', () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });
}