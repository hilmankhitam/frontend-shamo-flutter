part of 'services.dart';

class ProductSevice {
  String baseUrl = 'https://shamo-backend.buildwithangga.id/api';

  Future<List<ProductModel>> getProducts() async {
    var url = '$baseUrl/products';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    debugPrint(response.body);

    if(response.statusCode == 200){
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];
      
      for (var item in data){
        products.add(ProductModel.fromJson(item));
      }

      return products;
    }else{
      throw Exception('Gagal Get Products!');
    }
  }
}
