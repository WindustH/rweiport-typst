// ============================================================
// 引用块样式定义 (全描边为默认：左侧粗线 + 四周描边)
// ============================================================
#import "constants.typ": colors, quote-defaults, border-thickness

// 通用引用块核心函数
#let quote(
  body,
  breakable: true,
  fill: colors.quote.default.bg,
  border-color: colors.quote.default.border,
  all-borders: true, // 默认开启全边框
  radius: quote-defaults.radius,
  inset: quote-defaults.inset,
  width: quote-defaults.width,
  text-fill: colors.quote.default.text,
  ..args,
) = {
  // 定义左侧粗线样式
  let left-side = (paint: border-color, thickness: border-thickness.quote-left)

  // 定义其他边（顶、右、底）的样式
  let other-side = if all-borders {
    (paint: border-color, thickness: border-thickness.quote-other)
  } else {
    none
  }

  block(
    breakable: breakable,
    fill: fill,
    // 默认显示四周描边，左侧保持 thickness
    stroke: (
      left: left-side,
      top: other-side,
      right: other-side,
      bottom: other-side,
    ),
    radius: radius,
    inset: if all-borders {
      // 开启全边框时，左右保持对称间距
      (left: inset.left, right: inset.left, y: inset.y)
    } else {
      inset
    },
    width: width,
    ..args,
  )[
    #set text(fill: text-fill)
    #body
  ]
}

// 便捷包装器 - 主要引用 (Primary)
#let quote-primary(body, breakable: true, all-borders: true, ..args) = quote(
  body,
  breakable: breakable,
  all-borders: all-borders,
  fill: colors.quote.primary.bg,
  border-color: colors.quote.primary.border,
  text-fill: colors.quote.primary.text,
  ..args,
)

// 便捷包装器 - 警告引用 (Warning)
#let quote-warning(body, breakable: true, all-borders: true, ..args) = quote(
  body,
  breakable: breakable,
  all-borders: all-borders,
  fill: colors.quote.warning.bg,
  border-color: colors.quote.warning.border,
  text-fill: colors.quote.warning.text,
  ..args,
)

// 便捷包装器 - 提示引用 (Tip)
#let quote-tip(body, breakable: true, all-borders: true, ..args) = quote(
  body,
  breakable: breakable,
  all-borders: all-borders,
  fill: colors.quote.tip.bg,
  border-color: colors.quote.tip.border,
  text-fill: colors.quote.tip.text,
  ..args,
)
