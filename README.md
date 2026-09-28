# 抖店短视频自动发布 · Agent 技能仓库

本仓库存放「抖店短视频自动发布」Agent 技能体系（与代码实现仓库 `douyin_shop_video_publish` 分离，互不影响）。

## 内容结构

```
skills/douyin-shop-video-publish/SKILL.md            # 技能本体（标准 GitHub Agent Skill 格式，可配置版 v2）
skills/douyin-shop-video-publish/AGENT-GUIDE.md      # ★ Agent 操作手册（给执行 Agent 的机器级协议）
skills/douyin-shop-video-publish/CONFIG-GUIDE.md     # ★ 新部署者手把手配置引导（推荐从这开始）
skills/douyin-shop-video-publish/config.example.json # 配置模板（复制为 config.json 后填写私有信息）
skills/douyin-shop-video-publish/README.md           # 技能目录内安装说明
docs/run-log/YYYY-MM-DD运行记录.md                    # 每日运行记录（问题与解决、结果汇总）
```

## 安装与使用（给新部署者）

1. 将 `skills/douyin-shop-video-publish/` 整个目录复制到客户端 skills 根目录；
2. **人**：按 `CONFIG-GUIDE.md` 手把手配置（创建 config.json → 填文档链接/路径/店铺 → 准备违禁词表与商品ID表 → 登录 → 验证，约 15 分钟）；
3. **执行 Agent**：按 `AGENT-GUIDE.md` 操作（全表扫描、店铺队列、发布每一步、回填、人工处理、断点续跑）；
4. 全表扫描能读到任务表即部署成功，按 SKILL.md「二、核心执行流程」运行。

## 私有性与分享

- 本仓库为 **private（仅个人可见）**；
- 分享时只分享 `skills/douyin-shop-video-publish/`（不含真实 config.json 与运行历史），接收方填写自己的 config.json 即可复用。
