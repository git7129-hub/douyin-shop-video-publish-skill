# Changelog

本技能仓库的版本记录。每次更新递增版本号并创建 GitHub Release（tag = `vX.Y.Z`），Release 说明取对应版本段落。

## v2.0.5

- **新增：标准 GitHub 发布流程**：每次同步递增版本号后自动创建 GitHub Release（tag `v2.0.5` + 变更说明），Releases 页面不再空白
- 新增仓库根 `CHANGELOG.md`，逐版本记录变更（同步脚本据此生成 Release 说明）

## v2.0.4

- 视频工作目录改为 `D:\douyinshopvideo_publish\`（内置 config.example.json）
- 视频工作目录不存在时：**询问用户是否创建**（同意 → 创建后继续；拒绝/不确定 → 暂停人工处理），不再直接报错中断（SKILL.md §5 + 默认业务规则 10）

## v2.0.3

- 默认业务规则 8 强化为可执行机制：启动时自动读取最近一次正确运行的记录（`paths.run_log_dir` 最新运行记录），优先复用已验证步骤
- 默认业务规则 9 新增：任务表存在未发布店铺 X 而当前仅处理店铺 Y 时 → 暂停询问是否新增；拒绝则停止该店并记录用户习惯，后续沿用不再询问，直到用户明确说新增

## v2.0.2

- 修正版本递增顺序（先递增后上传），远程版本与本地一致
- 内置任务表 / 商品ID表 / 违禁词表地址于 config.example.json（开箱即用，可覆盖）
- 明确「不保留登录状态」：技能不含任何 cookie/token，每次调用由 Agent 引导用户现场登录

## v2.0.0

- 初始可分享化版本：SKILL.md 自包含（YAML frontmatter + 章节式方法论 + 红线）
- 新增 config.example.json 配置模板、CONFIG-GUIDE.md（人看的配置引导）、AGENT-GUIDE.md（执行 Agent 机器级协议）
- 店铺清单跟随登录用户动态发现（`shops` 可留空）
