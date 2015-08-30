library hacker_news.components.home;

import 'package:angular2/angular2.dart' show Component, NgFor, View;
import 'package:ng2_hackernews/services/hn_api.dart' show HNApi;
import 'package:ng2_hackernews/components/hn_item/hn_item.dart' show HNItem;

@Component(selector: 'home-page', viewBindings: const [HNApi])
@View(
    templateUrl: "package:ng2_hackernews/components/home/home.html",
    directives: const [NgFor, HNItem])
class Home {
  HNApi api;
  List topStories = [];
  Home(this.api) {
    api.fetchTopStories().then((value) => this.topStories = value);
  }
}
