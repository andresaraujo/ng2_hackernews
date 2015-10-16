library hacker_news.services.hn_api;

import 'dart:async';
import 'package:firebase/firebase.dart';
import 'package:angular2/angular2.dart';

@Injectable()
class HNApi {
  final fb = new Firebase('https://hacker-news.firebaseio.com/v0/');

  Map userStore = {};
  Map itemStore = {};
  List topStories = [];

  Future<List> fetchTopStories() {
    return topStoriesRef().once('value').then((value) {
      topStories = (value.val() as List).take(10);
      return new Future.value(topStories);
    });
  }

  Future<List> fetchItems(List<String> items) {
    List<Future> promises = [];
    items.forEach((id) {
      promises.add(itemRef(id).onValue.first.then((value) {
        itemStore[id] = value.snapshot.val();
        return new Future.value(itemStore[id]);
      }));
    });

    return Future.wait(promises);
  }

  Future fetchItem(String item) {
    if (item == null) {
      return new Future.error("item should not be null");
    }
    return fetchItems([item]).then((data) => data[0]);
  }

  Future fetchUser(String userId) {
    if (userId == null || userId.isEmpty) {
      return new Future.error("user id should not be null");
    }

    return userRef(userId).onValue.first.then((value) {
      return new Future.value(value.snapshot.val());
    });
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
