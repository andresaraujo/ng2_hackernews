library hacker_news.components.hnitem;

import 'package:angular2/angular2.dart';
import 'package:timeago/timeago.dart';
import '../../services/hn_api.dart';

const itemMap = const {'comment': 1, 'job': 2, 'poll': 3, 'story': 4};
final fuzzyTime = new TimeAgo();
int currentTime = new DateTime.now().millisecondsSinceEpoch;

@Component(
    selector: 'hn-item',
    injectables: const [HNApi],
    properties: const {
  'newItemId': 'item-id',
  'newLoadChildren': 'loadChildren',
  'newTopLevel': 'topLevel'
})
@View(
    templateUrl: 'packages/ng2_hackernews/components/hn_item/hn_item.html',
    directives: const [For, If, Switch, SwitchWhen, SwitchDefault])
class HNItem {
  HNApi hnApi;
  bool loadChildren = true;
  bool topLevel = false;
  String itemId;
  var data;
  bool collapsed = false;
  int type = 0;
  String timeAgo;

  HNItem(this.hnApi);

  set newItemId(itemId) {
    this.itemId = itemId.toString();
    this.fetchData();
  }

  set newLoadChildren(loadChildren) {
    this.loadChildren = loadChildren == true;
  }

  set newTopLevel(topLevel) {
    this.topLevel = topLevel == true;
  }

  fetchData() async {
    data = await hnApi.fetchItem(this.itemId);
    type = itemMap[data['type']];
    timeAgo = fuzzyTime.timeAgo(data['time'] * 1000);
  }

  domainPipe(String url) {
    if (url == null || url.isEmpty) {
      return '';
    }
    var domain = url.split('/')[2];
    return domain ? domain.replaceFirst('www.', '') : domain;
  }
  urlForUser(id) {
    return "index.html?userId=${id}";
  }
  urlForItem(id) {
    return "index.html?itemId=${id}";
  }
}
