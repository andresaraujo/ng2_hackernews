library ng2_hackernews.app;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'services/router.dart' as r;
import 'components/home/home.dart';
import 'components/item/item.dart';
import 'components/user_page/user_page.dart';

@Component(selector: 'app', viewInjector: const [r.Router])
@View(
    templateUrl: 'packages/ng2_hackernews/app.html',
    directives: const [NgIf, NgFor, RouterOutlet, UserPage, ItemPage, Home])
@RouteConfig(const [
  const {'path': '/user/:id', 'component': UserPage, 'as': 'user'},
  const {'path': '/item/:id', 'component': ItemPage, 'as': 'item'},
  const {'path': '/home', 'component': Home, 'as': 'home'},
  const {'path': '/', 'redirectTo': 'home'}
])
class App {
  r.Router router;
  Router rr;
  App(this.router, this.rr) {
    //rr.navigate('/item/9511504');
    //rr.navigate('home');
  }
}
