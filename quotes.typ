// ============================================================
// 引用块样式定义 (全描边为默认：左侧粗线 + 四周描边)
// ============================================================
#import "constants.typ": template-config

// 通用引用块核心函数
#let quote(
  body,
  breakable: true,
  fill: auto,
  border-color: auto,
  stroke-direction: "left", // 控制粗边的位置: "left", "right", "top", "bottom"
  all-borders: true, // 控制是否开启四周的默认边框
  has-thick-stroke: true, // 控制是否开启粗边框
  radius: auto,
  inset: auto,
  width: auto,
  text-fill: auto,
  ..args,
) = context {
  let cfg = template-config.get()

  let act-fill = if fill != auto { fill } else { cfg.color.quote.default.bg }
  let act-border = if border-color != auto { border-color } else { cfg.color.quote.default.border }
  let act-radius = if radius != auto { radius } else { cfg.quote.radius }
  let act-inset = if inset != auto { inset } else { cfg.quote.inset }
  let act-width = if width != auto { width } else { cfg.quote.width }
  let act-text-fill = if text-fill != auto { text-fill } else { cfg.color.quote.default.text }

  // 定义粗线样式和细线样式
  let thick-stroke = (paint: act-border, thickness: cfg.quote.thick-stroke)
  let thin-stroke = (paint: act-border, thickness: cfg.quote.thin-stroke)

  let base-stroke = if all-borders { thin-stroke } else { none }

  let s-left = base-stroke
  let s-right = base-stroke
  let s-top = base-stroke
  let s-bottom = base-stroke

  if has-thick-stroke {
    if stroke-direction == "left" { s-left = thick-stroke } else if stroke-direction == "right" {
      s-right = thick-stroke
    } else if stroke-direction == "top" { s-top = thick-stroke } else if stroke-direction == "bottom" {
      s-bottom = thick-stroke
    }
  }

  block(
    breakable: breakable,
    fill: act-fill,
    // 分别应用四周边框
    stroke: (
      left: s-left,
      right: s-right,
      top: s-top,
      bottom: s-bottom,
    ),
    radius: act-radius,
    inset: if all-borders {
      // 开启全边框时，左右保持对称间距
      (left: act-inset.left, right: act-inset.left, y: act-inset.y)
    } else {
      act-inset
    },
    width: act-width,
    ..args.named(),
  )[
    #set text(fill: act-text-fill)
    #state("rweiport-quote-ctx", ()).update(arr => arr + ((border: act-border, bg: act-fill),))
    #body
    #state("rweiport-quote-ctx", ()).update(arr => arr.slice(0, -1))
  ]
}

// primary
#let quote-primary(
  body,
  breakable: true,
  stroke-direction: "left",
  all-borders: true,
  has-thick-stroke: true,
  ..args,
) = context {
  let cfg = template-config.get()
  quote(
    body,
    breakable: breakable,
    stroke-direction: stroke-direction,
    all-borders: all-borders,
    has-thick-stroke: has-thick-stroke,
    fill: cfg.color.quote.primary.bg,
    border-color: cfg.color.quote.primary.border,
    text-fill: cfg.color.quote.primary.text,
    ..args.named(),
  )
}

// Warning
#let quote-warning(
  body,
  breakable: true,
  stroke-direction: "left",
  all-borders: true,
  has-thick-stroke: true,
  ..args,
) = context {
  let cfg = template-config.get()
  quote(
    body,
    breakable: breakable,
    stroke-direction: stroke-direction,
    all-borders: all-borders,
    has-thick-stroke: has-thick-stroke,
    fill: cfg.color.quote.warning.bg,
    border-color: cfg.color.quote.warning.border,
    text-fill: cfg.color.quote.warning.text,
    ..args.named(),
  )
}

// Tip
#let quote-tip(
  body,
  breakable: true,
  stroke-direction: "left",
  all-borders: true,
  has-thick-stroke: true,
  ..args,
) = context {
  let cfg = template-config.get()
  quote(
    body,
    breakable: breakable,
    stroke-direction: stroke-direction,
    all-borders: all-borders,
    has-thick-stroke: has-thick-stroke,
    fill: cfg.color.quote.tip.bg,
    border-color: cfg.color.quote.tip.border,
    text-fill: cfg.color.quote.tip.text,
    ..args.named(),
  )
}

// Error
#let quote-error(
  body,
  breakable: true,
  stroke-direction: "left",
  all-borders: true,
  has-thick-stroke: true,
  ..args,
) = context {
  let cfg = template-config.get()
  quote(
    body,
    breakable: breakable,
    stroke-direction: stroke-direction,
    all-borders: all-borders,
    has-thick-stroke: has-thick-stroke,
    fill: cfg.color.quote.error.bg,
    border-color: cfg.color.quote.error.border,
    text-fill: cfg.color.quote.error.text,
    ..args.named(),
  )
}
