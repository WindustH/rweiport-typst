// ============================================================
// Typst 文档模板主入口
// ============================================================
#import "constants.typ": default-config, template-config
#import "utils.typ": deep-merge, format-authors, authors-to-string, format-info, split-line
#import "quotes.typ": *
#import "headings.typ": apply-heading-style

// 定义一个函数，包含所有全局样式设置
#let apply-style(cfg, body) = {
  // 1. 设置默认字体与数学字体
  set text(font: cfg.font.main, size: cfg.size.text, cjk-latin-spacing: cfg.spacing.cjk-latin-spacing)
  show math.equation: set text(font: cfg.font.math, size: cfg.size.math)
  
  if cfg.code.theme != none {
    set raw(theme: cfg.code.theme)
  }
  
  // 2. 代码块样式设置
  show raw: set text(font: cfg.font.code)
  show raw: it => context {
    let quote-ctx = state("rweiport-quote-ctx", ()).get()
    
    // 行内代码如果在 quote 中，则继承边框，并取背景色按配置变暗 (默认 8%)
    let inline-border = if quote-ctx.len() > 0 { quote-ctx.last().border } else { cfg.color.raw-border }
    let inline-bg = if quote-ctx.len() > 0 { quote-ctx.last().bg.darken(cfg.code.inline.bg-darken) } else { cfg.color.raw-bg }

    if it.block {
      v(cfg.code.block.v-spacing)
      block(
        fill: cfg.color.raw-bg,
        stroke: cfg.code.block.stroke-thickness + cfg.color.raw-border,
        radius: cfg.code.block.radius,
        outset: (y: cfg.code.block.outset-y),
        inset: (x: cfg.code.block.inset-x),
      )[
        #set text(size: cfg.size.code-block)
        #it
      ]
      v(cfg.code.block.v-spacing)
    } else {
      box(
        fill: inline-bg,
        stroke: cfg.code.inline.stroke-thickness + inline-border,
        radius: cfg.code.inline.radius,
        outset: (y: cfg.code.inline.outset-y),
        inset: (x: cfg.code.inline.inset-x),
      )[
        #set text(size: cfg.size.code-block)
        #it
      ]
    }
  }

  // 3. 页面与段落布局
  set page(paper: cfg.page.paper, margin: (x: cfg.page.margin-x, y: cfg.page.margin-y))
  set par(
    spacing: cfg.spacing.par,
    first-line-indent: cfg.spacing.first-line-indent,
    justify: true,
    leading: cfg.spacing.par-leading,
  )

  // 4. 链接样式
  show link: set text(cfg.color.link)
  show ref: set text(cfg.color.link)

  // 5. 应用压缩后的标题排版样式
  show: apply-heading-style.with(cfg)

  body
}

// 供用户调用的模板核心外壳函数
#let init(
  title: none,
  authors: none,
  date: none,
  info: none,
  config: (:),
  doc,
) = {
  // 合并用户配置和默认配置
  let cfg = deep-merge(default-config, config)

  // 更新 state，供脱离上下文档的组件（如引用块等）进行 context 读取
  template-config.update(cfg)

  // 文档 PDF 元数据注入
  set document(title: title, author: authors-to-string(authors))

  // 【修复分页问题】：将样式作为整体规则提前应用
  show: apply-style.with(cfg)

  // 生成封面与标题信息区，添加 sticky: true 确保其与后续正文粘连
  if title != none {
    block(sticky: true)[
      #set text(font: cfg.font.heading)
      #grid(columns: (1fr, 1fr))[
        #align(center)[
          #text(size: cfg.size.title, weight: cfg.text.weight-bold, fill: cfg.color.heading)[#title]
          #v(cfg.title-area.v-after-title)
        ]
      ][
        #if authors != none [
          #align(center)[
            #text(size: cfg.size.author, weight: cfg.text.weight-bold, fill: cfg.color.heading)[#format-authors(cfg, authors)]
            #v(cfg.title-area.v-after-info)
          ]
        ]
        #if info != none [
          #align(center)[
            #text(size: cfg.size.info, fill: cfg.color.info)[#format-info(cfg, info)]
            #v(cfg.title-area.v-after-info)
          ]
        ]
        #if date != none [
          #align(center)[
            #text(size: cfg.size.info, fill: cfg.color.info)[#date]
            #v(cfg.title-area.v-after-date)
          ]
        ]
      ]
      #split-line(cfg)
      #v(cfg.title-area.v-after-line)
    ]
  }

  // 渲染剩余正文
  doc
}
