
import 'package:flutter/material.dart';
import 'package:mustash/mustash.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This global key will be used to get the valueholders in the WidgetStates
  static GlobalKey<MyHomePageState> myhomepageKey;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    myhomepageKey = GlobalKey<MyHomePageState>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(key: myhomepageKey, title: 'Flutter Demo Home Page'),
    );
  }
}

//////////////////////////////////////////////////:
// This Widget is the main page and contains mainly two parts :
// - a text widget showing the contents of a valueholder
// - a button chaning the contents of the shared valueholder

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final MyHomePageState myState = MyHomePageState();

  @override
  MyHomePageState createState() => myState;
}

class MyHomePageState extends State<MyHomePage> {
  // we create the shared value holder and we initialize it directly
  ValueHolder<int> counter = ValueHolder<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            CountDisplayer(),
          ],
        ),
      ),
      floatingActionButton: ActionButton(),
    );
  }
}

//////////////////////////////////////////////////:
// this widget is a statefull widget using the shared valueholder defined upper
// it displays the counter value
class CountDisplayer extends StatefulWidget {
  const CountDisplayer({Key key}) : super(key: key);

  @override
  CountDisplayerState createState() => CountDisplayerState();
}

// the State is subclass of SharingState instead of State
// SharingState manage the life cycle of the states, including the valueholder ones
class CountDisplayerState extends SharingState<CountDisplayer> {

  @override
  Widget build(BuildContext context) {
    // we get the shared value holder
    var counter = (MyApp.myhomepageKey.currentState).counter;
    // the state component subscribe to the valueholder, i.e. it becomes a listener of the valueholder
    subscribeTo(counter);
    // we use the value holder
    var val = counter.data;
    return Text(
      '$val',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

//////////////////////////////////////////////////:
// The action button increment the value of the valueholder and notify all
// the listeners of the valueholder

class ActionButton extends StatefulWidget {
  const ActionButton({
    Key key,
  }) : super(key: key);

  @override
  ActionButtonState createState() => ActionButtonState();
}

class ActionButtonState extends SharingState<ActionButton> {
  ValueHolder<int> counter;

  @override
  // instead of getting the shared value holder in the build method
  // we may get it inside the didChangeDependencies
  void didChangeDependencies() {
    counter = (MyApp.myhomepageKey.currentState).counter;
    subscribeTo(counter);
  }

  void increment() {
    int value = counter.data + 1;
    counter.data = value;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: increment,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}


