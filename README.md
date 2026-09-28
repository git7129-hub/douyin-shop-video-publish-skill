# 抖店短视频自动发布 · Agent 技能仓库

本仓库存放「抖店短视频自动发布」Agent 技能体系（与代码实现仓库 `douyin_shop_video_publish` 分离，互不影响）。

## 内容结构

```
skills/douyin-shop-video-publish/SKILL.md           # 技能本体（标准 GitHub Agent Skill 格式，可配置版 v2）
skills/douyin-shop-video-publish/config.example.json # 配置模板（复制为 config.json 后填写私有信息）
skills/douyin-shop-video-publish/README.md           # 技能目录内安装说明
docs/run-log/YYYY-MM-DD运行记录.md                    # 每日运行记录（问题与解决、结果汇总）
tools/sync_skill.ps1                                  # 同步脚本：本地技能目录 + 运行记录 → 本仓库（gh API 直传）
```

## 安装与使用（给新部署者）

1. 将 `skills/douyin-shop-video-publish/` 整个目录复制到客户端 skills 根目录；
2. 复制 `config.example.json` 为 `config.json`，填写任务表/商品ID表 URL、本地路径、店铺清单、规则参数（见 SKILL.md「一、配置项说明」）；
3. 登录抖店（企业微信扫码）与任务表平台（腾讯文档）；
4. 全表扫描能读到任务表即部署成功，按 SKILL.md「二、核心执行流程」运行。

## 同步机制

- 每次运行结束，Agent 更新技能目录（SKILL.md 追加问题与解决 / 规则 / 运行记录）；
- 每晚 23:30 Windows 计划任务「DouyinSkillSync」自动运行 `sync_skill.ps1` 推送（gh API 直传，不依赖 git 443）；
- 手动执行：
  ```powershell
  powershell -ExecutionPolicy Bypass -File "E:\测试专用\豆包\抖店发布\sync_skill.ps1"
  ```

## 私有性与分享

- 本仓库为 **private（仅个人可见）**；
- 分享时只分享 `skills/douyin-shop-video-publish/`（不含真实 config.json 与运行历史），接收方填写自己的 config.json 即可复用。
