part of 'providers.dart';

enum RequestState {
  empty,
  loading,
  error,
  loaded,
}

class ProductProvider with ChangeNotifier {
  List<ProductModel>? _products;
  List<ProductModel> get products => _products!;

  RequestState _productState = RequestState.empty;
  RequestState get productState => _productState;

  String _message = '';
  String get message => _message;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      _productState = RequestState.loading;
      List<ProductModel> products = await ProductSevice().getProducts();
      _products = products;

      _productState = RequestState.loaded;
      notifyListeners();
    } catch (e) {
      _message = e.toString();
      _productState = RequestState.error;
      notifyListeners();
    }
  }
}
