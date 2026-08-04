# 微证券视频号脚本撰写 Skill 安装脚本（Windows PowerShell）

$SkillName = "weizhengquan-script-writer"
$InstallDir = "$env:USERPROFILE\.workbuddy\skills\$SkillName"
$SourceDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

Write-Host "==========================================="
Write-Host "  微证券视频号脚本撰写 Skill 安装脚本"
Write-Host "==========================================="
Write-Host ""
Write-Host "源目录：$SourceDir"
Write-Host "安装目录：$InstallDir"
Write-Host ""

# 检查 WorkBuddy 是否安装
if (-not (Test-Path "$env:USERPROFILE\.workbuddy")) {
    Write-Host "⚠️  未检测到 WorkBuddy 配置目录" -ForegroundColor Yellow
    $confirm = Read-Host "是否继续创建并安装？(y/N)"
    if ($confirm -ne "y") {
        Write-Host "已取消"
        exit 1
    }
}

# 创建 skill 目录
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.workbuddy\skills" | Out-Null

# 如果已存在，提示覆盖
if (Test-Path $InstallDir) {
    Write-Host "⚠️  已存在旧版本，将覆盖安装" -ForegroundColor Yellow
    $confirm = Read-Host "继续？(y/N)"
    if ($confirm -ne "y") {
        Write-Host "已取消"
        exit 1
    }
    Remove-Item -Recurse -Force $InstallDir
}

# 复制文件
Write-Host "📦 正在复制文件..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
Copy-Item "$SourceDir\SKILL.md" $InstallDir
Copy-Item "$SourceDir\instruction.md" $InstallDir
Copy-Item "$SourceDir\references" $InstallDir -Recurse
Copy-Item "$SourceDir\examples" $InstallDir -Recurse
if (Test-Path "$SourceDir\assets") {
    Copy-Item "$SourceDir\assets" $InstallDir -Recurse
}

Write-Host ""
Write-Host "✅ 安装完成！" -ForegroundColor Green
Write-Host ""
Write-Host "Skill 位置：$InstallDir"
Write-Host ""
Write-Host "使用方式："
Write-Host "  在 WorkBuddy 对话里输入「按工作流写脚本」「微证券脚本」「筛选这条新闻」"
Write-Host "  等关键词，即可自动加载该 skill。"
Write-Host ""
