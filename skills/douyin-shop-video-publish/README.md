# douyin-shop-video-publish · Agent Skill

抖店（抖音小店）短视频自动发布 Agent 技能（**可配置、可分享**）。

## 安装

1. 将本目录整个复制到支持 Agent Skills 的客户端 skills 根目录：
   ```
   skills/
   └── douyin-shop-video-publish/
       ├── SKILL.md            ← 技能本体（先读）
       ├── AGENT-GUIDE.md      ← ★ Agent 操作手册（给执行 Agent 的机器级协议）
       ├── CONFIG-GUIDE.md     ← ★ 手把手配置引导（新部署者从这里开始）
       ├── config.example.json ← 配置模板（复制为 config.json 后填写）
       └── README.md
   ```
2. **按 `CONFIG-GUIDE.md` 逐步配置**（约 15 分钟）：创建 config.json → 填文档链接/本地路径（店铺清单可留空，跟随登录账号自动发现）→ 准备违禁词表与商品ID表 → 登录 → 验证全表扫描。
3. **执行 Agent 按 `AGENT-GUIDE.md` 操作**（机器级协议：全表扫描、店铺队列、发布面板每一步、回填、人工处理、断点续跑）。
3. 登录抖店（企业微信扫码）与任务表平台。
4. 验证：执行一次「全表扫描」能读到任务表即部署成功。

## 使用

- 全流程细节见 `SKILL.md`（零、安装与配置；二、核心执行流程）。
- 执行 Agent 操作见 `AGENT-GUIDE.md`；配置见 `CONFIG-GUIDE.md`。

## 分享

- 只分享本目录（不含你的真实 `config.json` 与运行历史）；接收方填写自己的配置即可复用。
- 技能仓库保持 private（仅个人可见），公开分享请先脱敏。
