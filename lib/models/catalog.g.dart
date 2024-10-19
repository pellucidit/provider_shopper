// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$catalogModelHash() => r'80f3d36d1c04c40f30e66075d15c88403853549e';

/// A proxy of the catalog of items the user can buy.
///
/// In a real app, this might be backed by a backend and cached on device.
/// In this sample app, the catalog is procedurally generated and infinite.
///
/// For simplicity, the catalog is expected to be immutable (no products are
/// expected to be added, removed or changed during the execution of the app).
///
/// Copied from [CatalogModel].
@ProviderFor(CatalogModel)
final catalogModelProvider =
    AutoDisposeNotifierProvider<CatalogModel, List<Item>>.internal(
  CatalogModel.new,
  name: r'catalogModelProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$catalogModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CatalogModel = AutoDisposeNotifier<List<Item>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
