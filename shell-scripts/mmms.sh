#!/bin/bash

repo_url=https://gitee.com/sjtu_konglt/MMMS.git
parent_path=$HOME/MSE6701H

# 检查是否安装git
if [ -x "$(command -v git)" ]; then
    mkdir ${parent_path}

    cd ${parent_path}

    echo -e "MMMS course materials is starting to download...\n"
    git clone $repo_url ${parent_path}

    echo -e "\nMMMS course materials has been downloaded to ${parent_path}.\n"

    cd - > /dev/null

else
    echo 'Error: git is not installed.' >&2
    exit 1
fi
