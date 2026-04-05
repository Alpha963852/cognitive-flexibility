@echo off
REM Cognitive Flexibility Skill 发布脚本

echo ============================================================
echo Cognitive Flexibility Skill 发布到 ClawHub
echo ============================================================
echo.

cd /d "%~dp0"

echo 步骤 1: 检查 clawhub 是否安装...
where clawhub >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] clawhub 未安装，请先安装：pip install clawhub
    pause
    exit /b 1
)
echo [成功] clawhub 已安装
echo.

echo 步骤 2: 登录 ClawHub...
echo [提示] 将在浏览器中打开登录页面
clawhub login
if %errorlevel% neq 0 (
    echo [错误] 登录失败
    pause
    exit /b 1
)
echo [成功] 已登录 ClawHub
echo.

echo 步骤 3: 发布 Skill...
clawhub publish . --slug cognitive-flexibility --version 2.1.0
if %errorlevel% neq 0 (
    echo [错误] 发布失败
    pause
    exit /b 1
)
echo [成功] Skill 已发布到 ClawHub
echo.

echo ============================================================
echo 发布完成！
echo ============================================================
echo.
echo Skill 链接：https://clawhub.com/skills/cognitive-flexibility
echo.
echo 下一步:
echo 1. 访问 Skill 页面验证发布成功
echo 2. 分享 Skill 链接到社区
echo 3. 监控用户反馈 (feedback/FEEDBACK-TRACKER.md)
echo.
pause
