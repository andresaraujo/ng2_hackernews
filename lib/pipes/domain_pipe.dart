import 'package:angular2/angular2.dart'
    show Pipe, PipeTransform, ChangeDetectorRef, Injectable;

/**
 * Transforms a string that represents the url to show only the domain.
 *
 * # Example
 *
 *  ```
 * @Component(
 *   selector: "domain-example"
 * )
 * @View(
 *   template: "domain: {{ 'http://www.google.com/accounts/recovery' | domain }}" // will be transformed to 'google.com',
 *   pipes: const [DomainPipe]
 * )
 * class DomainExample {
 * }
 *
 * ```
 */
@Pipe(name: 'domain')
@Injectable()
class DomainPipe implements PipeTransform {
  bool supports(dynamic str) {
    return str == null || str is String || str is List;
  }

  void onDestroy() {}
  String transform(String value, [List<dynamic> args = null]) {
    if (value == null || value.isEmpty) {
      return value;
    }
    return _parseDomain(value);
  }

  create(ChangeDetectorRef cdRef) {
    return this;
  }

  DomainPipe();
}

_parseDomain(String url) {
  url = url.replaceFirst(new RegExp(r'https?:\/\/(www.)?|www.'), '');
  if(url.contains('/')){
    var parts = url.split('/');
    url = parts[0];
  } else if (url.contains('?')) {
    var parts = url.split('?');
    url = parts[0];
  }
  return url;
}
