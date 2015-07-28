import 'package:angular2/angular2.dart' show Pipe, PipeFactory, ChangeDetectorRef;
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
 *   template: "posted: {{ time | timeago }}"
 * )
 * class TimeAgoExample {
 *   String millisStr = "${new DateTime.now().millisecondsSinceEpoch - (15 * 60 * 1000)}";
 * }
 *
 * ```
 */
class TimeAgoPipe implements Pipe, PipeFactory {
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