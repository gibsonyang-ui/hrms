#!/usr/bin/env python3
import frappe

# 设置系统语言为中文
frappe.db.set_value('System Settings', 'System Settings', 'language', 'zh')
frappe.db.set_value('System Settings', 'System Settings', 'country', 'China')
frappe.db.set_value('System Settings', 'System Settings', 'time_zone', 'Asia/Shanghai')

# 提交更改
frappe.db.commit()

print("Language settings updated to Chinese successfully!")
