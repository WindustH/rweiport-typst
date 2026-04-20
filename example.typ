#import "main.typ": init
#import "quotes.typ": quote-error, quote-primary, quote-tip, quote-warning

#show: doc => init(
  title: "Rweiport 模板排版测试",
  authors: (
    (name: "Typst User", affiliation: "Open Source Uni", email: "user@example.com"),
    (name: "Designer", affiliation: "Creative Studio"),
  ),
  date: "2024 年 5 月 14 日",
  info: (
    "项目代码": "RWP-2024",
    "版本号": "v1.2",
  ),
  // 传入嵌套字典覆盖任意属性
  config: (
    color: (
      heading: rgb(180, 50, 50), // 标题使用暗红色
    ),
    page: (
      margin-x: 3.5cm, // 覆盖页面布局：左右边距拉宽
    ),
    heading: (
      // 直接传入数组！每一级将会使用对应的编号格式，且默认只显示本级
      // 超出数组长度的层级将一直使用最后一个格式
      numbering: ("一、", "I、", "A、", "1."),
    ),
  ),
  doc,
)

= 一级标题：核心功能介绍

这是一个旨在提供极其灵活组件、高度配置化的 Typst 模板。通过字典覆盖，您可以实现与源码解耦的文档样式定制。

== 二级标题与代码展示

下面是一个基于设置的代码块（字体与颜色会自动应用）：

```rust
fn main() {
    println!("Hello, Typst from Rweiport Template!");
}
```

=== 三级标题：丰富的引用组件

#quote-primary[这是默认行为的 `quote-primary`，它开启了四边描边，并且仅在左侧使用了粗描边。]

#quote-warning(stroke-direction: "top")[显式指定 `stroke-direction: "top"`，将上方边框加粗。]

#quote-tip(all-borders: false)[指定 `all-borders: false`，因此四周无细线，只在左侧（默认）留下了粗线。]

#quote-error(has-thick-stroke: false)[指定 `has-thick-stroke: false`，它展示了均匀的细边框，不再提供某一边的强调。]

#quote-warning(
  all-borders: false,
  has-thick-stroke: false,
)[这是最极端的案例：关闭了所有边框，完全没有描边，仅保留背景色。]

==== 四级标题：结语

以上是对 Rweiport 模板的快速预览，它结构清晰、方便拓展。
