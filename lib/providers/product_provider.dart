part of 'providers.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel>? _products;
  List<ProductModel> get products => _products!;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductSevice().getProducts();
      _products = products;
    } catch (e) {
      debugPrint('$e');
    }
  }
}
