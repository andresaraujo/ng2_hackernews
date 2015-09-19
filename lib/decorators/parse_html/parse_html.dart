library hacker_news.decorators.parse_html;

import 'dart:html' as dom;
import 'package:angular2/angular2.dart'
    show Directive, ElementRef, LifecycleEvent;
import 'package:html/parser.dart' show parse;

@Directive(
    selector: '[parsehtml]', lifecycle: const [LifecycleEvent.AfterContentInit])
class ParseHtml {
  ElementRef ref;

  ParseHtml(this.ref);

  afterContentInit() {
    dom.Element element = ref.nativeElement;
    String raw = element.text;
    element.text = "";
    element.setInnerHtml(parse(raw).outerHtml);
  }
}
