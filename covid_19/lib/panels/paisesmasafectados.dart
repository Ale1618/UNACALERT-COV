import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PanelMasAfectados extends StatelessWidget {

  final List DatosPaises;

  const PanelMasAfectados({Key key, this.DatosPaises}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: <Widget>[
                  Image.network(DatosPaises[index]['countryInfo']['flag'],height: 25,),
                  SizedBox(width: 10,),
                  Text(DatosPaises[index]['country'],style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 10,),
                  Text('Muertes: '+ DatosPaises[index]['deaths'].toString(),style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                ],
              ),
            );
      },
      itemCount: 5,),
    );
  }
}
