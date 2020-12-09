import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rappi_ui_tabcontroller/rappi_data.dart';

const categoryHeight = 55.0;
const productHeight = 110.0;

class RappiBLoC with ChangeNotifier{
   List<RappiTabCategory> tabs = []; //Inicializamos la lista de tipo RappiTabCategory
   List<RappiItem> items = []; //El arreglo de items
   TabController tabController ;
   ScrollController scrollController = ScrollController();
  void init(TickerProvider ticker){

     tabController = TabController(
      length: rappiCategories.length ,
      vsync: ticker //Se le asigna el vsync del widget de la pantalla 
    );
    double  offsetFrom  = 0.0; //al entrar a la pagina empieza en 0
    for (int i =0; i< rappiCategories.length ; i++){
      final category = rappiCategories[i];
      
      if(i>0){
        offsetFrom  += rappiCategories[i - 1].products.length.toDouble() * productHeight ; 
        //Se le asigna la altura de los productos totales por categoria que hay que recorrer 👀
      } 

      tabs.add( RappiTabCategory(
        category: category,
        selected: (i==0) ? true : false , //Si es el primer elemento por defecto es true
        offsetFrom: (categoryHeight * i) + offsetFrom,  //Se le agrega el valor propios de las categorias
        )
      );//add

      items.add( RappiItem(category: category) ); //Se agrega la categoria
      for (int j =0; j<category.products.length ; j++){
        final product = category.products[j];
        items.add( RappiItem( product: product) ); //Ahora los productos
      }


    }//ciclo de asignacion
  }//init


  void onCategorySelected(int index) {
    final selected = tabs[index] ;
    for (int i =0; i< tabs.length ; i++){
          tabs[i] = tabs[i].copyWith(tabs[i] == selected); 
          //Si la tabCategory es la que se selecciono en el tabController
          //Se reemplazan los objetos cuando son seleccionados
    }
    notifyListeners(); //Se notifica al listener para que se haga el cambio al clonado xd

    scrollController.animateTo(
      selected.offsetFrom, // desde que altura o elemento se hara el scroll
      duration: const Duration(milliseconds: 500)  , curve: Curves.linear
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

}//class RappiBLoC

class RappiTabCategory {

  const RappiTabCategory({
    @required this.category, 
    @required this.selected,
    @required this.offsetFrom
  }); 

  RappiTabCategory copyWith(bool selected) => RappiTabCategory(
    category: category, selected: selected, offsetFrom: offsetFrom
  ) ; 
  //Se clona el objeto Solo Si es seleccionado y, se pone su elevation y opaciodad para crear la animacion

  final RappiCategory category;
  final bool selected;//Estado de seleccionado o no la categoria

  final double offsetFrom; //para poder definir cuanto hacer scroll (desde donde se hará)

}


class RappiItem{
  
  const RappiItem({
     this.category,
     this.product
  });
  
  final RappiCategory category;
  final RappiProduct product;
  bool get isCategory => category != null; //Si no es nulo es true el isCategory
  
}