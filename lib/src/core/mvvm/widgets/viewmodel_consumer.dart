
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../mvvm.dart';

/// [ViewModelConsumer] exposes a [builder] and [listener] in order react to new
/// states.
/// [ViewModelConsumer] is analogous to a nested [ViewModelListener]
/// and [ViewModelBuilder] but reduces the amount of boilerplate needed.
/// [ViewModelConsumer] should only be used when it is necessary to both rebuild
/// UI and execute other reactions to state changes in the [ViewModel].
class ViewModelConsumer<VM extends ViewModel<S>, S extends ViewModelState>
    extends BlocConsumer<VM, S> {
  /// Creates a [ViewModelConsumer]
  const ViewModelConsumer({
    Key? key,
    required VM viewModel,
    required ViewModelWidgetBuilder<S> builder,
    required ViewModelWidgetListener<S> listener,
    ViewModelBuilderCondition<S>? buildWhen,
    ViewModelListenerCondition<S>? listenWhen,
  }) : super(
          key: key,
          bloc: viewModel,
          builder: builder,
          listener: listener,
          buildWhen: buildWhen,
          listenWhen: listenWhen,
        );
}
