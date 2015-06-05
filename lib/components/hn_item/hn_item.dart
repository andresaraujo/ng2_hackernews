library hacker_news.components.hnitem;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart' show Router, RouterLink;
import 'package:timeago/timeago.dart';
import '../../services/hn_api.dart';
import '../../decorators/parse_html/parse_html.dart';

const itemMap = const {'comment': 1, 'job': 2, 'poll': 3, 'story': 4};
final fuzzyTime = new TimeAgo();

@Component(
    selector: 'hn-item',
    appInjector: const [HNApi],
    properties: const ['newItemId: item-id', 'newLoadChildren : loadChildren', 'newTopLevel : topLevel'])
@View(
    templateUrl: 'packages/ng2_hackernews/components/hn_item/hn_item.html',
    directives: const [
  NgFor,
  NgIf,
  NgSwitch,
  NgSwitchWhen,
  NgSwitchDefault,
  HNItem,
  ParseHtml,
  RouterLink
])
class HNItem {
  HNApi hnApi;
  Router router;
  bool loadChildren = true;
  bool topLevel = false;
  String itemId;
  var data;
  bool collapsed = false;
  int type = 0;
  String timeAgo;

  HNItem(this.hnApi, this.router);

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
    //TODO: switch to router-link, <a href="item" router-link="item" [router-params]="{ 'id': data['id']}">link</a>
    return "index.html?itemId=${id}";
  }
}
