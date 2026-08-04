#!/bin/bash
# 微证券视频号脚本撰写 Skill 安装脚本（macOS / Linux）

set -e

SKILL_NAME="weizhengquan-script-writer"
INSTALL_DIR="$HOME/.workbuddy/skills/$SKILL_NAME"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==========================================="
echo "  微证券视频号脚本撰写 Skill 安装脚本"
echo "==========================================="
echo ""
echo "源目录：$SOURCE_DIR"
echo "安装目录：$INSTALL_DIR"
echo ""

# 检查 WorkBuddy 是否安装
if [ ! -d "$HOME/.workbuddy" ]; then
  echo "⚠️  未检测到 WorkBuddy 配置目录（~/.workbuddy/）"
  echo "    请先安装 WorkBuddy，或者手动创建该目录："
  echo "    mkdir -p ~/.workbuddy/skills"
  echo ""
  read -p "是否继续创建并安装？(y/N) " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "已取消"
    exit 1
  fi
fi

# 创建 skill 目录
mkdir -p "$HOME/.workbuddy/skills"

# 如果已存在，提示覆盖
if [ -d "$INSTALL_DIR" ]; then
  echo "⚠️  已存在旧版本，将覆盖安装"
  read -p "继续？(y/N) " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "已取消"
    exit 1
  fi
  rm -rf "$INSTALL_DIR"
fi

# 复制文件
echo "📦 正在复制文件..."
mkdir -p "$INSTALL_DIR"
cp "$SOURCE_DIR/SKILL.md" "$INSTALL_DIR/"
cp "$SOURCE_DIR/instruction.md" "$INSTALL_DIR/"
cp -r "$SOURCE_DIR/references" "$INSTALL_DIR/"
cp -r "$SOURCE_DIR/examples" "$INSTALL_DIR/"
[ -d "$SOURCE_DIR/assets" ] && cp -r "$SOURCE_DIR/assets" "$INSTALL_DIR/"

echo ""
echo "✅ 安装完成！"
echo ""
echo "Skill 位置：$INSTALL_DIR"
echo ""
echo "使用方式："
echo "  在 WorkBuddy 对话里输入「按工作流写脚本」「微证券脚本」「筛选这条新闻」"
echo "  等关键词，即可自动加载该 skill。"
echo ""
echo "卸载方式："
echo "  bash scripts/uninstall.sh"
echo ""
