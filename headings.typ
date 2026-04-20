// ============================================================
// 标题样式定义
// ============================================================

#let apply-heading-style(cfg, body) = {
  // 构建标题编号渲染逻辑
  let num-config = cfg.heading.numbering
  let numbering-fn = if num-config == none {
    none
  } else if type(num-config) == function {
    num-config
  } else if type(num-config) == array {
    if num-config.len() == 0 {
      "1."
    } else {
      (..nums) => {
        let pos = nums.pos()
        let level = pos.len()
        if level == 0 { return none }
        let n = pos.last()
        // 确保层级索引不越界，超出的层级默认使用最后一个格式
        let format = num-config.at(calc.min(level - 1, num-config.len() - 1))
        numbering(format, n)
      }
    }
  } else if cfg.heading.numbering-only-current {
    (..nums) => {
      let pos = nums.pos()
      if pos.len() == 0 { return none }
      numbering(num-config, pos.last())
    }
  } else {
    num-config
  }

  // 应用计算出的编号函数
  set heading(numbering: numbering-fn)

  // 统一让标题与下文粘连，避免孤行标题
  show heading: set block(sticky: true)

  // 标题全局拦截转换：应用字号、颜色、字体
  show heading: it => {
    let level = it.level
    let styles = cfg.heading.styles
    // 按照层级读取，若层级超出数组长度，则默认采用最后一个样式
    let h-cfg = styles.at(calc.min(level - 1, styles.len() - 1))

    set text(
      font: cfg.font.heading,
      size: h-cfg.size,
      style: h-cfg.style,
      weight: h-cfg.weight,
      fill: cfg.color.heading,
    )
    set block(above: h-cfg.above, below: h-cfg.below)
    show math.equation: set text(size: h-cfg.size)

    it // 渲染应用好参数的标题
  }

  body
}
