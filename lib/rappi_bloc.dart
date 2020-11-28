import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rappi_ui_tabcontroller/rappi_data.dart';

class RappiBLoC with ChangeNotifier{
   List<RappiTabCategory> tabs = []; //Inicializamos la lista de tipo RappiTabCategory

  void init(){
    for (int i =0; i< rappiCategories.length ; i++){
      final category = rappiCategories[i];
      tabs.add( RappiTabCategory(
        category: category,
        selected: (i==0) ? true : false, //Si es el primer elemento por defecto es true
        )
      );//add
    }//ciclo de asignacion
  }//init

}//class RappiBLoC

class RappiTabCategory {

  const RappiTabCategory({
    @required this.category, 
    @required this.selected
  }); 

  final RappiCategory category;
  final bool selected;//Estado de seleccionado o no la categoria

}