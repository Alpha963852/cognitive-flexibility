# Cognitive Flexibility Skill 自动化监控

**版本:** v2.1.0  
**创建时间:** 2026-04-05  
**状态:** ✅ 已配置 Cron 任务

---

## 📊 监控机制

### 1. 使用监控（自动）

**模块:** `scripts/usage_monitor.py`

**功能:**
- 自动记录每次使用
- 统计模式分布
- 评估模式效果
- 生成使用报告

**触发:** 每次使用 Skill 时自动记录

---

### 2. 周度报告 Cron（自动）

**任务:** `Cognitive Flexibility 使用监控 (每周)`

**时间:** 每周一 09:00 (Asia/Shanghai)

**执行内容:**
1. 读取使用统计数据
2. 生成周度报告
3. 更新 FEEDBACK-TRACKER.md
4. 输出到 Discord

**脚本:** `generate-weekly-report.py`

---

### 3. 反馈收集（自动 + 手动）

**模块:** `scripts/feedback_collector.py`

**收集渠道:**
- ClawHub Comments（自动）
- GitHub Issues（自动）
- Discord（手动）
- 邮件（手动）

**追踪文件:** `feedback/FEEDBACK-TRACKER.md`

---

## 🔧 手动运行监控

### 生成周度报告

```bash
cd cognitive-flexibility-release
python generate-weekly-report.py 7
```

### 查看使用统计

```bash
python monitor-usage.py
```

### 导出使用日志

```python
from scripts.usage_monitor import UsageMonitor

monitor = UsageMonitor()
export_file = monitor.export_logs()
print(f"日志已导出：{export_file}")
```

---

## 📈 监控指标

### 使用统计

| 指标 | 说明 |
|------|------|
| 总使用次数 | Skill 被使用的总次数 |
| 成功率 | 评分>=0.7 的比例 |
| 平均置信度 | 所有使用的平均置信度 |
| 平均评分 | 所有使用的平均评分 |

### 模式分布

| 模式 | 指标 |
|------|------|
| OOA | 使用次数、占比、平均评分 |
| OODA | 使用次数、占比、平均评分 |
| OOCA | 使用次数、占比、平均评分 |
| OOHA | 使用次数、占比、平均评分 |

### 用户反馈

| 类型 | 状态 |
|------|------|
| Bug 报告 | 待处理/已解决 |
| 功能请求 | 待评估/已实现 |
| 使用体验 | 已收集/已回复 |
| 性能问题 | 待优化/已优化 |

---

## 📋 周度报告内容

**生成时间:** 每周一 09:00

**报告内容:**
1. 使用统计（总次数、成功率、置信度、评分）
2. 模式分布（4 种模式使用占比）
3. 模式效果对比（各模式平均评分）
4. 用户反馈统计
5. 改进建议

**输出位置:**
- `reports/weekly-report-YYYYMMDD.md`
- Discord #skills-monitoring 频道
- `feedback/FEEDBACK-TRACKER.md`

---

## 🔄 监控流程

```
使用 Skill → 自动记录 → 周度汇总 → 生成报告 → 输出 Discord
    ↓
  用户反馈 → 收集整理 → 优先级评估 → 修复/实现 → 发布更新
```

---

## 📊 报告示例

```markdown
# Cognitive Flexibility Skill 周度使用报告

**报告周期:** 7天
**生成时间:** 2026-04-12 09:00:00

## 使用统计

- 总使用次数：50
- 成功率：85.0%
- 平均置信度：0.78
- 平均评分：0.82

## 模式分布

- OODA: 25 次 (50.0%) ██████████
- OOA: 15 次 (30.0%) ██████
- OOCA: 5 次 (10.0%) ██
- OOHA: 5 次 (10.0%) ██

## 模式效果对比

- OOA: 使用 15 次，平均评分 0.85 ⭐⭐⭐⭐
- OODA: 使用 25 次，平均评分 0.82 ⭐⭐⭐⭐
- OOCA: 使用 5 次，平均评分 0.88 ⭐⭐⭐⭐⭐
- OOHA: 使用 5 次，平均评分 0.75 ⭐⭐⭐⭐

## 改进建议

- ⚠️ OOHA 评分偏低 (0.75)，建议优化
- ✅ 无其他问题
```

---

## 📄 相关文件

| 文件 | 说明 |
|------|------|
| `scripts/usage_monitor.py` | 使用监控模块 |
| `scripts/feedback_collector.py` | 反馈收集模块 |
| `generate-weekly-report.py` | 周度报告生成脚本 |
| `monitor-usage.py` | 监控查看脚本 |
| `feedback/FEEDBACK-TRACKER.md` | 反馈追踪文件 |
| `AUTOMATED-MONITORING.md` | 本文档 |

---

## 🎯 Cron 任务配置

**任务 ID:** `cognitive-flexibility-usage-monitor`

**配置:**
```json
{
  "name": "Cognitive Flexibility 使用监控 (每周)",
  "schedule": "0 9 * * 1",
  "timezone": "Asia/Shanghai",
  "agent": "optimizer",
  "script": "generate-weekly-report.py 7"
}
```

---

_道师出品 · Cognitive Flexibility Skill 自动化监控 v2.1_

**创建时间:** 2026-04-05  
**下次报告:** 2026-04-12 09:00
