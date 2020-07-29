# mustash

Multi-State Sharing Framework

## Getting Started

Mustash (for **Mu**lti-**Sta**te **Sh**aring framework) is a very simple framework and pattern for handling shared states 
between widgets in Flutter. It is far less rich than Mobx, Redux, BLoC and so on... But it is also simpler 
to understand and to implement while doing mainly the job. 

Its other caracteristics is its lightweight... only two classes : SharingState and ValueHolder. Nothing else.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
For french speakers, a good post on states in Flutter: [Widget states](https://www.didierboelens.com/fr/2018/06/widget-state-context-inheritedwidget/)

## ValueHolder class
A ValueHolder is simply a wrapper around a value.
Its goal is to be shared between many widgets in a widget tree
and to handle life-cycle functions like subscribing, notifying widgets of value changes,
disposing the valueholder once the widget is itself disposed.

To create a valueholder, do simply this :

     var aValueHolder = ValueHolder<int>(0);
     
It creates in this exemple a valueholder around an int value which
is itself initialized to 0;

To access the internal value, we just have to do :

    var aValue = aValueHolder.value ;
    aValueHolder.value = aValue;

The ValueHolder class may be subclassed when the internal value is for instance an object instead of terminal value.
This subclass may be named a Controller and implements other methods than value and value()

ex:

    class MyObject {
      MyObject(this.counter)
      
      int counter;
    }
    
    
    class MyController extends ValueHolder<MyObject> {
       void increment() {
         value.counter+=1;
         _updateListeners();
       }
    
       int get count => value.counter;
    }
    
    var anObject = MyObject(0);
    var myController = Controller(anObject);
    
## SharingWidget class

The abstract class SharingState is a subclass of the State class.
Its goal is to simplify the life-cycle management of the ValueHolders
by subscribing to   valueholders, and to manage automatically the disposal of these ones
when the widget itself is disposed.

ex :

     class MyState extends SharingState<MyWidget> {
       build(BuildContext context) {
       
           //we get the shared value holder
           var counter = (MyApp.myhomepageKey.currentState).counter;
           
           //the state component subscribe to the valueholder, i.e. it becomes a listener of the valueholder
           subscribeTo(counter);
           
           //we use the value holder
            var val = counter.value;
            return Text(
               '$val',
                style: Theme.of(context).textTheme.headline4,
             );
       }
     }
     
## Where declaring the shared values?

You have to find first the place in the the widget tree above the children widget will share the values.
For instance, if we have an application containing for instance a main stetafull page containing in the 
subtree two other statefull widgets having to share values, we'll define these values there.

    class MyHomePageState extends State<MyHomePage> {
      // we create the shared value holder and we initialize it directly
      ValueHolder<int> counter = ValueHolder<int>(0);

But how to access them in the chil widgets? By simply using the GlobalKey mechanism :

    class MyApp extends StatelessWidget {
      // This global key will be used to get the valueholders in the WidgetStates
      static GlobalKey<MyHomePageState> myhomepageKey;
    
      // This widget is the root of your application.
      @override
      Widget build(BuildContext context) {
        myhomepageKey = GlobalKey<MyHomePageState>();
        return MaterialApp(
          title: 'Flutter Demo',
          home: MyHomePage(key: myhomepageKey, title: 'Flutter Demo Home Page'),
        );
      }
    }
    
The access in the subtree will be donne simply by :

    var counter = (MyApp.myhomepageKey.currentState).counter;
    
Nothing else.
     
##  Example

An example is available in _bin/simple_example.dart_