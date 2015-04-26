library hacker_news.components.user_page;

import 'package:angular2/angular2.dart';
import 'package:timeago/timeago.dart';
import '../hn_item/hn_item.dart';
import '../../services/hn_api.dart';
import '../../services/router.dart';

final fuzzyTime = new TimeAgo();
int currentTime = new DateTime.now().millisecondsSinceEpoch;

@Component(selector: 'page-user', injectables: const [HNApi])
@View(
    templateUrl: 'packages/ng2_hackernews/components/user_page/user_page.html',
    directives: const [For, If, HNItem])
class UserPage {
  HNApi api;
  bool showSubmissions;
  var data = {};
  String timeAgo;

  UserPage(this.api, Router router) {
    _fetchUser(router.userId);
    this.showSubmissions = false;
  }
  _fetchUser(String userId) async {
    data = await api.fetchUser(userId) as Map;
    data['submitted'] = (data['submitted'] as List).take(30);
    timeAgo = fuzzyTime.timeAgo(currentTime - (currentTime - data['created'] * 1000));
  }
}
