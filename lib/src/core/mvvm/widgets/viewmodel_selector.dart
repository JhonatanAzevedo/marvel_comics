import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../mvvm.dart';

/// Signature for the `selector` function which
/// is responsible for returning a selected value, [T], based on [state].
typedef ViewModelWidgetSelector<S, T> = T Function(S state);

/// [ViewModelSelector] is analogous to [ViewModelBuilder] but allows developers
/// to filter updates by selecting a new value based on the bloc state.
/// Unnecessary builds are prevented if the selected value does not change.
///
/// **Note**: the selected value must be immutable in order for [ViewModelSelector]
/// to accurately determine whether [builder] should be called again.
class ViewModelSelector<VM extends ViewModel<S>, S extends ViewModelState, T>
    extends BlocSelector<VM, S, T> {
  /// Creates a [ViewModelSelector]
  const ViewModelSelector({
    Key? key,
    required VM viewModel,
    required ViewModelWidgetBuilder<T> builder,
    required ViewModelWidgetSelector<S, T> selector,
  }) : super(
          key: key,
          bloc: viewModel,
          builder: builder,
          selector: selector,
        );
}
