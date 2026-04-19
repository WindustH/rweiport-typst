// ============================================================
// 常量定义：字体与颜色配置
// ============================================================

// 字体配置字典
#let fonts = (
  main: ("SF Pro Text", "HYQiHeiClassic"),
  math: "STIX Two Math",
  code: "Maple Mono Normal NF",
  heading: ("Lora", "HYXuanSong"),
)

// 颜色配置字典 - 直接使用 rgb() 函数
#let colors = (
  heading: rgb(34, 34, 94),
  line: rgb(112, 112, 146),
  info: rgb(67, 76, 125),
  link: rgb(20, 20, 180),
  raw-bg: rgb(244, 244, 244),
  raw-border: rgb(113, 113, 113), // 代码块边框颜色
  // 引用块 (Quote) 的语义化色彩
  quote: (
    primary: (bg: rgb(242, 249, 255), border: rgb(46, 80, 129), text: rgb(40, 59, 75)),
    warning: (bg: rgb(255, 250, 235), border: rgb(221, 104, 0), text: rgb(184, 92, 0)),
    tip: (bg: rgb(243, 255, 243), border: rgb(32, 127, 37), text: rgb(28, 99, 40)),
    error: (bg: rgb(255, 242, 242), border: rgb(220, 38, 38), text: rgb(185, 28, 28)),
    default: (bg: rgb(247, 247, 250), border: rgb(113, 113, 139), text: rgb(40, 40, 70)),
  ),
)

// 字体大小配置
#let font-sizes = (
  title: 2.4em,
  author: 1.2em,
  info: 0.9em,
  code-block: 1.0em,
)

// 标题样式配置
#let heading-sizes = (
  "1": 1.20em,
  "2": 1.1em,
  "3": 1.05em,
  "4": 1.0em,
)

#let heading-spacing = (
  "1": (above: 1.3em, below: 1.2em),
  "2": (above: 1.1em, below: 0.9em),
  "3": (above: 1.0em, below: 0.8em),
  "4": (above: 0.9em, below: 0.8em),
)

#let heading-styles = (
  "1": "normal",
  "2": "normal",
  "3": "normal",
  "4": "italic",
)

// 间距配置
#let spacing = (
  par: 1.2em,
  par-leading: 1.10em,
  first-line-indent: 0em,
  cjk-latin-spacing: auto,
  text-size: 1em,
  math-size: 1em,
)

// 页面配置
#let page-config = (
  paper: "a4",
  margin-x: 2.2cm,
  margin-y: 1.5cm,
)

// 代码块配置
#let code-block = (
  radius: 0.5em,
  outset-y: 1.5em,
  inset-x: 1.5em,
  v-spacing: 1.5em,
)

#let code-inline = (
  radius: 2pt,
  outset-y: 0.35em,
  inset-x: 0.3em,
)

// 边框粗细配置
#let border-thickness = (
  quote-left: 4.0pt, // 引用块左侧粗线
  quote-other: 0.8pt, // 引用块其他边细线
  raw: 0.8pt, // 代码块边框
)

// 引用块配置
#let quote-defaults = (
  radius: 2pt,
  inset: (left: 16pt, y: 18pt, right: 25pt),
  width: 100%,
)

// 标题区域配置
#let title-area = (
  v-after-title: 0.5cm,
  v-after-info: 0.3cm,
  v-after-date: 0.2cm,
  v-after-line: 0.3cm,
  line-stroke: 0.5pt,
)

// 文本样式配置
#let text-styles = (
  weight-bold: "bold",
)
