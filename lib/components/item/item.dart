library hacker_news.components.item;

import 'package:angular2/angular2.dart';
import '../../services/hn_api.dart';
import '../../services/router.dart';
import '../hn_item/hn_item.dart';

@Component(selector: 'page-item', injectables: const [HNApi])
@View(
    templateUrl: 'packages/ng2_hackernews/components/item/item.html',
    directives: const [For, HNItem])
class ItemPage {
  HNApi api;
  List<String> childrenIds = [];
  String itemId;

  ItemPage(this.api, Router router) {
    itemId = router.itemId;
    _fetchItem();
  }
  _fetchItem() async {
    var data = await api.fetchItem(itemId);
    if (data != null) {
      childrenIds = data['kids'];
    }
  }
}
