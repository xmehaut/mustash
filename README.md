# mustash

Multi-State Sharing Framework

## Getting Started

Mustash (for Multi-State Sharing framework) is a very simple framework and pattern for handling shared states 
between widgets in Flutter. It is far less rich than Mobx, Redux, BLoC and so on... But it is also simpler 
to understand and to implement while doing mainly the job. 

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## ValueHolder class
A ValueHolder is simply a wrapper around a value.
Its goal is to be shared between many widgets in a widget tree
and to handle life-cycle functions like subscribing, notifying widgets of value changes,
dispose the valueholder once the widget is itself disposed.
//
To create a valueholder, do simply this :

     var aValueHolder = ValueHolder<int>(0);
     
It creates in this exemple a valueholder around an int value which
is itself initialzed to 0;

To access the internal value, we just have to do :
var aValue = aValueHolder.value ;
aValueHolder.value = aValue;

The ValueHolder class may be subclassed when the internal value is for instance an object instead of terminal value.
This subclass may be named a Controller and implement other methods than value and value()
ex:

    class MyObject {
      int counter;
    }
    
    
    class Controller extends ValueHolder<MyObject> {
       void increment() {
         value.counter+=1;
         _updateListeners();
       }
    
       int get count => value.counter;
    }
    
## SharingWidget class

The abstact class SharingState is a subclass of the State class.
It's goal is to simplify the life-cycle management of the ValueHolders
by subscribing to   valueholders, aand to manage automatically the disposal of these ones
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
     
##  Example

An example is available in _bin/simple_example.dart_