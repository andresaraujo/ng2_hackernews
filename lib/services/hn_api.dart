library hacker_news.services.hn_api;

import 'dart:async';
import 'package:firebase/firebase.dart';
import 'package:angular2/angular2.dart';

@Injectable()
class HNApi {
  final fb = new Firebase('https://hacker-news.firebaseio.com/v0/');

  Map userStore = {};
  Map itemStore = {};

  Future<Iterable<Map<String, dynamic>>> fetchTopStories() {
    return topStoriesRef().once('value')
        .then((DataSnapshot value) => (value.val() as Iterable<Map<String, dynamic>>).take(10));
  }

  Future<List> fetchItems(List<String> items) {
    List<Future> promises = [];
    items.forEach((String id) {
      promises.add(itemRef(id).onValue.first.then((value) {
        itemStore[id] = value.snapshot.val();
        return new Future.value(itemStore[id]);
      }));
    });

    return Future.wait(promises);
  }

  Future<Map<String, dynamic>> fetchItem(String item) {
    if (item == null) {
      return new Future.error("item should not be null");
    }
    return fetchItems([item]).then((List data) => data[0]) as Future<Map<String, dynamic>>;
  }

  Future<Map<String, dynamic>> fetchUser(String userId) {
    if (userId == null || userId.isEmpty) {
      return new Future.error("user id should not be null");
    }

    return userRef(userId).onValue.first.then((Event value) {
      return new Future.value(value.snapshot.val());
    }) as Future<Map<String, dynamic>>;
  }

  Firebase topStoriesRef() {
    return fb.child('topstories/');
  }

  Firebase itemRef(itemId) {
    return fb.child('item/' + itemId);
  }

  Firebase userRef(userId) {
    return fb.child('user/' + userId);
  }
}
