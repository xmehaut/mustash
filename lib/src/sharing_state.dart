import 'package:mustash/mustash.dart';
import 'package:flutter/material.dart';

abstract class SharingState<T extends StatefulWidget> extends State<T> {
  List<ValueHolder> valueHolders = [];

  void subscribeTo(ValueHolder aValueHolder) {
    if (valueHolders.contains(aValueHolder))
      return ;
    valueHolders.add(aValueHolder);
    aValueHolder.addListener(this);
  }

  @override
  void dispose() {
    valueHolders.forEach((aValueHolder) {
      aValueHolder.dispose(this);
      valueHolders.remove(aValueHolder);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  void didChangeDependencies() {}
}