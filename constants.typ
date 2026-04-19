// ============================================================
// 常量定义：全局配置默认值
// ============================================================

#let default-config = (
  // 1. 字体配置
  font: (
    main: ("SF Pro Text", "HYQiHeiClassic"), // 正文主字体
    math: "STIX Two Math",                   // 数学公式字体
    code: "Maple Mono Normal NF",            // 代码块/行内代码等宽字体
    heading: ("Lora", "HYXuanSong"),         // 标题字体
  ),

  // 2. 颜色配置
  color: (
    heading: rgb(34, 34, 94),
    line: rgb(112, 112, 146),
    info: rgb(67, 76, 125),
    link: rgb(20, 20, 180),
    raw-bg: rgb(244, 244, 244),
    raw-border: rgb(113, 113, 113),
    // 引用块 (Quote) 的语义化色彩 (背景、边框、文本)
    quote: (
      primary: (bg: rgb(242, 249, 255), border: rgb(46, 80, 129), text: rgb(40, 59, 75)),
      warning: (bg: rgb(255, 250, 235), border: rgb(221, 104, 0), text: rgb(184, 92, 0)),
      tip:     (bg: rgb(243, 255, 243), border: rgb(32, 127, 37), text: rgb(28, 99, 40)),
      error:   (bg: rgb(255, 242, 242), border: rgb(220, 38, 38), text: rgb(185, 28, 28)),
      default: (bg: rgb(247, 247, 250), border: rgb(113, 113, 139), text: rgb(40, 40, 70)),
    ),
  ),

  // 3. 尺寸与字号配置
  size: (
    text: 1em,           // 正文字号
    math: 1em,           // 数学公式字号
    title: 2.4em,        // 封面文档标题
    author: 1.2em,       // 封面作者名
    info: 0.9em,         // 封面附加信息
    code-block: 1em,   // 代码块字号
  ),

  // 4. 标题分级配置
  heading: (
    numbering: "1.1",       // 全局标题编号样式，设为 none 禁用。支持自定义函数
    numbering-only-current: false, // 是否仅显示当前层级编号（不显示前缀）
    "1": (size: 1.20em, above: 1.3em, below: 1.2em, style: "normal", weight: "bold"),
    "2": (size: 1.10em, above: 1.1em, below: 0.9em, style: "normal", weight: "bold"),
    "3": (size: 1.05em, above: 1.0em, below: 0.8em, style: "normal", weight: "bold"),
    "4": (size: 1.00em, above: 0.9em, below: 0.8em, style: "italic", weight: "bold"),
  ),

  // 5. 段落与间距配置
  spacing: (
    par: 1.2em,               // 段落间距
    par-leading: 1.10em,      // 行距
    first-line-indent: 0em,   // 首行缩进
    cjk-latin-spacing: auto,  // 中西文自动间距
  ),

  // 6. 页面布局
  page: (
    paper: "a4",      // 纸张大小
    margin-x: 2.2cm,  // 左右边距
    margin-y: 1.5cm,  // 上下边距
  ),

  // 7. 代码块与行内代码样式
  code: (
    theme: "cyberdream-light.tmTheme", // 代码高亮主题 (设为 none 可禁用)
    block: (radius: 0.5em, outset-y: 1.5em, inset-x: 1.5em, v-spacing: 1.5em, stroke-thickness: 0.8pt),
    inline: (radius: 2pt, outset-y: 0.35em, inset-x: 0.3em, stroke-thickness: 0.8pt, bg-darken: 8%),
  ),

  // 8. 引用块 (Quote) 基础属性
  quote: (
    thick-stroke: 4.0pt, // 强调边的粗细
    thin-stroke: 0.8pt,  // 默认其他边的粗细
    radius: 2pt,         // 圆角
    inset: (left: 16pt, y: 18pt, right: 25pt), // 内边距
    width: 100%,         // 块宽度
  ),

  // 9. 封面标题区布局
  title-area: (
    v-after-title: 0.5cm, // 标题下方间距
    v-after-info: 0.3cm,  // 信息下方间距
    v-after-date: 0.2cm,  // 日期下方间距
    v-after-line: 0.3cm,  // 分隔线下方间距
    line-stroke: 0.5pt,   // 分隔线粗细
  ),

  // 10. 全局文本样式
  text: (
    weight-bold: "bold",
  ),
)

// 定义供独立组件或深层引用的配置 State
#let template-config = state("rweiport-config", default-config)
