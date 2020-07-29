
import 'package:flutter/material.dart';

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
    print(_data);
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