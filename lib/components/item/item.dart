library hacker_news.components.item;

import 'package:angular2/angular2.dart';
import '../../services/hn_api.dart';
import '../../services/router.dart' as r;
import '../hn_item/hn_item.dart';

@Component(selector: 'page-item', viewInjector: const [HNApi])
@View(
    templateUrl: 'package:ng2_hackernews/components/item/item.html',
    directives: const [NgFor, HNItem])
class ItemPage {
  HNApi api;
  List<String> childrenIds = [];
  String itemId;

  ItemPage(this.api, r.Router router) {
    itemId =
        router.itemId; // TODO: switch to routeParams.get('id'); when router work
    _fetchItem();
  }
  _fetchItem() async {
    var data = await api.fetchItem(itemId);
    if (data != null) {
      childrenIds = data['kids'];
    }
  }
}
