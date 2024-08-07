// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newsApiHash() => r'ad862fb84a8b445bd5aee40bdab8ffe9695e1ff7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [newsApi].
@ProviderFor(newsApi)
const newsApiProvider = NewsApiFamily();

/// See also [newsApi].
class NewsApiFamily extends Family<NewsApi> {
  /// See also [newsApi].
  const NewsApiFamily();

  /// See also [newsApi].
  NewsApiProvider call({
    required bool enableCache,
  }) {
    return NewsApiProvider(
      enableCache: enableCache,
    );
  }

  @override
  NewsApiProvider getProviderOverride(
    covariant NewsApiProvider provider,
  ) {
    return call(
      enableCache: provider.enableCache,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'newsApiProvider';
}

/// See also [newsApi].
class NewsApiProvider extends AutoDisposeProvider<NewsApi> {
  /// See also [newsApi].
  NewsApiProvider({
    required bool enableCache,
  }) : this._internal(
          (ref) => newsApi(
            ref as NewsApiRef,
            enableCache: enableCache,
          ),
          from: newsApiProvider,
          name: r'newsApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$newsApiHash,
          dependencies: NewsApiFamily._dependencies,
          allTransitiveDependencies: NewsApiFamily._allTransitiveDependencies,
          enableCache: enableCache,
        );

  NewsApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.enableCache,
  }) : super.internal();

  final bool enableCache;

  @override
  Override overrideWith(
    NewsApi Function(NewsApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NewsApiProvider._internal(
        (ref) => create(ref as NewsApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        enableCache: enableCache,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<NewsApi> createElement() {
    return _NewsApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NewsApiProvider && other.enableCache == enableCache;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, enableCache.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NewsApiRef on AutoDisposeProviderRef<NewsApi> {
  /// The parameter `enableCache` of this provider.
  bool get enableCache;
}

class _NewsApiProviderElement extends AutoDisposeProviderElement<NewsApi>
    with NewsApiRef {
  _NewsApiProviderElement(super.provider);

  @override
  bool get enableCache => (origin as NewsApiProvider).enableCache;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
