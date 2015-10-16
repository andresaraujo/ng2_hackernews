// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart' show provide;
import 'package:angular2/bootstrap.dart' show bootstrap;
import 'package:angular2/router.dart' show APP_BASE_HREF, HashLocationStrategy, LocationStrategy, ROUTER_PROVIDERS;

import 'package:ng2_hackernews/ng2_hackernews.dart' show App;

main() {

  bootstrap(App, [
    ROUTER_PROVIDERS,
    provide(APP_BASE_HREF, useValue: '/'),
    provide(LocationStrategy, useClass: HashLocationStrategy)
  ]);
}