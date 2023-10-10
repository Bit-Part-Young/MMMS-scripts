#!/bin/bash

repo_url=https://gitee.com/sjtu_konglt/MMMS.git
parent_path=MSE6701H

# 检查是否安装git
if [ -x "$(command -v git)" ]; then
    mkdir $parent_path

    git clone $repo_url $parent_path

else
    echo 'Error: git is not installed.' >&2
    exit 1
fi