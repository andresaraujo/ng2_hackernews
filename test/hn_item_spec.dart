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
        Provider,
        DebugElement,
        Directive;

import 'package:angular2/src/mock/mock_application_ref.dart';

import 'package:angular2/router.dart' show RouterLink;

import 'package:test/test.dart';
import 'package:angular2_testing/angular2_testing.dart';
import 'package:ng2_hackernews/components/hn_item/hn_item.dart';
import 'package:ng2_hackernews/services/hn_api.dart';
import 'dart:html' as dom;

@Injectable()
class MockHNApi implements HNApi {
  fetchItem(itemId) async {
    int time =
        (new DateTime.now().millisecondsSinceEpoch / 1000 - (15 * 60)).round();
    return <String, dynamic>{'type': 'comment', 'time': time, 'text': 'My dummy comment'};
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
  const MockHNApi();
}

void main() {
  initAngularTests();

  setUpProviders(() => [provide(HNApi, useClass: MockHNApi)]);

  group('HNItem Component', () {
    ngTest('should use mock hacker news api', (HNApi api) async {
      expect(api, new isInstanceOf<MockHNApi>());
    });

    group('When component is initialized', () {
      HNItem hnItem;
      dom.Element hnItemElement;

      ngSetUp((TestComponentBuilder tcb) async {
        Uri uri = new Uri.file(
            'packages/ng2_hackernews/components/hn_item/hn_item.html');
        String template = await dom.HttpRequest.getString(uri.toString());
        var rootTC = await tcb
            .overrideTemplate(HNItem, template)
            .overrideDirective(HNItem, RouterLink, Dummy)
            .createAsync(HNItem);

        hnItem = rootTC.debugElement.componentInstance;
        hnItemElement = rootTC.debugElement.nativeElement;
        await hnItem.ngOnInit();
        rootTC.detectChanges();
      });

      ngTest('should set data/timeago/type', () async {
        expect(hnItem.topLevel, equals(false));
        expect(hnItem.collapsed, equals(false));
        expect(hnItem.loadChildren, equals(true));
        expect(hnItem.timeAgo, equals('15 minutes ago'));
        expect(hnItem.type, equals(itemMap['comment']));

        expect(hnItemElement.querySelector('.hnItem--coment-content').text.trim(), equals('My dummy comment'));
      });


    });
  });
}

@Directive(selector: '[routerLink]')
class Dummy {}
