import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rappi_ui_tabcontroller/rappi_data.dart';

class RappiBLoC with ChangeNotifier{
   List<RappiTabCategory> tabs = []; //Inicializamos la lista de tipo RappiTabCategory
   TabController tabController ;
  
  void init(TickerProvider ticker){

     tabController = TabController(
      length: rappiCategories.length ,
      vsync: ticker //Se le asigna el vsync del widget de la pantalla 
    );

    for (int i =0; i< rappiCategories.length ; i++){
      final category = rappiCategories[i];
      tabs.add( RappiTabCategory(
        category: category,
        selected: (i==0) ? true : false , //Si es el primer elemento por defecto es true
        )
      );//add
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
  }

}//class RappiBLoC

class RappiTabCategory {

  const RappiTabCategory({
    @required this.category, 
    @required this.selected
  }); 

  RappiTabCategory copyWith(bool selected) => RappiTabCategory(category: category, selected: selected) ; 
  //Se clona el objeto Solo Si es seleccionado y, se pone su elevation y opaciodad para crear la animacion

  final RappiCategory category;
  final bool selected;//Estado de seleccionado o no la categoria

}