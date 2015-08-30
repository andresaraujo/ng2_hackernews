import 'package:angular2/angular2.dart' show Pipe, PipeTransform, ChangeDetectorRef;
import 'package:angular2/di.dart' show Injectable;

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
    if (value.isEmpty) {
      return value;
    }
    List<String> parts = value.split('/');
    if(parts.length < 2) {
      return value;
    }
    return parts[2].replaceFirst('www.', '');
  }
  Pipe create(ChangeDetectorRef cdRef) {
    return this;
  }
  DomainPipe();
}