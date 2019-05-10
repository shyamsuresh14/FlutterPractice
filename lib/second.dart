import 'package:flutter/material.dart';
import 'camera.dart';
import 'fourth.dart';

class SecondActivity extends StatelessWidget{
  final String place, location;
  SecondActivity({@required this.place, @required this.location});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Activity'),
      ),
      body: ListView(
        children: <Widget>[
          AnimationWidgetOption(),
          Container(
            padding: EdgeInsets.all(30),
            child: Text(
              'Welcome to $place!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(5),
              child: Hero(
                tag: 'mainImage',
                child: Image.asset('images/lake.jpg')
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text('$location',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),  
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context, "back");
                },
                child: Text('Go Back'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CameraActivity())
                  );
                },
                child: Text('Camera'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FourthActivity())
                  );
                },
                child: Text('Next'),
              )
            ],
          ),
        ]
      )
    );
  }
  
}

class AnimationWidgetOption extends StatefulWidget{
  _AnimationWidgetOptionState createState() => _AnimationWidgetOptionState();
}

class _AnimationWidgetOptionState extends State<AnimationWidgetOption>{
  bool _animate = false;
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        setState(() {
          _animate = !_animate; 
        });
      },
      child: _animate ? AnimationWidget() : Center(
        child: Container(
          child: FlutterLogo(), 
          height: 150, 
          width: 300, 
          margin: EdgeInsets.symmetric(
            vertical: 10
          ),
        )
      ),
    );
  }
}

class AnimationWidget extends StatefulWidget{
  @override
  _AnimationWidgetState createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController controller;
  @override
  void initState(){
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
        ..addStatusListener((status) {
          if(status == AnimationStatus.completed)
            controller.reverse();
          else if(status == AnimationStatus.dismissed)
            controller.forward();  
        });
    controller.forward();    
  }
  @override
  Widget build(BuildContext context) => GrowTransition(child: LogoWidget(), animation: animation,);

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
}

class GrowTransition extends StatelessWidget{
  GrowTransition({this.child, this.animation});
  final Widget child;
  final Animation animation;
  @override
  Widget build(BuildContext context){
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (context, child) => Container(
          child: child,
          height: animation.value,
          width: animation.value,
        )
      )
    );
  }
}

class LogoWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlutterLogo(),
    );
  }
}
