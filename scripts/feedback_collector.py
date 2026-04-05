"""
Feedback Collector - 反馈收集器
"""

import json
import os
from datetime import datetime
from typing import Dict, List


class FeedbackCollector:
    """反馈收集器"""
    
    def __init__(self, feedback_dir: str = None):
        if feedback_dir is None:
            feedback_dir = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'feedback')
        
        self.feedback_dir = feedback_dir
        self.stats_file = os.path.join(feedback_dir, 'feedback-stats.json')
        
        os.makedirs(feedback_dir, exist_ok=True)
        self.stats = self._load_stats()
    
    def _load_stats(self) -> Dict:
        """加载统计数据"""
        if os.path.exists(self.stats_file):
            with open(self.stats_file, 'r', encoding='utf-8') as f:
                return json.load(f)
        
        return {
            "total_feedback": 0,
            "by_type": {
                "bug": 0,
                "feature": 0,
                "experience": 0,
                "performance": 0
            },
            "by_status": {
                "open": 0,
                "in_progress": 0,
                "resolved": 0,
                "closed": 0
            },
            "last_updated": None
        }
    
    def add_feedback(self, feedback: Dict):
        """添加反馈"""
        self.stats["total_feedback"] += 1
        
        fb_type = feedback.get("type", "other")
        if fb_type in self.stats["by_type"]:
            self.stats["by_type"][fb_type] += 1
        
        status = feedback.get("status", "open")
        if status in self.stats["by_status"]:
            self.stats["by_status"][status] += 1
        
        self.stats["last_updated"] = datetime.now().isoformat()
        self._save_stats()
    
    def _save_stats(self):
        """保存统计数据"""
        with open(self.stats_file, 'w', encoding='utf-8') as f:
            json.dump(self.stats, f, ensure_ascii=False, indent=2)
    
    def get_stats(self) -> Dict:
        """获取统计数据"""
        return self.stats.copy()
