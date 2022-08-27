import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/businessScreen/businessScreen.dart';
import 'package:news_app/modules/scienceScreen/scienceScreen.dart';
import 'package:news_app/modules/sportsScreen/sportsScreen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cacheHelper.dart';
import 'package:news_app/shared/network/remote/dioHelper.dart';

class NewsCubit extends Cubit<NewsStates> {

  NewsCubit() : super(NewsInitState());

  static NewsCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;

  void bottomNavChange(index){
    currentIndex = index;
    if(index == 1){
      getSports();
    }
    if(index == 2){
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<Widget> screens =[
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  List <dynamic> business =[];
  List <dynamic> sports =[];
  List <dynamic> science =[];

  getBusiness(){
    emit(NewsBusinessLoadingState());
    if(business.isEmpty){
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'fcb8108a1c6440408a96c64ca098744c',
        }).then((value) {
      business = value.data['articles'];
      print(business);
      emit(NewsBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsBusinessErrorState(error));
    });
    }else{
      emit(NewsBusinessSuccessState());
    }
  }

  getSports(){
    emit(NewsSportsLoadingState());
    if(sports.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'fcb8108a1c6440408a96c64ca098744c',
          }).then((value) {
        sports = value.data['articles'];
        print(sports);
        emit(NewsSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsSportsErrorState(error));
      });
    }else{
      emit(NewsSportsSuccessState());
    }

  }

  getScience(){
    emit(NewsScienceLoadingState());
    if(science.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'fcb8108a1c6440408a96c64ca098744c',
          }).then((value) {
        science = value.data['articles'];
        print(science);
        emit(NewsScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsScienceErrorState(error));
      });
    }else{
      emit(NewsScienceSuccessState());
    }

  }


  bool isDark = false;
  changeTheme({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
    }else {
      isDark = !isDark;
    }
    CacheHelper.setDark(key: 'isDark', isDark: isDark).then((value) {
      emit(NewsChangeThemeState());
    });
  }

  List <dynamic> search =[];
  getSearch(value){
    emit(NewsSearchLoadingState());
    search =[];
    if(search.isEmpty){
      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':'$value',
            'apiKey':'fcb8108a1c6440408a96c64ca098744c',
          }).then((value) {
        search = value.data['articles'];
        print(search);
        emit(NewsSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsSearchErrorState(error));
      });
    }else{
      emit(NewsSearchSuccessState());
    }

  }
}