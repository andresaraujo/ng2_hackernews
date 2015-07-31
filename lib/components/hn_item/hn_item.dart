library hacker_news.components.hnitem;

import 'package:angular2/angular2.dart' show Component, View, LifecycleEvent, coreDirectives;
import 'package:angular2/router.dart' show routerDirectives;
import 'package:timeago/timeago.dart';
import 'package:ng2_hackernews/services/hn_api.dart';
import 'package:ng2_hackernews/decorators/parse_html/parse_html.dart';

const itemMap = const {'comment': 1, 'job': 2, 'poll': 3, 'story': 4};
final fuzzyTime = new TimeAgo();

@Component(
    selector: 'hn-item',
    viewBindings: const [HNApi],
    properties: const [
  'newItemId: item-id',
  'newLoadChildren : load-children',
  'newTopLevel : top-level'
],
    lifecycle: const [LifecycleEvent.onInit])
@View(
    templateUrl: 'package:ng2_hackernews/components/hn_item/hn_item.html',
    directives: const [
  coreDirectives,
  HNItem,
  ParseHtml,
  routerDirectives
])
class HNItem {
  HNApi _hnApi;
  String _itemId;

  bool loadChildren = true;
  bool topLevel = false;
  var data;
  bool collapsed = false;
  int type = 0;
  String timeAgo;

  HNItem(this._hnApi) {}

  onInit() {
    _fetchData();
  }

  set newItemId(itemId) {
    _itemId = itemId.toString();
  }

  set newLoadChildren(loadChildren) {
    this.loadChildren = loadChildren;
  }

  set newTopLevel(topLevel) {
    this.topLevel = topLevel;
  }

  _fetchData() async {
    data = await _hnApi.fetchItem(_itemId);
    if (data != null) {
      type = itemMap[data['type']];
      timeAgo = fuzzyTime.timeAgo(data['time'] * 1000);
      data['by'] = data['type'] != null ? data['type'] : '';
    }
  }
}
