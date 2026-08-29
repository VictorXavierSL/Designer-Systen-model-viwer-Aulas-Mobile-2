import 'package:flutter/foundation.dart';

/// Uma seção de exemplos dentro de uma tela-espelho de showcase.
///
/// Cada `*_factory.dart` expõe um método `showcaseCatalog()` que devolve
/// uma lista de [ShowcaseSection]<T>, onde `T` é o ViewModel do
/// componente correspondente. As telas `sample_*_screen.dart` apenas
/// iteram essa lista e renderizam — nenhuma tela precisa conhecer as
/// regras de quais variantes existem.
@immutable
class ShowcaseSection<T> {
  final String title;
  final String? description;
  final List<ShowcaseItem<T>> items;

  const ShowcaseSection({
    required this.title,
    this.description,
    required this.items,
  });
}

@immutable
class ShowcaseItem<T> {
  final String caption;
  final T viewModel;

  const ShowcaseItem({required this.caption, required this.viewModel});
}
