import 'package:mustash/mustash.dart';
import 'package:flutter/material.dart';

// The abstact class SharingState is a subclass of the State class.
// It's goal is to simplify the life-cycle management of the ValueHolders
// by subscribing to   valueholders, aand to manage automatically the disposal of these ones
// when the widget itself is disposed.
// ex :
//      class MyState extends SharingState<MyWidget> {
//        build(BuildContext context) {
//            // we get the shared value holder
//            var counter = (MyApp.myhomepageKey.currentState).counter;
//            // the state component subscribe to the valueholder, i.e. it becomes a listener of the valueholder
//            subscribeTo(counter);
//            // we use the value holder
//             var val = counter.data;
//             return Text(
//                '$val',
//                 style: Theme.of(context).textTheme.headline4,
//              );
//        }
//      }

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