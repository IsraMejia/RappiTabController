import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rappi_ui_tabcontroller/rappi_bloc.dart';
import 'package:rappi_ui_tabcontroller/rappi_data.dart';

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

  final _bloc = RappiBLoC();

  @override
  void initState() {
    _bloc.init(this); //Para mandarle el vsync necesario para el tabcontroller que esta en el rappi_bloc.dart
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose(); //Libero los recursos del dispose del bloc (tab controller, scroll controller)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: AnimatedBuilder( //elevation y opaciodad como animacion en las categorias
          animation: _bloc, //Le pasamos con BLoC la animaicion (Que resale el tab)
          builder: (contextbuilder , crearWidget) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch ,  
            children: [
              Container(//El homepage
                color: Colors.white ,
                height: 80, 
                padding: EdgeInsets.symmetric(horizontal :30 , vertical: 15),
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
                // color: Colors.teal[100] ,
                height: 60,
                child: TabBar(
                  controller: _bloc.tabController ,
                  indicatorWeight: 0.9, //En 0.1 es casi imperseptible, pero a mi si me gusta jeje
                  isScrollable: true, 
                  // tabs: List.generate(10, (index) => _RappiTabWidget() ), 
                  //Genera la lista de 10 widgets que recibe tabs 👀 Asi se hacia antes xd
                  tabs: _bloc.tabs.map((e) => _RappiTabWidget(e)).toList()  ,
                  //mapea los elementos de la lista tap para generar los _RappiTabWidget
                  //una vez creados los odenamos en una lista de tipo _RappiTabWidget que se manda a tabs:
                  onTap: _bloc.onCategorySelected, //para elevarlo o no si se selecciono, recibe index
                ),
              ),


              Expanded(
                child: Container(
                // color: Colors.yellow,
                child: ListView.builder(
                  // itemCount: 20,
                  controller: _bloc.scrollController,
                  itemCount: _bloc.items.length ,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context , index){
                    final item = _bloc.items[index];
                    // if(index.isOdd){//si  el index es impar
                    if(item.isCategory){ //Si en el indice del item es categoria 
                      return  _RappiCategoryItem(item.category);
                    }else{
                      return _RappiProductItem(item.product);
                    }
                     
                  },
                 ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }//build

  
} // class _RappiConceptState

class _RappiTabWidget  extends StatelessWidget {
  const _RappiTabWidget(this.category); //constructor de la clase
  final RappiTabCategory category;
    
    @override
    Widget build(BuildContext context) {
      final selected = category.selected;
      return Opacity(
        opacity: (selected) ? 1 : 0.5, //Para resaltar la el tabCategory seleccionado
        child: Card(
           elevation: (selected) ?  6 : 0, //Si esta seleccionado tiene elevacion de 6 , si no pos no xd
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(
               category.category.name ,
               style: TextStyle(
                 color: _blueColor,
                 fontWeight: FontWeight.bold,
                 fontSize: 13,
               ),
             ),
           ),
        ),
      );
    }
  }// class _RappiTabWidget



  class _RappiCategoryItem extends StatelessWidget {
    
    const _RappiCategoryItem( this.category); //El constructor para cuando se genera y recibe del _bloc
    final RappiCategory  category;
  
    @override
    Widget build(BuildContext context) {
      return Container(
        height: categoryHeight,
        alignment: Alignment.centerLeft, //Alinia el contenido al centro a la izquierda B)
        // color: Colors.cyan[50],
        child: Card(
          child: Text( category.name ,
            style: TextStyle(
             color: _blueColor, fontSize: 16, fontWeight: FontWeight.bold
            ),
        ),
        )
      );
    }
  } //class _RappiCategoryItem

  
class _RappiProductItem extends StatelessWidget {

  const _RappiProductItem ( this.product); //El constructor para cuando se genera y recibe del _bloc
  final RappiProduct  product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: productHeight, 
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:5.0),
        child: Card(
          elevation: 6,
          shadowColor: Colors.black54 , 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/loading.gif" , 
                    image: product.image
                  ),
                ),
              ), 
              
              const SizedBox(width: 10,),

              Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start ,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(product.name,
                    style: TextStyle(
                    color: _blueColor, fontSize: 14, fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text( product.description.toString() , 
                    maxLines: 2, //Para no saturar el texto :o, recorta todo lo demas
                    style: TextStyle(
                    color: _blueColor, fontSize: 12,  
                    ),                
                   ),
                  const SizedBox(height: 5),
                  Text('\$ ${product.price.toStringAsFixed(2)} ', // \$ <- Para que se pueda ver el $ en la interpolacion
                    //Solo deja ver 2 decimales 
                    style: TextStyle(
                    color: _greenColor, fontSize: 14, fontWeight: FontWeight.bold
                    ),
                  ),
                 ],
                ),
              ),
              
            ],
          )
        
        ),
      )
      
    );
  }
} //class _RappiProductItem 