import 'package:flutter/material.dart';
import 'second.dart';

void main() => runApp(
    MaterialApp(
        title: 'Flutter Layouts',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: MyApp()
    )
);

class MyApp extends StatelessWidget {
  final String place = 'Some Lake Campground';
  final String location = 'Place, Switzerland';
  @override
  Widget build(BuildContext context) {

      Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InfoWidget()
          ),
          LikeWidget()
        ],
        ),
      );

      Color color = Colors.blue[500];
      Widget buttonSection = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildButtonColumn(Icons.star, color, 'LIKE'),
            _buildButtonColumn(Icons.comment, color, 'COMMENT'),
            _buildButtonColumn(Icons.share, color, 'SHARE')
        ],)
      );

      Widget textSection = Container(
        padding: const EdgeInsets.all(32),
        child: Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
          softWrap: true,
        ),
      );


    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Practice'),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              child: Hero(
                tag: 'mainImage',
                child: Image.asset(
                  'images/lake.jpg',
                  width: 600,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
            ),  
            titleSection,
            buttonSection,
            textSection,
            TapBox()
          ],
        ),
      );
  }

  Column _buildButtonColumn(IconData icon, Color color, String label){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          )
        ),
      ],
    );
  }
}

class InfoWidget extends StatelessWidget{
  final String place = 'Some Lake Campground';
  final String location = 'Place, Switzerland';
  void handleTap(BuildContext context) async{
  final result = await Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => SecondActivity(location: location, place: place,))
  );
  Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result'),));
  }
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        handleTap(context);
      },
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                place,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              location,
              style: TextStyle(
                color: Colors.grey[500],
              ),
            )
          ],
        ),
    );
  }
}
class LikeWidget extends StatefulWidget{
  @override
  _LikeWidgetState createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget>{
  bool _liked = true;
  int _likeCount = 41;
  void _toggleState(){
    setState((){
      if(_liked){
        _likeCount -= 1;
        _liked = false;
      }
      else{
        _likeCount += 1;
        _liked = true;
      }
    });
  }
  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_liked ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleState,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_likeCount'),
          ),
        )
      ],
    );
  }
}

class TapBox extends StatefulWidget{
  @override
  _TapBoxState createState() => _TapBoxState();
}

class _TapBoxState extends State<TapBox>{
  bool _tapped = false;
  void _handleTap(){
    setState(() {
      _tapped = !_tapped;
    });
  }
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        child: Center(
          child: Text(
            _tapped ? "Active" : "Inactive",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        width: 200,
        height: 100,
        color: _tapped ? Colors.green[500] : Colors.red[600],
        duration: Duration(seconds: 1),
      ),
    );
  }
}



