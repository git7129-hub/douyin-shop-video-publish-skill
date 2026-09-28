# douyin-shop-video-publish · Agent Skill

抖店（抖音小店）短视频自动发布 Agent 技能（**可配置、可分享**）。

## 安装

1. 将本目录整个复制到支持 Agent Skills 的客户端 skills 根目录：
   ```
   skills/
   └── douyin-shop-video-publish/
       ├── SKILL.md              ← 技能本体（先读）
       ├── config.example.json   ← 配置模板（复制为 config.json 后填写）
       └── README.md
   ```
2. 复制 `config.example.json` 为 `config.json`，填写你的：
   - 任务表 / 商品ID表（腾讯文档）URL
   - 本地视频目录、违禁词表、商品ID表路径
   - 店铺清单与规则参数
3. 登录抖店（企业微信扫码）与任务表平台。
4. 验证：执行一次「全表扫描」能读到任务表即部署成功。

## 使用

- 全流程细节见 `SKILL.md`（零、安装与配置；二、核心执行流程）。
- 运行记录同步到 GitHub 私有仓库：见仓库 `tools/sync_skill.ps1`（可选）。

## 分享

- 只分享本目录（不含你的真实 `config.json` 与运行历史）；接收方填写自己的配置即可复用。
- 技能仓库保持 private（仅个人可见），公开分享请先脱敏。
