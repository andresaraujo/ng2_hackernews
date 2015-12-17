library hacker_news.components.home;

import 'package:angular2/angular2.dart' show Component, NgFor, View;
import 'package:ng2_hackernews/components/hn_item/hn_item.dart' show HNItem;
import 'package:ng2_hackernews/services/hn_api.dart' show HNApi;

@Component(selector: 'home-page', viewProviders: const [HNApi])
@View(
    templateUrl: "package:ng2_hackernews/components/home/home.html",
    directives: const [NgFor, HNItem])
class Home {
  HNApi api;
  Iterable<Map<String, dynamic>> topStories = [];
  Home(this.api) {
    api.fetchTopStories().then((Iterable<Map<String, dynamic>> value) => this.topStories = value);
  }
}
