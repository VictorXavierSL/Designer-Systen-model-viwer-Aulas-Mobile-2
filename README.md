# Coffee Design System — Catálogo de Componentes

Catálogo de sistema de design em Flutter/Dart, extraído do arquivo Figma
**["JavaGem — Coffee Shop Mobile App Design" (Community)](https://www.figma.com/design/JpAfa1wvkvsNYCqNHDupoe/Coffee-Shop-Mobile-App-Design--Community-)**.

> Este projeto é um **catálogo vivo de design system** — como um
> Storybook para Flutter. Ele existe para documentar e exercitar cada
> token e cada variação de componente (cor, tamanho, estado, tema claro
> e escuro), não para ser o app final. Use-o como referência/ponto de
> partida ao construir o produto real.

---

## 1. O que o catálogo mostra

| Seção | Conteúdo |
|---|---|
| **Foundations** | Todos os tokens de cor do tema ativo + a escala tipográfica (Sora) |
| **Button** | `primary`, `secondary` e `icon` — cada um por tamanho e estado. O botão de **adicionar item** é um Icon Button e está catalogado explicitamente |
| **Selectable Item** | Chips de seleção (não são botões de ação): seletor de tamanho `S/M/L` e abas de categoria |
| **Navigation** | Abas de categoria (compostas a partir do Selectable Item) e navegação inferior |
| **Card & List Item** | Card de produto e linha de carrinho, em diferentes estados |
| **Composição de Uso** | Os componentes acima combinados em uma tela real (Home) |

Um botão no canto superior direito de **qualquer** tela alterna entre
tema **claro** e **escuro** instantaneamente — todos os tokens e
componentes reagem, porque nenhuma cor está fixa no código: tudo é lido
por papel semântico (`context.colors.primary`, `context.colors.surface`
etc.), nunca por valor hexadecimal direto.

---

## 2. Tokens de cor: claro e escuro

| Token semântico | Light (Figma) | Dark (extensão do template) |
|---|---|---|
| `primary` | `#C67C4E` | `#C67C4E` (mesma cor de marca) |
| `onPrimary` | `#FFFFFF` | `#FFFFFF` |
| `secondary` | `#EDD6C8` | `#4A372E` |
| `onSecondary` | `#C67C4E` | `#EFC9A8` |
| `background` | `#F9F2ED` | `#1B1512` |
| `surface` | `#FFFFFF` | `#241C18` |
| `onSurface` | `#313131` | `#F5EDE8` |
| `textSecondary` | `#8B8B8B` | `#B4A79E` |
| `border` | `#E3E3E3` | `#3A2F29` |
| `heroBackground` | `#313131` | `#120D0B` |
| `danger` / `success` | `#E05C4E` / `#3E9B5B` | `#E9897C` / `#6FC08A` |

O arquivo Figma original só define a paleta **clara** (frame "Color
Guide"). Os valores de tema escuro são uma extensão deste template,
derivados a partir da paleta clara respeitando contraste. Tudo isso
vive em `lib/common/app_colors.dart` (paleta bruta) e
`lib/common/app_color_tokens.dart` (mapeamento semântico por tema).

---

## 3. Padrão de projeto: Component / ViewModel / Factory

Cada componente reutilizável em `lib/components/<nome>/` segue sempre a
mesma estrutura de 3 arquivos — um mini-MVVM combinado com o padrão
**Factory** para criação de variantes:

```
components/<nome>/
├── <nome>_component.dart    # A UI Visual — StatelessWidget "burro"
├── <nome>_viewmodel.dart    # O Estado e Dados — classe imutável
└── <nome>_factory.dart      # O Criador de Variantes — métodos estáticos
```

- **`*_viewmodel.dart`**: classe `@immutable` com `copyWith`, descreve
  completamente UMA instância do componente. Sem lógica de UI, sem
  regra de negócio.
- **`*_component.dart`**: `StatelessWidget` que só desenha o ViewModel
  recebido, lendo cor por papel semântico via `context.colors` (nunca
  `Color(0xFF...)` direto) — é isso que faz o tema escuro funcionar em
  todo o sistema automaticamente.
- **`*_factory.dart`**: métodos estáticos que sabem montar as
  combinações válidas de ViewModel, e um `showcaseCatalog()` — usado
  pelas telas de catálogo para renderizar TODAS as variações
  automaticamente.

### Por que `Button` e `Selectable Item` são componentes separados

Um botão **dispara uma ação** (Buy Now, adicionar item, voltar). Um
item selecionável **representa um estado dentro de um grupo** (qual
tamanho está escolhido, qual categoria está ativa). São conceitos
semanticamente diferentes — por isso vivem em componentes e catálogos
próprios (`action_button/` e `selectable_chip/`), mesmo compartilhando
influências visuais (ambos usam formato de pílula).

### Como adicionar um novo componente

1. Crie `lib/components/meu_componente/` com os 3 arquivos no mesmo
   padrão (copie um existente como esqueleto).
2. Leia cor sempre via `context.colors.<papel>` — nunca hardcode.
3. Implemente `showcaseCatalog()` na factory retornando
   `List<ShowcaseSection<MeuComponenteViewModel>>`.
4. Crie `lib/screens/<nome>_screen.dart` usando `ComponentCatalogScaffold`
   (veja `lib/common/showcase_scaffold.dart`) — normalmente ~15 linhas.
5. Adicione uma entrada em `DesignSystemHomeScreen` (`lib/main.dart`).

---

## 4. Estrutura de pastas

```
lib/
├── common/
│   ├── app_colors.dart          # Paleta bruta (Figma light + extensão dark)
│   ├── app_color_tokens.dart    # Tokens semânticos por tema (ThemeExtension)
│   ├── app_theme.dart           # Monta ThemeData light/dark + context.colors
│   ├── theme_controller.dart    # Estado global do tema (claro/escuro)
│   ├── theme_toggle_button.dart # Botão de alternância reutilizável
│   ├── app_typography.dart      # Escala tipográfica (Sora), sem cor fixa
│   ├── app_assets.dart          # Caminhos de imagens
│   ├── showcase_models.dart     # Modelo genérico de "seção de exemplos"
│   └── showcase_scaffold.dart   # Layout genérico das telas de catálogo
├── components/
│   ├── action_button/       # Botão de ação: primary, secondary, icon (inclui "add item")
│   ├── selectable_chip/     # Item selecionável: seletor de tamanho, aba de categoria
│   ├── tab_bar/             # Navegação: categorias (compostas de selectable_chip) + bottom nav
│   └── list_items/          # Card de produto e linha de carrinho
├── screens/
│   ├── foundations_screen.dart           # Catálogo: cores + tipografia
│   ├── sample_action_button_screen.dart  # Catálogo: Button
│   ├── selectable_items_screen.dart      # Catálogo: Selectable Item
│   ├── sample_tab_bar_screen.dart        # Catálogo: Navigation
│   ├── sample_list_items_screen.dart     # Catálogo: Card & List Item
│   └── sample_screen.dart                # Composição de uso (Home real)
└── main.dart                  # Landing page do catálogo + tema global
```

---

## 5. Como rodar

```bash
flutter pub get
flutter run
```

O app abre na landing do catálogo, organizada em **Foundations**,
**Components** e **Preview**. O ícone de sol/lua na barra superior de
qualquer tela alterna entre os temas claro e escuro.

### Assets de imagem

`lib/common/app_assets.dart` aponta para `assets/images/<nome>.png`.
Exporte as imagens reais do Figma (nó **Home → Product → Image**) para
essa pasta, ou deixe como está: todo componente de imagem tem
`errorBuilder` com fallback visual, então o catálogo roda "out of the
box" mesmo sem os assets.

### Fonte

A tipografia usa [`google_fonts`](https://pub.dev/packages/google_fonts)
para carregar **Sora** dinamicamente. Para embutir a fonte localmente
(sem depender de rede em tempo de execução), baixe os arquivos em
[fonts.google.com/specimen/Sora](https://fonts.google.com/specimen/Sora),
declare em `pubspec.yaml` e troque `GoogleFonts.sora(...)` por
`TextStyle(fontFamily: 'Sora', ...)` em `app_typography.dart`.

---

## 6. Customizando o template

- **Trocar a paleta**: edite `app_colors.dart` (valores brutos) e/ou
  `app_color_tokens.dart` (mapeamento semântico). Todo o app — em
  ambos os temas — se atualiza sozinho.
- **Adicionar uma variação de botão**: adicione um método/entrada na
  `ActionButtonFactory` e no `showcaseCatalog()`.
- **Trocar o cardápio de exemplo**: edite `ListItemFactory.demoMenu()`.
- **Ajustar a Home composta**: `lib/screens/sample_screen.dart`.

---

## 7. Créditos

Design original: **JavaGem — Coffee Shop Mobile App Design**, arquivo
Community do Figma. Este template reimplementa os tokens visuais em
código Dart para fins de estudo/demonstração de arquitetura Flutter —
não redistribui os assets binários originais do arquivo Figma.
