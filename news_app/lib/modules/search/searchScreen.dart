import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/componant/componants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var search = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchController,
                    label: 'search',
                    onChange: (value){
                      NewsCubit.get(context).getSearch(value);
                    },
                    prefix: const Icon(Icons.search),
                    validate: (value){
                      if(value.isEmpty){
                        return 'value can\'t be empty';
                      }
                      return null;
                    },
                    type: TextInputType.text
                ),
              ),
              Expanded(child: defaultItemList(search, state is! NewsSearchLoadingState))

            ],
          ),
        );
      },
    );
  }
}
