import 'package:test/test.dart';
import 'package:ng2_hackernews/pipes/domain_pipe.dart';

main () {
  DomainPipe pipe;
  setUp(() async {
    pipe = new DomainPipe();
  });

  group('DomainPipe', () {
    test('Should return correct domain for url', () {
      expect(pipe.transform('www.google.com/asd'), equals('google.com'));
      expect(pipe.transform('http://www.google.com/asd'), equals('google.com'));
      expect(pipe.transform('https://www.google.com/asd'), equals('google.com'));
      expect(pipe.transform('http://www.google.com?asd=qwe'), equals('google.com'));
    });
  });
}