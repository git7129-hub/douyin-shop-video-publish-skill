# Changelog

本技能仓库的版本记录。每次更新递增版本号并创建 GitHub Release（tag = `vX.Y.Z`），Release 说明取对应版本段落。

## v2.0.9

**更新了什么（2026-09-29）**
- **窄视口店铺切换方案（已验证）**：视口 639px 下抖店首页店铺名/切换入口在视口外，JS `document.documentElement.style.zoom='0.5'` 缩放后 click_xy 打开「切换组织/店铺」弹窗选店；导航后 zoom 丢失需重设（SKILL 问题15）
- **微盘下载按钮隐藏解决**：窄视口下响应式 header 隐藏下载按钮，改从 `bu.network_requests()` 抓取 downloadobject 直链下载（URL 含 base64 票据不可硬抄，每次导航后重抓）
- **商品编号查询纠错**：发布面板商品弹窗区分「商品名称」/「商品编号」两个输入框，编号必须输入编号框 + 真 submit「查询」按钮（SKILL 已验证操作细节）
- **回填行号映射教训（重要）**：名称框 Excel 行号 = 数据行号 + 1（E422=数据行421），跳转一律用 `E{数据行+1}`，修改前验证编辑框显示目标单元格当前值，提交后回读 ±1 行（SKILL 问题16）
- **WebView 键盘阻塞替代方案**：`bu.press_key`/`bu.type` 在本 WebView 被阻塞，统一改用 JS 事件链：名称框跳转用 setter+Enter 事件、编辑用 `execCommand('insertText')`、提交用 JS 派发 Enter（SKILL 已验证操作细节）
- **单元格清除安全流程**：清除单元格禁用 Ctrl+A+Backspace（会全表选中清空整表），必须编辑框内 `Range.selectNodeContents` + `insertText('')`（SKILL 回填安全流程）
- 新增运行记录 `2026-09-29运行记录.md` 与 `2026-09-29问题复盘报告.md`（docs/run-log/）

**如何操作（升级）**
- 将本仓库 `skills/douyin-shop-video-publish/` 整个目录覆盖到客户端 skills 根目录；
- 已有 `config.json` 无需改动（本版未变更配置结构）；
- 首次运行请先读 `SKILL.md` 与 `AGENT-GUIDE.md`，按「全表扫描 → 动态发现店铺 → 逐店处理」流程执行。
## v2.0.8

**更新了什么**
- 新增**视频文件生命周期管理（方案 B）**：发布成功且任务表回填验证通过后，视频自动移入 `paths.video_dir/archive/` 归档；每次运行开始时自动清理超过 `rules.archive_keep_days` 天（默认 30）的归档文件（填 `0`=发布后直接删除）
- **视频暂存目录改为技能目录内相对路径**：`paths.video_dir` 默认 `./video_tmp`（相对技能目录，与技能保存在一起便于整理），支持绝对路径覆盖；目录缺失仍询问是否创建，不报错中断
- 断点续跑规则补充：归档目录文件视为已发布完成，不参与续跑/防重复判断

**如何操作（升级）**
- 将本仓库 `skills/douyin-shop-video-publish/` 整个目录覆盖到客户端 skills 根目录；
- 已有 `config.json` 中若配置了旧的 `paths.video_dir`（如 `D:\douyinshopvideo_publish\`）：不填则自动使用新默认 `./video_tmp`（技能目录下）；想继续用原绝对路径则保留原值即可；
- 想改变清理周期：在 `config.json` 的 `rules.archive_keep_days` 填天数（默认 30，`0`=发布后立即删除）；
- 首次运行请先读 `SKILL.md` 与 `AGENT-GUIDE.md`，按「全表扫描 → 动态发现店铺 → 逐店处理」流程执行。

## v2.0.6

**更新了什么**
- 仓库内容范围明确：技能本体 + 配置 + 引导文档 + **运行记录（docs/run-log/，问题→解决、规则演进，作为技能进化依据，保留上传）** + 版本记录；
- 仅移除与技能运行无关的内容：README / SKILL.md 中的同步脚本与同步机制描述；同步脚本（本地工具）不随仓库发布

**如何操作（升级）**
- 将本仓库 `skills/douyin-shop-video-publish/` 整个目录覆盖到客户端 skills 根目录即可（技能目录内 README.md 有安装说明）；
- 已有 config.json 无需改动（本版未变更配置结构）；未配置过则复制 `config.example.json` 为 `config.json`，按 `CONFIG-GUIDE.md` 填写；
- 首次运行请先读 `SKILL.md` 与 `AGENT-GUIDE.md`，按「全表扫描 → 动态发现店铺 → 逐店处理」流程执行。

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
