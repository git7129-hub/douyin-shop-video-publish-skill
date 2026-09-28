# 抖店短视频自动发布 · Agent 技能仓库

本仓库存放「抖店短视频自动发布」Agent 技能体系（与代码实现仓库 `douyin_shop_video_publish` 分离，互不影响）。

## 内容结构

```
skills/douyin-shop-video-publish/SKILL.md   # Agent 技能本体（标准 GitHub Agent Skill 格式）
docs/run-log/YYYY-MM-DD运行记录.md           # 每日运行记录（问题与解决、结果汇总）
tools/sync_skill.ps1                         # 同步脚本：本地 SKILL.md + 运行记录 → 推送到本仓库
```

## 同步机制

- 每次运行结束，Agent 更新 `SKILL.md`（追加问题与解决 / 用户规则 / 运行记录）与当日运行记录；
- 每晚 23:30 Windows 计划任务「DouyinSkillSync」自动运行 `tools/sync_skill.ps1` 推送；
- 也可手动执行：
  ```powershell
  powershell -ExecutionPolicy Bypass -File "E:\测试专用\豆包\抖店发布\sync_skill.ps1"
  ```

## 私有性

本仓库为 **private（仅个人可见）**。
