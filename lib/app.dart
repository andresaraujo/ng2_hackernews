library ng2_hackernews.app;

import 'package:angular2/angular2.dart';

import 'services/router.dart';
import 'components/home/home.dart';
import 'components/item/item.dart';
import 'components/user_page/user_page.dart';

@Component(selector: 'app', injectables: const [Router])
@View(
    templateUrl: 'packages/ng2_hackernews/app.html',
    directives: const [If, For, Home, ItemPage, UserPage])
class App {
  Router router;
  App(this.router);
}
