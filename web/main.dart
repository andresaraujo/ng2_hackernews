// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular2/di.dart';
import 'package:angular2/router.dart';

// These imports will go away soon:
import 'package:angular2/src/reflection/reflection.dart' show reflector;
import 'package:angular2/src/reflection/reflection_capabilities.dart'
    show ReflectionCapabilities;

import 'package:ng2_hackernews/ng2_hackernews.dart';

main() {

  // Temporarily needed.
  reflector.reflectionCapabilities = new ReflectionCapabilities();

  bootstrap(App, [ bind(UrlResolver).toClass(DartUrlResolver), routerInjectables, bind(appBaseHrefToken).toValue('/my/app') ]);
}


//This is temporary, to enable package: URLs
// see: https://github.com/angular/angular/issues/2945#issuecomment-119761570
@Injectable()
class DartUrlResolver implements UrlResolver {
  static final _baseUrlResolver = new UrlResolver();

  final String urlPrefix;

  const DartUrlResolver() : urlPrefix = '';

  const DartUrlResolver.withUrlPrefix(this.urlPrefix);

  @override
  String resolve(String baseUrl, String url) {
    // Delegate to Angular to get a final URL.
    final angularResolvedUrl = _baseUrlResolver.resolve(baseUrl, url);

    // If this is a 'package:' style URL, replace with a pub-resolvable one.
    return angularResolvedUrl.replaceFirst('package:', '${urlPrefix}packages/');
  }
}