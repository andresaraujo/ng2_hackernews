library hacker_news.components.home;

import 'package:angular2/angular2.dart';
import '../../services/hn_api.dart';
import '../hn_item/hn_item.dart';

@Component(selector: 'home-page', viewInjector: const [HNApi])
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
