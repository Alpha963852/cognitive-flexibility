# Cognitive Flexibility Skill GitHub 发布脚本
# 版本：v2.1.0

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Cognitive Flexibility Skill GitHub 发布" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# 设置目录
$publishDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $publishDir

Write-Host "[1/6] 检查 Git 安装..." -ForegroundColor Yellow
try {
    $gitVersion = git --version 2>&1
    if ($gitVersion) {
        Write-Host "[成功] Git 已安装：$gitVersion" -ForegroundColor Green
    } else {
        Write-Host "[错误] Git 未安装" -ForegroundColor Red
        Write-Host "请先安装 Git: https://git-scm.com/" -ForegroundColor Yellow
        pause
        exit 1
    }
} catch {
    Write-Host "[错误] Git 未安装" -ForegroundColor Red
    Write-Host "请先安装 Git: https://git-scm.com/" -ForegroundColor Yellow
    pause
    exit 1
}
Write-Host ""

Write-Host "[2/6] 检查 GitHub 登录..." -ForegroundColor Yellow
$githubUser = git config user.name 2>&1
if ($githubUser) {
    Write-Host "[成功] 已登录 GitHub 用户：$githubUser" -ForegroundColor Green
} else {
    Write-Host "[提示] 未配置 GitHub 用户" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "请配置 Git 用户信息:" -ForegroundColor Cyan
    Write-Host "  git config --global user.name `"Your Name`"" -ForegroundColor Gray
    Write-Host "  git config --global user.email `"your@email.com`"" -ForegroundColor Gray
    Write-Host ""
    
    $configGit = Read-Host "是否现在配置？(y/n)"
    if ($configGit -eq 'y' -or $configGit -eq 'Y') {
        $name = Read-Host "输入 GitHub 用户名"
        $email = Read-Host "输入 GitHub 邮箱"
        git config --global user.name $name
        git config --global user.email $email
        Write-Host "[成功] Git 用户已配置" -ForegroundColor Green
    } else {
        Write-Host "[提示] 请先配置 Git 用户" -ForegroundColor Yellow
        pause
        exit 0
    }
}
Write-Host ""

Write-Host "[3/6] 初始化 Git 仓库..." -ForegroundColor Yellow
if (-not (Test-Path ".git")) {
    git init
    Write-Host "[成功] Git 仓库已初始化" -ForegroundColor Green
} else {
    Write-Host "[信息] Git 仓库已存在" -ForegroundColor Yellow
}
Write-Host ""

Write-Host "[4/6] 添加文件..." -ForegroundColor Yellow
git add .
Write-Host "[成功] 文件已添加" -ForegroundColor Green
Write-Host ""

Write-Host "[5/6] 提交更改..." -ForegroundColor Yellow
$commitMessage = "Initial release: Cognitive Flexibility Skill v2.1.0

Features:
- 4 cognitive modes (OOA/OODA/OOCA/OOHA)
- Automatic mode switching
- Metacognitive monitoring
- Usage analytics and weekly reports
- 100% test coverage

Published on ClawHub: cognitive-flexibility v2.1.0"

git commit -m $commitMessage
Write-Host "[成功] 更改已提交" -ForegroundColor Green
Write-Host ""

Write-Host "[6/6] 创建 GitHub 仓库..." -ForegroundColor Yellow
Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "GitHub 仓库创建指南" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "请在 GitHub 上创建新仓库:" -ForegroundColor White
Write-Host ""
Write-Host "1. 访问：https://github.com/new" -ForegroundColor Gray
Write-Host "2. 仓库名称：cognitive-flexibility" -ForegroundColor Gray
Write-Host "3. 描述：Advanced AI cognitive flexibility with 4 reasoning modes" -ForegroundColor Gray
Write-Host "4. 选择：Public" -ForegroundColor Gray
Write-Host "5. 不要初始化仓库（不要勾选 README/.gitignore/license）" -ForegroundColor Gray
Write-Host "6. 点击 Create repository" -ForegroundColor Gray
Write-Host ""

$repoUrl = Read-Host "输入创建的仓库 URL (例如：https://github.com/username/cognitive-flexibility.git)"

if ($repoUrl) {
    Write-Host ""
    Write-Host "添加远程仓库..." -ForegroundColor Yellow
    git remote add origin $repoUrl
    
    Write-Host "推送到 GitHub..." -ForegroundColor Yellow
    git branch -M main
    git push -u origin main
    
    Write-Host ""
    Write-Host "[成功] 已推送到 GitHub！" -ForegroundColor Green
    Write-Host ""
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host "发布完成！" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "GitHub 仓库：$repoUrl" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "下一步:" -ForegroundColor White
    Write-Host "  1. 访问 GitHub 仓库页面" -ForegroundColor Gray
    Write-Host "  2. 添加 Topics: ai, cognitive-flexibility, reasoning, etc." -ForegroundColor Gray
    Write-Host "  3. 设置仓库描述" -ForegroundColor Gray
    Write-Host "  4. 分享到社区" -ForegroundColor Gray
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "[提示] 请手动推送:" -ForegroundColor Yellow
    Write-Host "  git remote add origin <your-repo-url>" -ForegroundColor Gray
    Write-Host "  git branch -M main" -ForegroundColor Gray
    Write-Host "  git push -u origin main" -ForegroundColor Gray
    Write-Host ""
}

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "GitHub 发布完成！" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

pause
