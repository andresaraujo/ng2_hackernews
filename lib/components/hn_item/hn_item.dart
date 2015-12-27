library hacker_news.components.hnitem;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:ng2_hackernews/directives/parse_html/parse_html.dart'
    show ParseHtml;
import 'package:ng2_hackernews/pipes/domain_pipe.dart' show DomainPipe;
import 'package:ng2_hackernews/services/hn_api.dart' show HNApi;
import 'package:timeago/timeago.dart' show TimeAgo;

const itemMap = const {'comment': 1, 'job': 2, 'poll': 3, 'story': 4};
final fuzzyTime = new TimeAgo();

@Component(selector: 'hn-item')
@View(
    templateUrl: 'package:ng2_hackernews/components/hn_item/hn_item.html',
    directives: const [CORE_DIRECTIVES, HNItem, ParseHtml, RouterLink],
    pipes: const [DomainPipe])
class HNItem implements OnInit {
  HNApi _hnApi;
  String _itemId;

  @Input() bool loadChildren = true;
  @Input() bool topLevel = false;

  Map<String, dynamic> data;
  bool collapsed = false;
  int type = 0;
  String timeAgo;

  HNItem(this._hnApi);

  @Input('itemId')
  set newItemId(itemId) => _itemId = itemId.toString();

  ngOnInit() async {
    await _fetchData();
  }

  _fetchData() async {
    data = await _hnApi.fetchItem(_itemId);
    if (data != null) {
      type = itemMap[data['type']];
      timeAgo = fuzzyTime.timeAgo(data['time'] * 1000);
      data['type'] = data['type'] != null ? data['type'] : '';
    }
  }
}
