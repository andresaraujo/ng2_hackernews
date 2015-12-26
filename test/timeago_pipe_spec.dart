import 'package:test/test.dart';
import 'package:ng2_hackernews/pipes/timeago_pipe.dart';

main () {
  TimeAgoPipe pipe;
  setUp(() async {
    pipe = new TimeAgoPipe();
  });

  group('DomainPipe', () {
    test('Should return correct domain for url', () {
      int time = new DateTime.now().millisecondsSinceEpoch - (15 * 60 * 1000);
      expect(pipe.transform('$time'), equals('15 minutes ago'));
    });
  });
}