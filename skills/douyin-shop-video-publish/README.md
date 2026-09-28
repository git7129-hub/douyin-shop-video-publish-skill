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
2. **配置**（可选，约 5 分钟）：技能已**内置**任务表/商品ID表链接，开箱即用；如需覆盖，复制 `config.example.json` 为 `config.json` 后按 `CONFIG-GUIDE.md` 填写（店铺清单可留空，跟随登录账号自动发现）。
3. **执行 Agent 按 `AGENT-GUIDE.md` 操作**（机器级协议：全表扫描、店铺队列、发布面板每一步、回填、人工处理、断点续跑）。
4. **登录**：技能**不保留登录状态**——每次调用时 Agent 会引导你现场登录抖店（企业微信扫码）与任务表平台。
5. 验证：执行一次「全表扫描」能读到任务表即部署成功。

## 使用

- 全流程细节见 `SKILL.md`（零、安装与配置；二、核心执行流程）。
- 执行 Agent 操作见 `AGENT-GUIDE.md`；配置见 `CONFIG-GUIDE.md`。

## 分享

- 技能内置的文档链接为**资源地址（非凭据）**，打开后仍需登录；技能不保存登录状态；
- 分享给他人时，对方需有对应文档权限才能用；必要时将内置链接替换为对方自己的文档（config.json 覆盖）。
- 技能仓库保持 private（仅个人可见），公开分享请先替换内置链接。
