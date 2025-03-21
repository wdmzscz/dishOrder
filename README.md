# 餐厅点餐系统 (Restaurant Ordering System)

一个专为加拿大安大略省中餐馆设计的iOS点餐系统，帮助服务员快速记录和管理顾客订单。

## 功能特点

- **分类菜单展示**：菜品按前菜、主菜、主食等分类整齐展示
- **快速搜索**：支持快速搜索菜品名称
- **购物车管理**：添加、编辑数量、添加备注、删除菜品
- **餐桌号管理**：每个订单关联特定餐桌号，避免送错餐
- **价格计算**：自动计算菜品总价和安大略省13%的HST税
- **订单历史**：查看所有已提交订单及详情

## 技术栈

- SwiftUI
- iOS 14.0+

## 使用说明

1. **浏览菜单**：
   - 通过水平滚动选择菜品分类
   - 在搜索栏输入关键词快速查找菜品

2. **添加菜品**：
   - 点击菜品卡片或"+添加"按钮将菜品添加到购物车
   - 添加成功后购物车图标上会显示数量

3. **管理购物车**：
   - 点击右上角购物车图标查看当前订单
   - 可调整菜品数量、添加备注
   - 长按菜品可删除或编辑备注

4. **选择餐桌**：
   - 点击右上角餐桌号选择订单对应的餐桌

5. **提交订单**：
   - 在购物车界面确认订单信息
   - 点击"提交订单"完成下单
   - 可在"订单"标签页查看所有已完成订单

## 项目结构

- **Models/**: 数据模型
  - MenuItem.swift: 菜品模型
  - CartItem.swift: 购物车项目模型
  - CartManager.swift: 购物车管理
  - Order.swift: 订单模型及管理

- **Views/**: 主要视图
  - MenuView.swift: 菜单浏览视图
  - OrdersView.swift: 订单列表及详情视图

- **Components/**: 可复用组件
  - MenuItemCard.swift: 菜品卡片
  - CartItemRow.swift: 购物车条目
  - CartView.swift: 购物车视图

## 本地化

应用界面使用中文显示，适合中餐馆使用。价格使用加元($)显示，并根据安大略省13%的HST税率计算税费。 
