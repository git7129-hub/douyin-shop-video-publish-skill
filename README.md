# 抖店短视频自动发布 · Agent 技能仓库

本仓库存放「抖店短视频自动发布」Agent 技能体系（与代码实现仓库 `douyin_shop_video_publish` 分离，互不影响）。

## 内容结构

```
skills/douyin-shop-video-publish/SKILL.md            # 技能本体（标准 GitHub Agent Skill 格式，可配置版 v2）
skills/douyin-shop-video-publish/AGENT-GUIDE.md      # ★ Agent 操作手册（给执行 Agent 的机器级协议）
skills/douyin-shop-video-publish/CONFIG-GUIDE.md     # ★ 新部署者手把手配置引导（推荐从这开始）
skills/douyin-shop-video-publish/config.example.json # 配置（已内置任务表/商品ID表链接；复制为 config.json 可覆盖）
skills/douyin-shop-video-publish/README.md           # 技能目录内安装说明
docs/run-log/YYYY-MM-DD运行记录.md                    # 每日运行记录（问题与解决、结果汇总）
```

## 安装与使用（给新部署者）

1. 将 `skills/douyin-shop-video-publish/` 整个目录复制到客户端 skills 根目录；
2. **开箱即用**：任务表/商品ID表链接已内置；需要覆盖时按 `CONFIG-GUIDE.md` 配置（约 5 分钟；店铺清单可留空，跟随登录账号自动发现）；
3. **登录**：技能**不保留登录状态**——每次调用时 Agent 引导你现场登录抖店（企业微信扫码）与任务表平台；
4. **执行 Agent**：按 `AGENT-GUIDE.md` 操作（全表扫描、店铺队列、发布每一步、回填、人工处理、断点续跑）；
5. 全表扫描能读到任务表即部署成功，按 SKILL.md「二、核心执行流程」运行。

## 私有性与分享

- 本仓库为 **private（仅个人可见）**；内置链接为资源地址（非凭据），技能不保存登录状态；
- 分享给他人时，对方需有对应文档权限才能用；必要时将内置链接替换为对方自己的文档（config.json 覆盖）。

## 版本与发布

- 每次更新递增版本号（`vX.Y.Z`，见 `CHANGELOG.md`）并发布 **GitHub Release**：tag 与发布说明取自 `CHANGELOG.md` 对应版本段落；
- Releases 页面始终显示最新版本与变更说明；本地同步脚本 `sync_skill.ps1`（不随仓库发布）负责执行递增 + 推送 + 创建 Release。
