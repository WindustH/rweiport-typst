// ============================================================
// 辅助工具与组件
// ============================================================
#import "constants.typ": template-config

// 字典深拷贝与合并工具
#let deep-merge(a, b) = {
  let res = a
  for (k, v) in b {
    if type(v) == dictionary and k in res and type(res.at(k)) == dictionary {
      res.insert(k, deep-merge(res.at(k), v))
    } else {
      res.insert(k, v)
    }
  }
  res
}

// 格式化作者列表，包含联系方式和机构
#let format-authors(cfg, authors) = {
  if authors == none { return none }
  if type(authors) == str { return authors }

  let count = authors.len()
  if count == 0 { return none }

  if type(authors.first()) == str { return authors.join(", ") }

  let formatted = authors.map(author => {
    let name = author.name
    let aff = if "affiliation" in author { [\ #author.affiliation] } else { [] }
    let email = if "email" in author { [\ #link("mailto:" + author.email)] } else { [] }
    [#name #aff #email]
  })

  return formatted.join([; ])
}

// 仅提取作者名字作为字符串（用于 PDF 元数据）
#let authors-to-string(authors) = {
  if authors == none { return none }
  if type(authors) == str { return authors }

  let count = authors.len()
  if count == 0 { return none }

  if type(authors.first()) == str { return authors.join(", ") }
  return authors.map(author => author.name).join(", ")
}

// 格式化额外信息 (如机构、班级等)
#let format-info(cfg, info) = {
  if info == none { return none }

  let items = ()
  for (key, value) in info.pairs() {
    items.push([#text(weight: cfg.text.weight-bold)[#key]: #value])
  }
  return items.join([ \ ])
}

// 分隔线组件（从 state 读取配置）
#let split-line(length: 100%) = context {
  let cfg = template-config.get()
  line(length: length, stroke: cfg.title-area.line-stroke + cfg.color.line)
}

// 生成封面标题
#let make-title(title: none, authors: none, date: none, info: none) = context {
  let cfg = template-config.get()

  // 设置 PDF 元数据
  set document(title: title, author: authors-to-string(authors))

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
          #text(size: cfg.size.author, weight: cfg.text.weight-bold, fill: cfg.color.heading)[#format-authors(
            cfg,
            authors,
          )]
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
    #split-line()
    #v(cfg.title-area.v-after-line)
  ]
}
