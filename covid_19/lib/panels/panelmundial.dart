import 'package:flutter/material.dart';

class PanelMundial extends StatelessWidget {
  final Map DatosMundo;

  const PanelMundial({Key key, this.DatosMundo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(titulo: 'CONFIRMADOS',
          panelColor: Colors.red[100],
          textColor: Colors.red,
          contador: DatosMundo['cases'].toString(),
          ),
          StatusPanel(titulo: 'ACTIVOS',
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            contador: DatosMundo['active'].toString() ,
          ),
          StatusPanel(titulo: 'RECUPERADOS',
            panelColor: Colors.green[100],
            textColor: Colors.green,
            contador: DatosMundo['recovered'].toString(),
          ),
          StatusPanel(titulo: 'DECESOS',
            panelColor: Colors.grey[400],
            textColor: Colors.grey[900],
            contador: DatosMundo['deaths'].toString(),
          ),

        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget{

  final Color panelColor;
  final Color textColor;
  final String titulo;
  final String contador;

  const StatusPanel({Key key, this.panelColor, this.textColor, this.titulo, this.contador}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      height: 80, width: width/2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text(titulo,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),), Text(contador, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: textColor),)],
      ),
    );
}
}