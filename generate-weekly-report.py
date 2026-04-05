# -*- coding: utf-8 -*-
"""
Weekly Report Generator - 生成周度使用监控报告
"""

import sys
import os
from datetime import datetime, timedelta

# 添加项目路径
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from scripts.usage_monitor import UsageMonitor
from scripts.feedback_collector import FeedbackCollector


def generate_report(days: int = 7):
    """生成周度报告"""
    print("\n" + "="*60)
    print("Cognitive Flexibility Skill 周度使用报告")
    print("="*60)
    print(f"报告周期：{days}天")
    print(f"生成时间：{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*60 + "\n")
    
    # 1. 使用统计
    monitor = UsageMonitor()
    stats = monitor.get_stats(days=days)
    
    print("1. 使用统计")
    print("-" * 40)
    if "message" in stats:
        print(f"   {stats['message']}")
    else:
        print(f"   总使用次数：{stats.get('count', 0)}")
        print(f"   成功率：{stats.get('success_rate', 0):.1f}%")
        print(f"   平均置信度：{stats.get('avg_confidence', 0):.2f}")
        print(f"   平均评分：{stats.get('avg_score', 0):.2f}")
    print()
    
    # 2. 模式分布
    print("2. 模式分布")
    print("-" * 40)
    mode_dist = stats.get("mode_distribution", {})
    total = sum(mode_dist.values())
    for mode, count in sorted(mode_dist.items(), key=lambda x: x[1], reverse=True):
        pct = count / total * 100 if total > 0 else 0
        bar = "█" * int(pct / 5)
        print(f"   {mode}: {count}次 ({pct:.1f}%) {bar}")
    print()
    
    # 3. 模式效果对比
    print("3. 模式效果对比")
    print("-" * 40)
    mode_comp = monitor.get_mode_comparison()
    for mode, data in mode_comp.items():
        count = data.get("count", 0)
        avg_score = data.get("avg_score", 0)
        if count > 0:
            rating = "⭐" * int(avg_score * 5)
            print(f"   {mode}: 使用{count}次，平均评分{avg_score:.2f} {rating}")
    print()
    
    # 4. 反馈统计
    print("4. 用户反馈")
    print("-" * 40)
    feedback = FeedbackCollector()
    fb_stats = feedback.get_stats()
    print(f"   总反馈数：{fb_stats.get('total_feedback', 0)}")
    print(f"   待处理：{fb_stats['by_status'].get('open', 0)}")
    print(f"   已解决：{fb_stats['by_status'].get('resolved', 0)}")
    print()
    
    # 5. 改进建议
    print("5. 改进建议")
    print("-" * 40)
    
    # 分析低效模式
    for mode, data in mode_comp.items():
        if data.get("count", 0) > 0 and data.get("avg_score", 0) < 0.7:
            print(f"   ⚠️ {mode} 评分偏低 ({data['avg_score']:.2f})，建议优化")
    
    # 分析高频问题
    if fb_stats['by_status'].get('open', 0) > 5:
        print(f"   ⚠️ 待处理反馈较多 ({fb_stats['by_status']['open']}个)，建议优先处理")
    
    print("   ✅ 无其他问题")
    print()
    
    # 6. 导出报告
    print("6. 报告导出")
    print("-" * 40)
    report_dir = os.path.join(os.path.dirname(__file__), 'reports')
    os.makedirs(report_dir, exist_ok=True)
    
    report_file = os.path.join(report_dir, f'weekly-report-{datetime.now().strftime("%Y%m%d")}.md')
    
    with open(report_file, 'w', encoding='utf-8') as f:
        f.write(f"# Cognitive Flexibility Skill 周度使用报告\n\n")
        f.write(f"**报告周期:** {days}天\n")
        f.write(f"**生成时间:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        f.write(f"## 使用统计\n\n")
        f.write(f"- 总使用次数：{stats.get('count', 0)}\n")
        f.write(f"- 成功率：{stats.get('success_rate', 0):.1f}%\n")
        f.write(f"- 平均置信度：{stats.get('avg_confidence', 0):.2f}\n")
        f.write(f"- 平均评分：{stats.get('avg_score', 0):.2f}\n\n")
        f.write(f"## 模式分布\n\n")
        for mode, count in sorted(mode_dist.items(), key=lambda x: x[1], reverse=True):
            pct = count / total * 100 if total > 0 else 0
            f.write(f"- {mode}: {count}次 ({pct:.1f}%)\n")
        f.write(f"\n## 下次报告\n\n")
        f.write(f"生成时间：{(datetime.now() + timedelta(days=7)).strftime('%Y-%m-%d')}\n")
    
    print(f"   报告已导出：{report_file}")
    print()
    
    print("="*60)
    print("报告生成完成")
    print("="*60 + "\n")
    
    return report_file


if __name__ == "__main__":
    days = 7
    if len(sys.argv) > 1:
        try:
            days = int(sys.argv[1])
        except ValueError:
            print(f"用法：python {sys.argv[0]} [天数]")
            sys.exit(1)
    
    generate_report(days)
