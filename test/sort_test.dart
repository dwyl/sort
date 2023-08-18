import 'package:srt/srt.dart';
import 'package:test/test.dart';

void main() {
  test('Fetching sort', () async {
    final sortList = await Sort.get();
    expect(sortList.length, greaterThan(0));
    expect(sortList.first.id, 1);
  });
}
