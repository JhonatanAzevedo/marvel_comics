import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'viewmodel_state.dart';

/// A view model that is used by [View] to handle application states and
/// interact with use cases
abstract class ViewModel<State extends ViewModelState> extends BlocBase<State> implements Disposable {
  /// If view model is initialized
  bool isInitialized = false;

  /// Creates a [ViewModel]
  ViewModel(initialState) : super(initialState) {
    initViewModel();
  }

  /// Called when the [ViewModel] is created
  @mustCallSuper
  void initViewModel() {
    assert(
      !isInitialized,
      'View Model has already been initialized! The initialization occurs automatically on life cycle, so you should not call initViewModel manually.',
    );
    isInitialized = true;
  }

  @override
  void emit(State state) {
    if (!isClosed) super.emit(state);
  }

  @override
  void dispose() {
    super.close();
  }
}
