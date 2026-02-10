# 🚀 部署指南

## GitHub Pages 部署步骤

### 1. 进入仓库设置
- 访问: https://github.com/JW-Fung/lunch-fortune/settings/pages

### 2. 配置 GitHub Pages
在 "Build and deployment" 部分：
- **Source**: 选择 `Deploy from a branch`
- **Branch**: 选择 `main` / `root`
- 点击 **Save**

### 3. 等待部署
- GitHub 会自动构建（通常需要 1-3 分钟）
- 部署成功后会显示访问地址

### 4. 访问你的网站
```
https://jw-fung.github.io/lunch-fortune/
```

---

## Vercel 部署（更快，全球CDN）

### 方式1: 通过网站部署
1. 访问: https://vercel.com/new
2. 导入你的 GitHub 仓库
3. 点击 **Deploy**

### 方式2: 使用 CLI（已安装）
```bash
vercel
```

部署后访问地址类似:
```
https://lunch-fortune.vercel.app
```

---

## Netlify 部署

### 拖拽部署
1. 访问: https://netlify.com/drop
2. 将 `lunch-fortune.html` 文件拖入页面
3. 自动生成访问地址

---

## 推荐方案
**个人推荐**: 使用 **Vercel**，因为:
- ⚡ 速度更快（全球 CDN）
- 🔄 自动更新（推送代码自动部署）
- 🌍 国内访问体验好
- 🆔 支持自定义域名
