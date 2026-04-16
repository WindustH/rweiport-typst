// ============================================================
// Typst 文档模板主入口
// ============================================================
#import "constants.typ": *
#import "utils.typ": *
#import "quotes.typ": *
#import "headings.typ": apply-heading-style

// 定义一个函数，包含所有全局样式设置
#let apply-style(body) = {
  // 1. 设置默认字体与数学字体
  set text(font: fonts.main, size: spacing.text-size, cjk-latin-spacing: spacing.cjk-latin-spacing)
  show math.equation: set text(font: fonts.math, size: spacing.math-size)

  // 2. 代码块样式设置
  show raw: set text(font: fonts.code)
  show raw: it => {
    if it.block {
      v(code-block.v-spacing)
      block(
        fill: rgb(colors.raw-bg),
        radius: code-block.radius,
        outset: (y: code-block.outset-y),
        inset: (x: code-block.inset-x),
      )[
        #set text(size: font-sizes.code-block)
        #it
      ]
      v(code-block.v-spacing)
    } else {
      box(
        fill: rgb(colors.raw-bg),
        radius: code-inline.radius,
        outset: (y: code-inline.outset-y),
        inset: (x: code-inline.inset-x),
      )[
        #set text(size: font-sizes.code-block)
        #it
      ]
    }
  }

  // 3. 页面与段落布局
  set page(paper: page-config.paper, margin: (x: page-config.margin-x, y: page-config.margin-y))
  set par(
    spacing: spacing.par,
    first-line-indent: spacing.first-line-indent,
    justify: true,
    leading: spacing.par-leading,
  )

  // 4. 链接样式
  show link: set text(colors.link)
  show ref: set text(colors.link)

  // 5. 应用压缩后的标题排版样式
  show: apply-heading-style

  body
}

// 供用户调用的模板核心外壳函数
#let init(
  title: none,
  authors: none,
  date: none,
  info: none,
  doc,
) = {
  // 文档 PDF 元数据注入
  set document(title: title, author: authors-to-string(authors))

  // 【修复分页问题】：将样式作为整体规则提前应用
  // 这样 set page(...) 就会作用于包含标题的整个文档，不会造成中途断页
  show: apply-style

  // 生成封面与标题信息区，添加 sticky: true 确保其与后续正文粘连
  if title != none {
    block(sticky: true)[
      #set text(font: fonts.heading)
      #grid(columns: (1fr, 1fr))[
        #align(center)[
          #text(size: font-sizes.title, weight: text-styles.weight-bold, fill: colors.heading)[#title]
          #v(title-area.v-after-title)
        ]
      ][
        #if authors != none [
          #align(center)[
            #text(size: font-sizes.author, weight: text-styles.weight-bold, fill: colors.heading)[#format-authors(
              authors,
            )]
            #v(title-area.v-after-info)
          ]
        ]
        #if info != none [
          #align(center)[
            #text(size: font-sizes.info, fill: colors.info)[#format-info(info)]
            #v(title-area.v-after-info)
          ]
        ]
        #if date != none [
          #align(center)[
            #text(size: font-sizes.info, fill: colors.info)[#date]
            #v(title-area.v-after-date)
          ]
        ]
      ]
      #line(length: 100%, stroke: title-area.line-stroke + colors.line)
      #v(title-area.v-after-line)
    ]
  }

  // 渲染剩余正文
  doc
}
