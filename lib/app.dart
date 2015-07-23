library ng2_hackernews.app;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:ng2_hackernews/components/home/home.dart';
import 'package:ng2_hackernews/components/item/item.dart';
import 'package:ng2_hackernews/components/user_page/user_page.dart';

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
  App(this.router) {
    //rr.navigate('/item/9511504');
    //rr.navigate('home');
  }
}
