import 'dart:convert';
import 'package:ltwst/Api/recipe.dart';
import 'package:http/http.dart' as http;


class RecipeApi {

  // var axios = require("axios").default;
  //
  // var options = {
  //   method: 'GET',
  //   url: 'https://yummly2.p.rapidapi.com/feeds/list',
  //   params: {limit: '24', start: '0'},
  //   headers: {
  //     'x-rapidapi-host': 'yummly2.p.rapidapi.com',
  //     'x-rapidapi-key': 'ed9ac4fa6fmsh71817fd144be59ap1e331ejsna96b3f6e4a33'
  //   }
  // };
  //
  // axios.request(options).then(function (response) {
  //   console.log(response.data);
  // }).catch(function (error) {
  //   console.error(error);
  // });



  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {
          "limit": "24", "start": "0", "tag": "list.recipe.popular"
        });

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "ADD KEY",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}