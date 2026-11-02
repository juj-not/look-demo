#!/usr/bin/env bash
# 一键把 LOOK demo 推到你的 GitHub 并开启 Pages
# 用法:  bash push_to_github.sh
set -e

REPO_NAME="${1:-look-demo}"
VISIBILITY="${2:-public}"   # public / private

cd "$(dirname "$0")"

echo "==> 0/4 准备本地仓库"
[ -d .git ] || git init -q
git add -A
git -c user.name="LOOK" -c user.email="dev@look.app" commit -q -m "feat: 露可 LOOK 高保真交互 demo" 2>/dev/null || echo "    无新增改动，跳过提交"

echo "==> 1/4 检查 GitHub 登录状态"
if ! gh auth status >/dev/null 2>&1; then
  echo "    未登录，开始授权（按提示选择 GitHub.com -> HTTPS -> 浏览器登录）"
  gh auth login
fi

echo "==> 2/4 创建仓库 ${VISIBILITY}/${REPO_NAME}"
gh repo create "$REPO_NAME" --"$VISIBILITY" --source=. --remote=origin --push 2>/dev/null \
  || { git remote remove origin 2>/dev/null; git remote add origin "https://github.com/$(gh api user -q .login)/${REPO_NAME}.git"; git push -u origin main; }

git branch -M main

echo "==> 3/4 开启 GitHub Pages（Actions 部署源）"
gh api -X POST "repos/{owner}/{repo}/pages" \
      -H "Accept: application/vnd.github+json" \
      -f build_type=workflow >/dev/null 2>&1 || echo "    Pages 已开启或需手动设置"

gh api -X PUT "repos/{owner}/{repo}" -f homepage="" >/dev/null 2>&1

echo "==> 4/4 触发部署"
git push origin main

URL="https://$(gh api user -q .login).github.io/${REPO_NAME}/"
echo
echo "✅ 完成！稍等 1-2 分钟，Actions 跑完后访问："
echo "   $URL"
echo "   页面地址页：$(gh repo view --json url -q .url)/settings/pages"
