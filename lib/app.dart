library ng2_hackernews.app;

import 'package:angular2/angular2.dart' show Component, NgFor, NgIf, View;
import 'package:angular2/router.dart' show Route, RouteConfig, Router, RouterOutlet;

import 'package:ng2_hackernews/components/home/home.dart' show Home;
import 'package:ng2_hackernews/components/item/item.dart' show ItemPage;
import 'package:ng2_hackernews/components/user_page/user_page.dart' show UserPage;

@Component(selector: 'app')
@View(
    templateUrl: 'package:ng2_hackernews/app.html',
    directives: const [NgIf, NgFor, RouterOutlet])
@RouteConfig(const [
  const Route(path: '/user/:id', component: UserPage, as: 'user'),
  const Route(path: '/item/:id', component: ItemPage, as: 'item'),
  const Route(path: '/home', component: Home, as: 'home'),
  const Route(path: '/', component: Home)
])
class App {
  Router router;
  App(this.router);
  goHome() {
    router.navigate("/home");
  }
}
