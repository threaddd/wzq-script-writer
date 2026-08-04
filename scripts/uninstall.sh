#!/bin/bash
# 微证券视频号脚本撰写 Skill 卸载脚本

SKILL_NAME="weizhengquan-script-writer"
INSTALL_DIR="$HOME/.workbuddy/skills/$SKILL_NAME"

echo "==========================================="
echo "  微证券视频号脚本撰写 Skill 卸载"
echo "==========================================="

if [ ! -d "$INSTALL_DIR" ]; then
  echo "⚠️  未检测到已安装的 skill：$INSTALL_DIR"
  exit 0
fi

read -p "确认卸载 $SKILL_NAME？(y/N) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "已取消"
  exit 0
fi

rm -rf "$INSTALL_DIR"
echo "✅ 卸载完成"
