library hacker_news.decorators.parse_html;

import 'dart:html' as dom;

import 'package:angular2/angular2.dart'
    show Directive, ElementRef, AfterContentInit;
import 'package:html/parser.dart' show parse;

@Directive(
    selector: '[parsehtml]')
class ParseHtml implements AfterContentInit {
  ElementRef ref;

  ParseHtml(this.ref);

  ngAfterContentInit() {
    dom.Element element = ref.nativeElement;
    String raw = element.text;
    element.text = "";
    element.setInnerHtml(parse(raw).outerHtml);
  }
}
