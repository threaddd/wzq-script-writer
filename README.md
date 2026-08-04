# 微证券视频号脚本撰写工作流（Skill）

> 面向微证券视频号信息流广告的 AI 工作流 Skill，覆盖**选题筛选 → 新闻分类 → 脚本生成 → 快讯文案 → 输出前核查**全流程。

[![Version](https://img.shields.io/badge/version-10.2-blue.svg)](./CHANGELOG.md)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](./LICENSE)
[![Skill Type](https://img.shields.io/badge/type-WorkBuddy_Skill-orange.svg)]()

---

## 这是什么

这是一套结构化 Prompt 工作流，用于处理微证券视频号信息流素材生产中的核心环节：

- **筛选选题**：先判断新闻是否值得做，命中黑名单直接止步
- **审核脚本**：检查已有文案的合规问题、主体问题和风险等级
- **生成脚本**：输出「新闻切入 + 产品衔接 + 行动引导」两段式脚本（v10 起已去掉前贴环节）
- **补充配套快讯**：同步产出短快讯文案，并标注字数

它既可以作为 **WorkBuddy Skill** 安装使用，也可以直接复制 [`instruction.md`](./instruction.md) 到任意支持长 Prompt 的对话式 LLM 中使用。

---

## 适用场景

✅ 适合：
- 微证券视频号信息流广告脚本撰写
- 金融券商类热点选题筛选
- 已有脚本的合规审核和改稿
- 根据新闻原文或脚本草稿快速出完整文案

❌ 不适合：
- 个股推荐、收益承诺、时机暗示类内容
- 政策、地缘、灾害、大宗负面事件相关选题
- 非投资场景、纯品牌传播或脱离股市映射的内容

---

## 当前版本亮点（v10.2）

- **结构全面重构**：从 485 行规则清单压缩到约 130 行，核心五段结构（分类 → 筛选 → 新闻切入 → 产品衔接 → 行动引导）清晰可执行
- **三类用户衔接模板**：不了解型 / 消息过载型 / 跃跃欲试型，每类对应不同的缺口和产品接入逻辑，不再套同一模板
- **产品衔接铁律明确**：禁止无逻辑并列贴产品，产品必须从新闻逻辑里生长出来
- **快讯轻量化**：结构简化为「热点事实 + 一个词过渡 + 轻 CTA」，控制在 20 字以内
- **写作规范强化**：禁用昨天/昨晚/今天等时效词、数据用模糊来源、不出现证券公司名字
- **11 类选题黑名单** + **12 条合规红线**，覆盖板块名/指数名/收益暗示等盲区
- **输出前核查清单（12 条）**：脚本和快讯生成后、输出前的二次自检步骤

---

## 工作流总览

```text
输入（新闻原文 / URL / 已有脚本）
     ↓
① 新闻分类（低门槛 / 高门槛）
     ↓
② 选题筛选 ⭐ 关键卡点
   ├ 11 类黑名单（命中任一类即止步）
   ├ 重复度轻量提示
   └ 3 大原则（紧迫性 / 重要性 / 接近性）
     ↓
   未通过 → 止步并给建议
   通过   → 继续
     ↓
③ 新闻切入（最多 2 个数字，禁用具体日期）
     ↓
④ 产品衔接（判断用户类型，三类模板轮换）
   ├ 不了解热点资讯型
   ├ 消息过载型
   └ 跃跃欲试型
     ↓
⑤ 行动引导（4 条 CTA 轮换，连续两条不重复）
     ↓
⑥ 快讯文案（≤ 25 字，CTA 类型轮换）
     ↓
⑦ 输出前核查清单（12 条逐项过）
     ↓
输出：结构化分析 + 完整脚本 + 快讯 + 日期 + 来源
```

---

## 核心规则

- **第二步未通过即停止后续输出**：命中黑名单或三大原则均不命中时，只输出筛选结果和建议
- **数据必须有来源且最多 2 个**：所有具体数据都要能追溯来源，用模糊表述（「据相关数据」）
- **严禁估算和推算数据**：换算值、预测值、口径混用都不能直接写进脚本
- **产品衔接不能并列贴**：产品必须从新闻逻辑里生长出来，不能突然插入
- **开头 / 衔接类型 / CTA 连续两条不重复**：避免模板化
- **语言必须通俗**：默认面向投资新手，不写行业黑话，不出现板块名/指数名/个股名

---

## 安装方式

### 方式 A：安装为 WorkBuddy Skill（推荐）

**从压缩包安装（无 GitHub 权限时使用）：**

1. 解压 `weizhengquan-script-writer.zip`，得到 `weizhengquan-script-writer/` 文件夹
2. 打开终端，`cd` 进入该文件夹
3. 执行安装脚本：
   ```bash
   bash scripts/install.sh        # macOS / Linux
   # 或用 PowerShell 以管理员身份运行：  .\scripts\install.ps1   （Windows）
   ```
4. 重启 WorkBuddy

脚本会自动把 Skill 复制到 `~/.workbuddy/skills/weizhengquan-script-writer/`。

**从 GitHub 安装：**

```bash
git clone https://github.com/threaddd/wzq-script-writer.git
cd wzq-script-writer
bash scripts/install.sh
```

安装后，在 WorkBuddy 中输入「按工作流写脚本」「筛选这条新闻」「审核这段微证券脚本」等表达，即可触发该 Skill。

### 方式 B：直接复制 Prompt 使用

打开 [`instruction.md`](./instruction.md)，复制全文到任意 LLM 对话中，再在末尾追加以下任一输入：

- 新闻原文
- 新闻链接 URL
- 已有脚本草稿

---

## 文件结构

```text
weizhengquan-script-writer/
├── SKILL.md                     Skill 主入口（frontmatter + 触发描述）
├── instruction.md               完整工作流指令（v10.2）
├── README.md                    项目说明文档（本文）
├── CHANGELOG.md                版本变更日志
├── CONTRIBUTING.md             协作与提交流程说明
├── LICENSE                     MIT 协议
├── references/                  参考规则文档
│   ├── blacklist.md             11 类选题黑名单详解
│   ├── glossary.md             专业词通俗化对照表
│   ├── compliance.md           12 条合规红线与案例
│   ├── identity-trigger.md     身份触发句六种角度（按需启用）
│   └── landing.md             三类用户衔接与 CTA 句式库
├── examples/                    使用示例
│   ├── 01-news-input.md       新闻原文输入示例
│   ├── 02-script-review.md    已有脚本审核示例
│   ├── 03-blocked.md          命中黑名单的止步示例
│   └── 04-url-input.md        直接给 URL 的输出示例
├── assets/                      说明图资源
│   ├── funnel-v3.jpg          工作流漏斗图
│   └── funnel-v3.svg          工作流漏斗图 SVG 版
└── scripts/                     安装与卸载脚本
    ├── install.sh              macOS / Linux 安装脚本
    ├── install.ps1             Windows 安装脚本
    └── uninstall.sh           卸载脚本
```

---

## 使用示例

### 输入：一条新闻原文

```text
请按 weizhengquan-script-writer 工作流分析以下新闻并生成脚本：

5月A股新开户276.53万户，同比大增77.76%……
```

### 输出：结构化分析 + 完整脚本 + 快讯

```text
【选题筛选】通过
【新闻分类】低门槛偏中
【主原则】接近性 + 紧迫性
【产品衔接类型】跃跃欲试型

【完整脚本】
5月大盘跌了1.06%，但这个月有将近280万人新开了股票账户。
今年前5个月累计开户已经达到去年全年的六成。为什么大盘没涨，反而越来越多人开户……
其实很多人看到这种消息，心里想着是该开个账户了，但总觉得开户流程麻烦……

感兴趣的话，点下方链接开个账户试试吧。

【快讯文案】5月A股新开户近280万，行情变化去微证券小程序看看（21字）
【日期】时间截止至 2026年5月末
【来源】财联社
```

更多示例见：

- [examples/01-news-input.md](./examples/01-news-input.md)
- [examples/02-script-review.md](./examples/02-script-review.md)
- [examples/03-blocked.md](./examples/03-blocked.md)
- [examples/04-url-input.md](./examples/04-url-input.md)

---

## 版本历史

- **v10.2**（当前）：核查清单精简为 12 条平铺；日期禁用词新增「今天」；SKILL/README/references 全面对齐 v10
- **v10.1**：新增「输出前核查清单」（脚本生成后二次自检）
- **v10.0**：重大重构，从规则堆叠到结构驱动；三类用户衔接模板；快讯轻量化
- **v9.x**：前贴/落点/路径分支旧结构（已废弃）

完整变更见 [`CHANGELOG.md`](./CHANGELOG.md)。

---

## 贡献说明

提交 Issue 或 PR 时，建议一并说明以下内容：

- 变更对应的合规边界或业务背景
- 是否影响输出格式、示例或引用规则
- 是否需要同步更新 `instruction.md`、`SKILL.md`、`CHANGELOG.md`

如有新增规则或示例，请同步更新版本说明，避免文档和指令脱节。

---

## License

MIT License，详见 [LICENSE](./LICENSE)
