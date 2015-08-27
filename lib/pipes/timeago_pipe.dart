import 'package:angular2/angular2.dart' show Pipe, PipeTransform, ChangeDetectorRef;
import 'package:angular2/di.dart';
import 'package:timeago/timeago.dart';

final fuzzyTime = new TimeAgo();

/**
 * Transforms a string date in milliseconds to a fuzzy time. ie. "15 mins ago"
 *
 * # Example
 *
 *  ```
 * @Component(
 *   selector: "timeago-example"
 * )
 * @View(
 *   template: "posted: {{ time | timeago }}",
 *   pipes: const [TimeAgoPipe]
 * )
 * class TimeAgoExample {
 *   String millisStr = "${new DateTime.now().millisecondsSinceEpoch - (15 * 60 * 1000)}";
 * }
 *
 * ```
 */
@Pipe(name: 'timeago')
@Injectable()
class TimeAgoPipe implements PipeTransform {
  String _latestValue = null;
  String _latestResult = null;
  bool supports(dynamic str) {
    return str is String;
  }
  void onDestroy() {
    _latestValue = null;
    _latestResult = null;
  }
  String transform(String value, [List<dynamic> args = null]) {
    if (this._latestValue != value) {
      _latestValue = value;
      _latestResult = fuzzyTime.timeAgo(num.parse(value));
      return _latestResult;
    } else {
      return _latestResult;
    }
  }
  Pipe create(ChangeDetectorRef cdRef) {
    return this;
  }
  TimeAgoPipe();
}