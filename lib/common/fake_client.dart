import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fake_client.g.dart';

// ignore: invalid_annotation_target
@JsonLiteral('fake_products.json')
final _items = _$_itemsJsonLiteral;


class FakeDio implements Dio {

  @override
  Future<Response<T>> get<T>( String path,
  {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async
  {
    return FakeResponse(_items) as Response<T>;
  }

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}


class FakeResponse implements Response<Map<String, Object?>> {
  FakeResponse(this.data, {this.statusCode = 200});

  @override 
  final Map<String, Object?> data;

  @override
  final int statusCode;

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}
