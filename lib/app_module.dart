import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_comics/src/domain/domain.dart';
import 'package:marvel_comics/src/presentation/views/home/home_page.dart';
import 'package:marvel_comics/src/presentation/views/home/home_viewmodel.dart';

import 'src/data/data.dart';
import 'src/presentation/views/detail/detail_page.dart';
import 'src/presentation/widgets/error_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add<Dio>(() => Dio(BaseOptions(baseUrl: 'http://gateway.marvel.com/v1/')));
    i.add<ICharacterDatasource>(
      () => CharacterDatasource(i.get<Dio>()),
    );
    i.add<ICharacterRepository>(
      () => CharacterRepository(i.get<ICharacterDatasource>()),
    );
    i.add<IGetCharacterUsecase>(
      () => GetCharacterUsecase(i.get<ICharacterRepository>()),
    );
    i.add<HomeViewModel>(
      () => HomeViewModel(i.get<IGetCharacterUsecase>()),
    );
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
    r.child('/detail', child: (context) => DetailPage(character: r.args.data));
    r.child('/error', child: (context) => ErrorPage(tryAgain: r.args.data));
  }
}
