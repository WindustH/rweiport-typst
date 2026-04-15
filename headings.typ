// ============================================================
// 标题样式定义 (压缩字典匹配版)
// ============================================================
#import "constants.typ": colors, fonts, heading-sizes, heading-spacing, heading-styles

#let apply-heading-style(body) = {
  // 1. 设置标题基础编号与默认字体样式
  set heading(numbering: "1. ")
  show heading.where(level: 2): set heading(numbering: "1.1 ")

  show heading: set text(
    font: fonts.heading,
    weight: "bold",
    fill: colors.heading,
  )

  // 统一让标题与下文粘连，避免孤行标题
  show heading: set block(sticky: true)

  // 2. 利用字典压缩逐级调整代码
  // 统一的标题拦截转换
  show heading: it => {
    // 按照层级读取，若层级 > 4 则默认采用 level 4 的样式
    let level = str(it.level)
    let size = heading-sizes.at(level, default: heading-sizes.at("4"))
    let spacing-values = heading-spacing.at(level, default: heading-spacing.at("4"))
    let style = heading-styles.at(level, default: heading-styles.at("4"))

    set text(size: size, style: style)
    set block(above: spacing-values.above, below: spacing-values.below)
    show math.equation: set text(size: size)

    it // 渲染应用好参数的标题
  }

  body
}
