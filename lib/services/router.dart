library hacker_news.services.router;

import 'dart:html' as html;

class Router {
  Map queryObj = {};
  String itemId;
  String userId;
  Router() {
    queryObj = _parseQueryString();

    this.itemId = this.queryObj['itemId'];
    this.userId = this.queryObj['userId'];
  }

  Map _parseQueryString() {
    var parsed = {};

    if (html.window.location.search.isEmpty) return parsed;

    var query = html.window.location.search.substring(1);
    query.split('&').forEach((val) {
      var pair = val.split('=');
      parsed[Uri.decodeComponent(pair[0])] = Uri.decodeComponent(pair[1]);
    });

    return parsed;
  }
}
