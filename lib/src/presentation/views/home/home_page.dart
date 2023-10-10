import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marvel_comics/src/presentation/views/home/store_home_state.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../widgets/loading_shimmer.dart';
import 'home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: SvgPicture.asset('assets/images/marvel.svg'),
        ),
        body: ViewModelConsumer<HomeViewModel, HomeState>(
          viewModel: viewModel,
          listener: (context, state) {
            if (state.error) {
              Modular.to.pushNamed(
                '/error',
                arguments: () {
                  Modular.to.pop();
                  viewModel.showCharacter();
                },
              );
            }
          },
          builder: (context, state) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is OverscrollNotification) {
                  viewModel.chagePage();
                  viewModel.showCharacter();
                }
                return true;
              },
              child: !state.loading || state.page != 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24.0),
                          const Text(
                            'Bem vindo ao mundo Marvel',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            'Escolha o seu\npersonagem',
                            style: TextStyle(color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 24.0),
                          Expanded(
                            child: AnimationLimiter(
                              child: MasonryGridView.builder(
                                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                itemCount: state.characters.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Character character = state.characters[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(milliseconds: 375),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: InkWell(
                                            onTap: () => Modular.to.pushNamed('/detail', arguments: character),
                                            child: Hero(
                                              tag: character.id,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 230,
                                                    child: ClipRRect(
                                                      borderRadius: const BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                      child: Image.network(
                                                        character.thumbnail,
                                                        fit: BoxFit.cover,
                                                        frameBuilder: (_, image, loadingBuilder, __) {
                                                          if (loadingBuilder == null) {
                                                            return const SizedBox(
                                                              child: Center(
                                                                child: CircularProgressIndicator(),
                                                              ),
                                                            );
                                                          }
                                                          return image;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    character.name,
                                                    style: const TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          if (state.loading) const Center(child: CircularProgressIndicator())
                        ],
                      ),
                    )
                  : const LoadingShimmer(),
            );
          },
        ),
      ),
    );
  }
}


