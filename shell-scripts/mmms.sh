#!/bin/bash


# 配置~/.vimrc
echo -e "Vim configuration is starting to download...\n"

vim_file=.vimrc
file_url=https://gitee.com/yangsl306/MMMS-scripts/raw/main/shell-scripts/
if [ -f $HOME/${vim_file} ]; then
    cp $HOME/${vim_file}{,.bak}
fi

wget https://gitee.com/yangsl306/MMMS-scripts/blob/main/shell-scripts/${vim_file} -O $HOME/${vim_file}

echo -e "\nVim configuration has been downloaded to $HOME/${vim_file}.\n"


# 配置~/.bashrc
echo -e "Bash configuration is starting to download...\n"

bashrc_file=.bashrc
if [ -f $HOME/${bashrc_file} ]; then
    cp $HOME/${bashrc_file}{,.bak}
fi

wget https://gitee.com/yangsl306/MMMS-scripts/blob/main/shell-scripts/${bashrc_file} -O $HOME/${bashrc_file}

echo -e "\nBash configuration has been downloaded to $HOME/${bashrc_file}.\n"


# 创建 ~/bin 目录
if [ ! -d $HOME/bin ]; then
    mkdir $HOME/bin
fi


# 检查是否安装git以安装MMMS课程上机实验材料
repo_url=https://gitee.com/sjtu_konglt/MMMS.git
parent_path=$HOME/MSE6701H

if [ -x "$(command -v git)" ]; then

    if [ ! -d ${parent_path} ]; then
        mkdir ${parent_path}

        cd ${parent_path}

        echo -e "MMMS course materials is starting to download...\n"
        git clone $repo_url

        echo -e "\nMMMS course materials has been downloaded to ${parent_path}.\n"

        cd - > /dev/null
    else
        echo -e "MMMS course materials has been downloaded to ${parent_path}.\n"
    fi

else
    echo 'Error: git is not installed.' >&2
    exit 1
fi


# source ~/.bashrc
source ~/.bashrc
