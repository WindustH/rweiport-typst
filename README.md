# Rweiport Template

`Rweiport` 是一个现代、高颜值且具备强大配置覆写能力的 Typst 模板。它分离了所有的常量样式，使得在调用模板时能够以统一、清晰的层次结构轻松自定义各类表现形式，而无需改动核心源码。

## 特性说明
- **层级化配置设计**：将杂乱的配置（字号、颜色、粗细等）归纳到 `config` 嵌套字典中。
- **现代化页面布局与代码块**：具备漂亮的代码块渲染以及 Cyberdream 高亮主题（若可用）。
- **完全解耦的引用组件**：内置多种带语义色的提示块（Quote Block），并提供随心所欲的边框控制。
- **防止孤行标题**：所有标题会自动利用 `sticky: true` 吸附到段落中。

## 目录结构
- `main.typ`: 模板主入口文件，包含供外部调用的 `init` 函数。
- `constants.typ`: 提供经过结构化整理的 `default-config`（默认全局配置）。
- `headings.typ`: 统一定制各种层级的标题尺寸、颜色及间距行为。
- `quotes.typ`: 提供 `quote-primary`, `quote-warning`, `quote-tip`, `quote-error` 四种带语义化颜色的灵活引用块组件。
- `utils.typ`: 定义了深层合并 `deep-merge`、封面数据格式化、`make-title` 标题页生成、`split-line` 分隔线等工具函数。

## 配置字典 (config) 详解

模板中所有的可变设置都统一在嵌套字典中，你可以在 `main.typ` 的 `init` 入口处通过传入 `config` 参数对这些默认值进行局部重写。下面是核心配置项树：

- **`font`**: 字体设置
  - `main`: 正文主字体 (例如 `("SF Pro Text", "HYQiHeiClassic")`)
  - `math`: 数学公式字体
  - `code`: 代码字体
  - `heading`: 标题专属字体
- **`color`**: 颜色设置
  - `heading`, `line`, `info`, `link`: 基础UI元素的色彩
  - `raw-bg`, `raw-border`: 代码块背景与边框色彩
  - `quote`: 引用块的语义化色彩 (`primary`, `warning`, `tip`, `error` 的 `bg`、`border`、`text` 色彩)
- **`size`**: 尺寸字号设置
  - `text`, `math`: 基础字号
  - `title`, `author`, `info`: 封面文字的字号
  - `code-block`: 代码块字号
- **`heading`**: 标题细节
  - `numbering`: 标题编号样式，默认为 `"1.1"`。您可以传入：
    - **字符串**（如 `"1. a."`）。
    - **数组**（如 `("一、", "I、", "A、", "1.")`）：这将自动为各级标题使用对应的格式，并且**默认只显示当前层级**。如果层级超出了数组长度，会统一使用数组中的最后一个格式。
    - **函数**（如 `(..nums) => { ... }`）：实现完全自由的控制。
  - `numbering-only-current`: 设为 `true` 时，若使用**字符串**编号，则仅显示当前层级的序号而隐藏父级前缀（相当于仅截取最后一个序号并进行格式化）。
  - `styles`: 一个数组，按顺序决定了各级标题专属的 `size`, `above`（上方间距）, `below`（下方间距）, `style`, `weight` 等。超出数组长度的级别将使用最后一个样式。
- **`code`**: 代码块与行内代码样式
  - `theme`: 代码高亮主题，默认为 `"cyberdream-light.tmTheme"`，你可以将其设为其他 `tmTheme` 或 `none` 以使用默认主题。
  - `block`: 多行代码块的 `radius`、`outset-y` 等配置。
  - `inline`: 行内代码的 `radius` 等，以及专有的 `bg-darken` 属性（默认 `8%`），用于控制在引用块中时，行内代码背景相较于底色加深的比例。
- **`spacing`**: 间距排版配置
  - `par`, `par-leading`, `first-line-indent`
- **`page`**: 页面设置
  - `paper` (如 `"a4"`), `margin-x`, `margin-y` 
- **`quote`**: 引用块尺寸设置
  - `thick-stroke` (加粗边框尺寸, 默认 4.0pt), `thin-stroke` (非加粗尺寸, 默认 0.8pt), `radius`, `inset` 等。

## 使用方法

在您自己的 `.typ` 文件中引入模板，传入您的自定义配置进行覆写即可：

```typst
#import "main.typ": init, make-title, split-line
#import "quotes.typ": quote-primary, quote-warning

// 初始化模板，设置全局配置
#show: doc => init(
  config: (
    font: (
      main: ("Times New Roman", "SimSun"),
    ),
    color: (
      heading: rgb(150, 40, 40), // 让标题变为红色
    ),
    page: (
      margin-x: 3cm, // 让左右边距变得更宽
    )
  ),
  doc,
)

// 生成封面标题页（可选）
#make-title(
  title: "我的示例文档",
  authors: (
    (name: "张三", affiliation: "某某大学", email: "zhangsan@example.com"),
    (name: "李四", affiliation: "某某公司"),
  ),
  date: "2024 年 5 月",
  info: (
    "课程": "计算机科学",
    "学号": "2024001",
  ),
)

// 插入分隔线（无需传入配置）
#split-line()

= 一级标题
（此处标题的字体、颜色、间距都已自动适配您的新规则）

#quote-primary(stroke-direction: "top")[这是一条带有上边框的提示]
#quote-warning(all-borders: false, has-thick-stroke: false)[这是最极端的案例：完全没有边框，只剩下背景色]
```

### 核心函数说明

- **`init(config, doc)`**: 初始化模板，设置全局样式。必须在文档开头调用。
- **`make-title(title, authors, date, info)`**: 生成封面标题页，设置 PDF 元数据。可选调用。
- **`split-line(length)`**: 插入分隔线，样式自动跟随配置。可在文档任意位置使用。
