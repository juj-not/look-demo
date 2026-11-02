# 露可 LOOK · 可运作 Demo

直接双击打开 `index.html`（无需服务器），或部署后访问。

## 上传到 GitHub（一条命令，自动开 Pages）

```bash
bash push_to_github.sh            # 公开仓库，名 look-demo
bash push_to_github.sh my-look private   # 自定义名字 / 私有仓库
```

脚本会自动：安装前初始化仓库 → 引导 `gh auth login` → 创建仓库并推送 → 开启 GitHub Pages（Actions 源）→ 输出访问地址。

> 前置：安装 [GitHub CLI](https://cli.github.com/)（`brew install gh` / `winget install GitHub.cli`），脚本内会引导登录。

### 手动方式（不用 CLI）
1. GitHub 网页右上角 `+` → **New repository** → 名称 `look-demo`，**Public**，不要勾选 README
2. 在本地目录执行：
```bash
git init && git add -A
git commit -m "feat: LOOK demo"
git branch -M main
git remote add origin https://github.com/<你的用户名>/look-demo.git
git push -u origin main
```
3. 仓库 **Settings → Pages → Source** 选 **GitHub Actions**（`.github/workflows/pages.yml` 已备好）

推送后 1–2 分钟 Actions 跑完，访问 `https://<用户名>.github.io/look-demo/`。

## 说明
- **每页视觉 = 你上传的高保真设计图原图**（22 张，位于 `assets/`，未做任何改动）
- 透明热区叠加在原图上触发交互；点右上角「显示热区」可查看全部可点位置
- 热区坐标集中在 `index.html` 顶部 `PAGES` 定义中，可微调（格式：`[x%, y%, w%, h%, 动作, 参数]`）
- URL 支持直达调试：`index.html#fitting,debug`

## 已实现的交互流
1. **启动页** → 点击进入 **性别选择**（♀/♂）→ 首页
2. **首页**（Tab:衣橱）：金刚区四入口 → AI搭配聊天 / AI试衣间 / 我的衣橱 / 穿搭日记
3. **AI搭配聊天**：点输入栏发消息 → 用户气泡 → AI「正在精心搭配中…」→ 生成回复；三张 look 卡可收藏；「随心配」入口
4. **随心配**：中心卡片可**鼠标/手指拖拽**，滑出换下一套；红心动画；底部对勾收下
5. **试衣间**：试单品/试搭配/试收藏 三 Tab；类目筛选；点击衣物选中（红勾）→ 浮出「开始试穿」→ 换装动画
6. **单品详情**：AI搭配/AI试衣浮钮；属性行编辑弹层；**颜色选择器页**（主色/次色/色环，源图页面）；穿着次数 +/-
7. **数字人捏人**：身形六宫格选择（A/H/O/T/X/肌肉）→ 滑块页（胸围/腰围/臀围/大腿/手臂，真实可拖）→ 保存
8. **发现/商城**：搜索页（搜词填入）；商品详情（**色点循环换色、数量加减、加入购物车**）；购物车（x1 数量点击 +1、合计联动、结算支付弹层）
9. **消息**：会话操作（隐藏/删除）；**聊天详情**（米妮）可发消息并自动回复
10. **视频博主页**：点衣服区域 → 识别态（AI衣架→试衣间 / 魔棒→AI搭配 / 购物袋→同款商品）；点赞红心
11. **我的**：六项菜单入口

## 素材对应（源文件名 → demo 资产）
| 源文件 | 资产 | 备注 |
|---|---|---|
| 启动页/选择性别/首页/衣橱/导入/日记/商场/商品页/搜索页/购物车/博主页×2/消息×2/我的/捏人×2 | 同名语义 | 直接对应 |
| AI搭配.png | aichat.png | ⚠️ 源文件名与内容相反，实际为「随心配」 |
| AI助手.png | assist.png | 实际为「AI搭配聊天」 |
| AI.png | fitting.png | 试衣间（试单品/试搭配/试收藏） |
| 拍照.png | camera.png | 实际为「编辑态单品详情」（AI浮钮版），用作单品详情页 |
| 单价.png | item.png | 实际为「单品详情+颜色选择器」，用作颜色选择页 |
