import 'package:flutter/material.dart';

const _backgroundColor = Color(0xFFF6F9FA);
const _blueColor = Color(0xFF0D1863);
const _greenColor = Color(0xFF2BBEBA);
const categoryHeight = 55.0;
const productHeight = 100.0;

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
              color: Colors.teal[100] ,
              height: 60,
              child: TabBar(
                controller: _tabController ,
                indicatorWeight: 0.9, //En 0.1 es casi imperseptible, pero a mi si me gusta jeje
                isScrollable: true, 
                tabs: List.generate(10, (index) => _RappiTabWidget() ), 
                //Genera la lista de 10 widgets que recibe tabs 👀
                
              ),
            ),


            Expanded(
              child: Container(
              color: Colors.yellow,
              child: ListView.builder(
                itemCount: 20,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context , index){
                  if(index.isOdd){//si  el index es impar
                    return  _RappiCategoryItem();
                  }else{
                    return _RappiProductItem();
                  }
                   
                },
               ),
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
             'tab Hacker xd',
             style: TextStyle(
               color: _blueColor,
               fontWeight: FontWeight.bold,
               fontSize: 13,
             ),
           ),
         ),
      );
    }
  }// class _RappiTabWidget



  class _RappiCategoryItem extends StatelessWidget {
    
  
    @override
    Widget build(BuildContext context) {
      return Container(
        height: categoryHeight,
        alignment: Alignment.centerLeft, //Alinia el contenido al centro a la izquierda B)
        color: Colors.white,
        child: Text('Categoría',
        style: TextStyle(
          color: _blueColor, fontSize: 16, fontWeight: FontWeight.bold
         ),
        ),
      );
    }
  } //class _RappiCategoryItem

  
class _RappiProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: productHeight, 
      child: Text('Producto'),
    );
  }
} //class _RappiProductItem 