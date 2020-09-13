import 'package:equatable/equatable.dart';

abstract class BlocDataLoadingState<T> extends Equatable {
  const BlocDataLoadingState({
    bool isLoading,
    this.data,
    this.error,
  }) : isLoading = isLoading ?? false;

  final bool isLoading;
  final T data;
  final Object error;

  bool get hasData => data != null;

  bool get hasError => error != null;

  @override
  List<Object> get props => [isLoading, data, error];

  @override
  bool get stringify => true;
}
