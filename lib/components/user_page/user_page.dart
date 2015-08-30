library hacker_news.components.user_page;

import 'package:angular2/angular2.dart' show Component, NgFor, NgIf, View;
import 'package:angular2/router.dart' show RouteParams;
import 'package:timeago/timeago.dart' show TimeAgo;
import 'package:ng2_hackernews/components/hn_item/hn_item.dart' show HNItem;
import 'package:ng2_hackernews/decorators/parse_html/parse_html.dart'
    show ParseHtml;
import 'package:ng2_hackernews/services/hn_api.dart' show HNApi;

final fuzzyTime = new TimeAgo();

@Component(selector: 'page-user', viewBindings: const [HNApi])
@View(
    templateUrl: 'package:ng2_hackernews/components/user_page/user_page.html',
    directives: const [NgFor, NgIf, HNItem, ParseHtml])
class UserPage {
  HNApi api;
  bool showSubmissions;
  var data = {};
  String timeAgo;

  UserPage(this.api, RouteParams routeParams) {
    _fetchUser(routeParams.get("id"));
    this.showSubmissions = false;
  }
  _fetchUser(String userId) async {
    data = await api.fetchUser(userId) as Map;
    data['submitted'] = (data['submitted'] as List).take(30);
    timeAgo = fuzzyTime.timeAgo(data['created'] * 1000);
  }
}
