import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webView/webView.dart';

Widget defaultNewsItem(article,context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url'],),);
  },
  child:   Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(10),
            image:  DecorationImage(
              image:NetworkImage('${article['urlToImage'] ?? 'https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg'}'),
              fit:BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style:Theme.of(context).textTheme.bodyText1,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style:const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  required Icon prefix,
  required validate,
  required TextInputType type,
  suffix,
  pressedShow,
  onTap,
  onChange,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      onTap: onTap,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefix,
        suffixIcon: suffix!=null ? IconButton(
          icon: suffix,
          onPressed:pressedShow,):null ,
        border: const OutlineInputBorder(),
      ),
      validator: validate,
      keyboardType: type,
    );


Future navigateTo(context,widget) => Navigator.push(context,
    MaterialPageRoute(builder: (context) => widget,
    )
);

Widget defaultItemList(list,condition) => ConditionalBuilder(
  condition: condition,
  builder: (context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      return defaultNewsItem(list[index],context);
    },
    separatorBuilder: (context, index) => Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    ),
    itemCount: list.length,
  ),
  fallback: (BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  },
);
