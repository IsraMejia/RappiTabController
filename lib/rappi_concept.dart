import 'package:flutter/material.dart';

const _backgroundColor = Color(0xFFF6F9FA);
const _blueColor = Color(0xFF0D1863);
const _greenColor = Color(0xFF2BBEBA);

class RappiConcept extends StatefulWidget {
  
//--------voy en 8:21 , agregando ta b controller
  @override
  _RappiConceptState createState() => _RappiConceptState();
}

class _RappiConceptState extends State<RappiConcept> with SingleTickerProviderStateMixin{
  //Hacemos el mixing SingleTickerProviderStateMixin para poder uar el vsync en el tab controller

  TabController _tabController ;

  @override
  void initState() {
    _tabController = TabController(
      length: 10 ,
      vsync: this //Se le asigna el vsync del widget de la pantalla 
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch ,  
          children: [
            Container(//El homepage
              color: Colors.white ,
              height: 90,
              padding: EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('HomePage',
                    style: TextStyle(
                      color: _blueColor, fontSize: 20, fontWeight: FontWeight.bold
                    ),
                  ),
                  
                  CircleAvatar(
                    radius: 17,
                    backgroundImage: NetworkImage(
                      "https://iespecialidades.com/wp-content/uploads/2020/01/Man-Person-People-Avatar-User-Happy-512.png"
                    )
                  )
                ],
              ),
            ),

            Container( //Tabs
              color: Colors.blue,
              height: 60,
              child: TabBar(
                controller: _tabController ,
                isScrollable: true, 
                tabs: List.generate(10, (index) => _RappiTabWidget() ), 
                //Genera la lista de widgets que recibe tabs :)
                
              ),
            ),


            Expanded(
              child: Container(
              color: Colors.yellow
              ),
            )
          ],
        )
      ),
    );
  }//build

  
} // class _RappiConceptState

class _RappiTabWidget  extends StatelessWidget {
  
    @override
    Widget build(BuildContext context) {
      return Card(
         elevation: 6,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text(
             'saludos',
             style: TextStyle(
               color: _blueColor,
               fontWeight: FontWeight.bold,
               fontSize: 13,
             ),
           ),
         ),
      );
    }
  }