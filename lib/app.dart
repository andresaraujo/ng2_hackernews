library ng2_hackernews.app;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'services/router.dart' as r;
import 'components/home/home.dart';
import 'components/item/item.dart';
import 'components/user_page/user_page.dart';

@Component(selector: 'app', injectables: const [r.Router])
@View(
    templateUrl: 'packages/ng2_hackernews/app.html',
    directives: const [If, For, RouterOutlet, UserPage, ItemPage, Home])
@RouteConfig(const [
  const {'path' : '/user/:id', 'component' : UserPage, 'alias': 'user'},
  const {'path' : '/item/:id', 'component' : ItemPage, 'alias': 'item'},
  const {'path' : '/home', 'component' : Home},
  const {'path' : '/', 'redirectTo' : '/home'}
])
class App {
  r.Router router;
  Router rr;
  App(this.router, this.rr) {
    //rr.navigate('/item/9511504');
    //rr.navigate('/home');
  }
}
