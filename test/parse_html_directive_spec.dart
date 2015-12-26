// Because Angular is using dart:html, we need these tests to run on an actual
// browser. This means that it should be run with `-p dartium` or `-p chrome`.
@TestOn('browser')
import 'package:angular2/angular2.dart'
    show
        Component,
        View,
        NgFor,
        provide,
        Inject,
        Injectable,
        Optional,
        Provider;

import 'package:test/test.dart';
import 'package:angular2_testing/angular2_testing.dart';
import 'package:ng2_hackernews/directives/parse_html/parse_html.dart';

// This is the component we will be testing.
@Component(selector: 'test-cmp')
@View(directives: const [ParseHtml])
class TestComponent {
  String raw;
  TestComponent() {
    this.raw = "<b>Dummy<br>Dummy2</b>";
  }
}

const TEMPLATE = '<div><span parsehtml>{{raw}}</span></div>';

void main() {
  initAngularTests();

  ngTest('should parse a raw html string', (TestComponentBuilder tcb) async {
    var rootTC = await tcb
        .overrideTemplate(TestComponent, TEMPLATE)
        .createAsync(TestComponent);

    rootTC.detectChanges();
    expect(rootTC.debugElement.nativeElement.text, equals('DummyDummy2'));
  });
}
