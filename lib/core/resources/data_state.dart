import 'package:http/http.dart' as http;

abstract class DataState<T> {
  final T? data;
  final http.Response? clientException;

  const DataState({this.data, this.clientException});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(http.Response clientException)
      : super(clientException: clientException);
}
