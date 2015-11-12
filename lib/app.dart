library ng2_hackernews.app;

import 'package:angular2/angular2.dart' show Component, NgFor, NgIf, View;
import 'package:angular2/router.dart'
    show Route, RouteConfig, Router, RouterOutlet;

import 'package:ng2_hackernews/components/home/home.dart' show Home;
import 'package:ng2_hackernews/components/item/item.dart' show ItemPage;
import 'package:ng2_hackernews/components/user_page/user_page.dart'
    show UserPage;

@Component(selector: 'app')
@View(
    templateUrl: 'package:ng2_hackernews/app.html',
    directives: const [NgIf, NgFor, RouterOutlet])
@RouteConfig(const [
  const Route(path: '/user/:id', component: UserPage, name: 'User'),
  const Route(path: '/item/:id', component: ItemPage, name: 'Item'),
  const Route(path: '/home', component: Home, name: 'Home'),
  const Route(path: '/', component: Home)
])
class App {
  Router _router;
  App(this._router);
  goHome() {
    _router.navigateByUrl("/home");
  }
}
