abstract class SearchFailure implements Exception {}

class InvalidTextError implements SearchFailure {}

class DatasourceError implements SearchFailure {
  final String? message;

  DatasourceError({this.message});
}
