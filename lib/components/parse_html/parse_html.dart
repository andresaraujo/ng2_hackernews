library hacker_news.components.parse_html;

import 'dart:html' as dom;
import 'package:angular2/angular2.dart';
import 'package:html/parser.dart' show parse;

@Decorator(selector: '[parsehtml]', properties: const {'element': 'parsehtml'})
class ParseHtml {
  dom.Element _element;
  set element(dom.Element element) {
    _element = element;
    //element.style.color = "red";
    String raw = element.text;
    element.text = "";
    element.appendHtml(parse(raw).outerHtml);
  }
}
