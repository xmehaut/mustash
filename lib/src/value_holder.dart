
import 'package:flutter/material.dart';

// A ValueHolder is simply a wrapper around a value.
// Its goal is to be shared between many widgets in a widget tree
// and to handle life-cycle functions like subscribing, notifying widgets of value changes,
// dispose the valueholder once the widget is itself disposed.
//
// To create a valueholder, do simply this :
//
//      var aValueHolder = ValueHolder<int>(0);
//
// It creates in this exemple a valueholder around an int value which
// is itself initialzed to 0;

// To access the internal value, we just have to do :
// var aValue = aValueHolder.value ;
// aValueHolder.value = aValue;

// The ValueHolder class may be subclassed when the internal value is for instance an object instead of terminal value.
// This subclass may be named a Controller and implement other methods than value and value()
// ex:
// class MyObject {
//   int counter;
// }
//
// class Controller extends ValueHolder<MyObject> {
//    void increment() {
//      value.counter+=1;
//      _updateListeners();
//    }
//
//    int get count => value.counter;
// }

class ValueHolder<T> {
  ValueHolder(T initValue) {
    dependents = List<State>();
    _data = initValue;
  }

  List<State> dependents;
  T _data;

  T get data => _data;

  void set data(T aValue) {
    _data = aValue;
    _updateListeners();
  }

  _updateListeners() {
    dependents.forEach((state) {
      state.setState(() {});
    });
  }

  addListener(State aState) {
    dependents.add(aState);
  }

  dispose(State aState) {
    dependents.remove(aState);
  }
}