# Cognitive Flexibility Skill 快速发布脚本 (PowerShell)
# 版本：v2.1.0

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Cognitive Flexibility Skill 发布到 ClawHub" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# 设置目录
$publishDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $publishDir

Write-Host "[1/5] 检查 clawhub 安装..." -ForegroundColor Yellow
try {
    $clawhubVersion = clawhub --help 2>&1 | Select-String "ClawHub CLI"
    if ($clawhubVersion) {
        Write-Host "[成功] clawhub 已安装" -ForegroundColor Green
    } else {
        Write-Host "[错误] clawhub 未正确安装" -ForegroundColor Red
        Write-Host "请先安装：pip install clawhub" -ForegroundColor Yellow
        pause
        exit 1
    }
} catch {
    Write-Host "[错误] clawhub 未安装" -ForegroundColor Red
    Write-Host "请先安装：pip install clawhub" -ForegroundColor Yellow
    pause
    exit 1
}
Write-Host ""

Write-Host "[2/5] 检查登录状态..." -ForegroundColor Yellow
$loginCheck = clawhub whoami 2>&1
if ($loginCheck -match "Not logged in") {
    Write-Host "[提示] 未登录，需要登录 ClawHub" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host "登录方式:" -ForegroundColor Cyan
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "方式 1: 浏览器认证（推荐）" -ForegroundColor White
    Write-Host "  1. 运行：clawhub login" -ForegroundColor Gray
    Write-Host "  2. 在打开的浏览器中登录" -ForegroundColor Gray
    Write-Host "  3. 授权 CLI 访问" -ForegroundColor Gray
    Write-Host ""
    Write-Host "方式 2: Token 认证" -ForegroundColor White
    Write-Host "  1. 访问：https://clawhub.com/settings/tokens" -ForegroundColor Gray
    Write-Host "  2. 创建新的 CLI Token" -ForegroundColor Gray
    Write-Host "  3. 运行：clawhub auth token" -ForegroundColor Gray
    Write-Host "  4. 粘贴 Token" -ForegroundColor Gray
    Write-Host ""
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host ""
    
    $choice = Read-Host "是否现在登录？(y/n)"
    if ($choice -eq 'y' -or $choice -eq 'Y') {
        Write-Host ""
        Write-Host "正在打开浏览器..." -ForegroundColor Yellow
        clawhub login
        Write-Host ""
        Write-Host "请完成浏览器认证后按任意键继续..." -ForegroundColor Yellow
        pause
    } else {
        Write-Host ""
        Write-Host "[提示] 请先手动完成登录，然后重新运行此脚本" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "手动发布命令:" -ForegroundColor Cyan
        Write-Host "  cd $publishDir" -ForegroundColor Gray
        Write-Host "  clawhub login" -ForegroundColor Gray
        Write-Host "  clawhub publish . --slug cognitive-flexibility --version 2.1.0" -ForegroundColor Gray
        Write-Host ""
        pause
        exit 0
    }
} else {
    Write-Host "[成功] 已登录" -ForegroundColor Green
}
Write-Host ""

Write-Host "[3/5] 验证登录..." -ForegroundColor Yellow
$whoami = clawhub whoami 2>&1
if ($whoami -match "Logged in as") {
    Write-Host "[成功] $whoami" -ForegroundColor Green
} else {
    Write-Host "[错误] 登录验证失败" -ForegroundColor Red
    Write-Host "请先完成登录" -ForegroundColor Yellow
    pause
    exit 1
}
Write-Host ""

Write-Host "[4/5] 发布 Skill..." -ForegroundColor Yellow
Write-Host "  Slug: cognitive-flexibility" -ForegroundColor Gray
Write-Host "  Version: 2.1.0" -ForegroundColor Gray
Write-Host ""

$publishOutput = clawhub publish . --slug cognitive-flexibility --version 2.1.0 2>&1
Write-Host $publishOutput

if ($LASTEXITCODE -eq 0 -or $publishOutput -match "published successfully") {
    Write-Host ""
    Write-Host "[成功] Skill 已发布！" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "[错误] 发布失败" -ForegroundColor Red
    Write-Host "请检查错误信息" -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}
Write-Host ""

Write-Host "[5/5] 验证发布..." -ForegroundColor Yellow
Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "发布成功！" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Skill 链接:" -ForegroundColor White
Write-Host "  https://clawhub.com/skills/cognitive-flexibility" -ForegroundColor Cyan
Write-Host ""
Write-Host "安装命令:" -ForegroundColor White
Write-Host "  clawhub install cognitive-flexibility" -ForegroundColor Cyan
Write-Host ""
Write-Host "下一步:" -ForegroundColor White
Write-Host "  1. 访问 Skill 页面验证" -ForegroundColor Gray
Write-Host "  2. 分享链接到社区" -ForegroundColor Gray
Write-Host "  3. 监控用户反馈" -ForegroundColor Gray
Write-Host "  4. 查看 feedback/FEEDBACK-TRACKER.md" -ForegroundColor Gray
Write-Host ""

# 询问是否打开 Skill 页面
$openUrl = Read-Host "是否打开 Skill 页面？(y/n)"
if ($openUrl -eq 'y' -or $openUrl -eq 'Y') {
    Start-Process "https://clawhub.com/skills/cognitive-flexibility"
    Write-Host "[已打开] Skill 页面" -ForegroundColor Green
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "发布完成！感谢贡献！" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

pause
