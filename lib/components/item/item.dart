library hacker_news.components.item;

import 'package:angular2/angular2.dart' show Component, NgFor, View;
import 'package:angular2/router.dart' show RouteParams;
import 'package:ng2_hackernews/services/hn_api.dart' show HNApi;
import 'package:ng2_hackernews/components/hn_item/hn_item.dart' show HNItem;

@Component(selector: 'page-item', viewBindings: const [HNApi])
@View(
    templateUrl: 'package:ng2_hackernews/components/item/item.html',
    directives: const [NgFor, HNItem])
class ItemPage {
  HNApi api;
  List<String> childrenIds = [];
  String itemId;

  ItemPage(this.api, RouteParams routeParams) {
    itemId = routeParams.get("id");
    _fetchItem();
  }
  _fetchItem() async {
    var data = await api.fetchItem("$itemId");
    if (data != null) {
      childrenIds = data['kids'];
    }
  }
}
