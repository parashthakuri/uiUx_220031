// Mocks generated by Mockito 5.4.4 from annotations
// in sneakers_point/test/unit_test/product_unit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:io' as _i8;

import 'package:dartz/dartz.dart' as _i3;
import 'package:sneakers_point/core/failure/failure.dart' as _i6;
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart'
    as _i7;
import 'package:sneakers_point/features/product/domain/repository/product_repository.dart'
    as _i2;
import 'package:sneakers_point/features/product/domain/use_case/product_usecase.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeProductRepository_0 extends _i1.SmartFake
    implements _i2.ProductRepository {
  _FakeProductRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProductuseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductuseCase extends _i1.Mock implements _i4.ProductuseCase {
  @override
  _i2.ProductRepository get productRepository => (super.noSuchMethod(
        Invocation.getter(#productRepository),
        returnValue: _FakeProductRepository_0(
          this,
          Invocation.getter(#productRepository),
        ),
        returnValueForMissingStub: _FakeProductRepository_0(
          this,
          Invocation.getter(#productRepository),
        ),
      ) as _i2.ProductRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, bool>> addProduct(
    _i7.ProductEntity? productEntity,
    _i8.File? img,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addProduct,
          [
            productEntity,
            img,
          ],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
            _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #addProduct,
            [
              productEntity,
              img,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
                _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #addProduct,
            [
              productEntity,
              img,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, bool>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, bool>> deleteProduct(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteProduct,
          [id],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
            _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #deleteProduct,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
                _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #deleteProduct,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, bool>>);

  @override
  _i5.Future<
      _i3.Either<_i6.Failure,
          List<_i7.ProductEntity>>> getAllProduct() => (super.noSuchMethod(
        Invocation.method(
          #getAllProduct,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.ProductEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.ProductEntity>>(
          this,
          Invocation.method(
            #getAllProduct,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.ProductEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.ProductEntity>>(
          this,
          Invocation.method(
            #getAllProduct,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.ProductEntity>>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.ProductEntity>> getProductById(
          String? productId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProductById,
          [productId],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, _i7.ProductEntity>>.value(
                _FakeEither_1<_i6.Failure, _i7.ProductEntity>(
          this,
          Invocation.method(
            #getProductById,
            [productId],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.ProductEntity>>.value(
                _FakeEither_1<_i6.Failure, _i7.ProductEntity>(
          this,
          Invocation.method(
            #getProductById,
            [productId],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.ProductEntity>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.ProductEntity>>> searchProducts(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchProducts,
          [query],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.ProductEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.ProductEntity>>(
          this,
          Invocation.method(
            #searchProducts,
            [query],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.ProductEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.ProductEntity>>(
          this,
          Invocation.method(
            #searchProducts,
            [query],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.ProductEntity>>>);
}
