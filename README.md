# Coffee Design System — Template Demonstrativo

Template Flutter/Dart que demonstra, em código, o sistema de design do
arquivo Figma **["JavaGem — Coffee Shop Mobile App Design" (Community)](https://www.figma.com/design/JpAfa1wvkvsNYCqNHDupoe/Coffee-Shop-Mobile-App-Design--Community-)**.

> ⚠️ **Isto não é um app pronto.** Não há navegação de fluxo completo,
> persistência de dados ou integração com backend. É um **demonstrativo
> do sistema de design**: componentes reutilizáveis, tokens de design e
> telas de exemplo que você usa como ponto de partida / referência para
> construir o app de verdade, ajustando os parâmetros de código.

---

## 1. O que foi extraído do Figma

| Token | Valor | Uso |
|---|---|---|
| Cor 01 — Primária | `#C67C4E` | Botões principais, preço, aba ativa |
| Cor 02 — Secundária | `#EDD6C8` | Fundo de chip selecionado |
| Cor 03 — Dark | `#313131` | Texto, cabeçalho escuro da Home |
| Cor 04 — Grey | `#E3E3E3` | Bordas, ícones inativos |
| Cor 05 — Cream | `#F9F2ED` | Fundo padrão das telas |
| Fonte | **Sora** (Google Font, gratuita) | Toda a tipografia |

Esses valores vieram diretamente do frame **"Color Guide"** e
**"Typography"** do arquivo (página *Assets, Style Guide & Image*), e
estão centralizados em `lib/common/app_colors.dart` e
`lib/common/app_typography.dart` — **a única fonte de verdade** de
estilo do projeto. Mude os valores lá para "re-temar" o app inteiro.

As variantes de botão, cards de produto e barras de navegação foram
inferidas visualmente das telas de alta fidelidade **Home** e
**Detail** do Figma (ex.: botão "Buy Now", seletor de tamanho S/M/L,
chips de categoria, card de produto com badge de rating).

---

## 2. Padrão de projeto: Component / ViewModel / Factory

Cada componente reutilizável em `lib/components/<nome>/` segue sempre a
mesma estrutura de 3 arquivos — um mini-MVVM combinado com o padrão
**Factory** para criação de variantes:

```
components/<nome>/
├── <nome>_component.dart    # A UI Visual — StatelessWidget "burro"
├── <nome>_viewmodel.dart    # O Estado e Dados — classe imutável
└── <nome>_factory.dart      # O Criador de Variantes — métodos estáticos
```

- **`*_viewmodel.dart`**: uma classe `@immutable` com `copyWith`, que
  descreve completamente UMA instância do componente (variante,
  tamanho, texto, ícone, callbacks, estados como `isSelected` /
  `isEnabled` / `isLoading`). Não tem lógica de UI nem regra de negócio.
- **`*_component.dart`**: um `StatelessWidget` que recebe o ViewModel e
  só sabe desenhá-lo. Não decide quais variantes existem — apenas
  pinta o que recebe. Isso o torna 100% testável e reutilizável.
- **`*_factory.dart`**: métodos estáticos (`ActionButtonFactory.primary(...)`,
  `.outlineChip(...)`, etc.) que sabem montar as combinações válidas de
  ViewModel — é aqui que fica o "conhecimento" de design system (quais
  variantes existem, quais os tamanhos padrão etc.). Cada factory
  também expõe um `showcaseCatalog()` usado pelas telas-espelho.

Esse padrão é comum em codebases Flutter de médio/grande porte porque
separa claramente **UI pura** (fácil de testar/prever) de **regras de
variantes** (fácil de estender sem tocar na UI) — parecido com o
espírito de Storybook/Design Tokens no mundo web.

### Como adicionar um novo componente

1. Crie `lib/components/meu_componente/` com os 3 arquivos no mesmo
   padrão (copie um existente como esqueleto).
2. Implemente `showcaseCatalog()` na factory retornando
   `List<ShowcaseSection<MeuComponenteViewModel>>`.
3. Crie `lib/screens/sample_meu_componente_screen.dart` usando
   `ShowcaseScaffold` (veja `lib/common/showcase_scaffold.dart`) —
   normalmente são só ~15 linhas.
4. Adicione uma entrada no menu em `lib/main.dart`.

---

## 3. Estrutura de pastas

```
lib/
├── common/                  # Tokens e utilitários compartilhados
│   ├── app_colors.dart          # Paleta extraída do Figma
│   ├── app_typography.dart      # Escala tipográfica (Sora)
│   ├── app_assets.dart          # Caminhos de imagens
│   ├── showcase_models.dart     # Modelo genérico de "seção de exemplos"
│   └── showcase_scaffold.dart   # Layout genérico das telas-espelho
├── components/
│   ├── action_button/       # Botões: primary, secondary, outline, ghost, icon
│   ├── tab_bar/              # Category chips e bottom navigation
│   └── list_items/           # Card de produto e linha de carrinho
├── screens/
│   ├── sample_action_button_screen.dart  # Espelho: todas as variantes de botão
│   ├── sample_tab_bar_screen.dart        # Espelho: todas as variantes de tab bar
│   ├── sample_list_items_screen.dart     # Espelho: todas as variantes de card
│   └── sample_screen.dart                # Tela principal montada (Home real)
└── main.dart                 # Índice de navegação entre as telas de demo
```

Cada tela "de verdade" (`sample_screen.dart`) tem uma tela-espelho
correspondente (`sample_<componente>_screen.dart`) que existe **só**
para expor visualmente as variáveis/variantes daquele componente —
exatamente como pedido: *"para cada tela deve ter uma tela/espelhada
que contemple as diferentes variáveis dos botões"*.

---

## 4. Como rodar

```bash
flutter pub get
flutter run
```

O app abre num **índice** com 4 opções: a tela principal montada e as
3 telas-espelho de componentes.

### Assets de imagem

Este template não inclui os PNGs originais do Figma (o link de
exportação do MCP expira em 7 dias). `lib/common/app_assets.dart`
aponta para `assets/images/<nome>.png` — exporte as imagens reais do
Figma (nó **Home → Product → Image**) para essa pasta com esses nomes,
ou simplesmente deixe como está: todo componente de imagem tem
`errorBuilder` com fallback visual (ícone de café sobre fundo creme),
então o template roda "out of the box" mesmo sem os assets.

### Fonte

A tipografia usa o pacote [`google_fonts`](https://pub.dev/packages/google_fonts)
para carregar **Sora** dinamicamente (não precisa baixar `.ttf` manualmente).
Se preferir embutir a fonte localmente (sem depender de rede em tempo
de execução), baixe os arquivos em [fonts.google.com/specimen/Sora](https://fonts.google.com/specimen/Sora),
coloque em `assets/fonts/` e declare em `pubspec.yaml` na seção `fonts:`,
trocando `GoogleFonts.sora(...)` por `TextStyle(fontFamily: 'Sora', ...)`
em `app_typography.dart`.

---

## 5. Customizando o template

- **Trocar a paleta**: edite os 5 valores em `app_colors.dart`. Todo o
  app se atualiza sozinho (nenhuma cor está "hardcoded" nos componentes).
- **Adicionar uma variante de botão**: adicione um método na
  `ActionButtonFactory` e um item no `showcaseCatalog()` — a tela de
  showcase reflete automaticamente.
- **Trocar o cardápio de exemplo**: edite `ListItemFactory.demoMenu()`.
- **Ajustar layout da Home**: `lib/screens/sample_screen.dart` — é
  código simples de composição, sem lógica escondida.

---

## 6. Créditos

Design original: **JavaGem — Coffee Shop Mobile App Design**, arquivo
Community do Figma. Este template reimplementa os tokens visuais em
código Dart para fins de estudo/demonstração de arquitetura Flutter —
não redistribui os assets binários originais do arquivo Figma.
