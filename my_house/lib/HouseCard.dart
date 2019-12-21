import 'package:flutter/material.dart';
import 'package:my_house/models/home.dart';

class HouseCard extends StatelessWidget {
  Home home;
  HouseCard({Key key,this.home}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Card(child: 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(home.name,style:TextStyle(fontSize: 18.0,)),
          Text(home.address)
        ],
      ),
      )
      ,)
       
    );
  }
}