#!/bin/bash


# 配置 ~/.vimrc
#-------------------------------------------------------------------------------
echo -e "Vim config file is starting to download...\n"

vim_file=$HOME/.vimrc
file_url=https://gitee.com/yangsl306/MMMS-scripts/raw/main/shell-scripts
if [ -f ${vim_file} ]; then
    cp ${vim_file}{,.bak}
fi

wget ${file_url}/$(basename ${vim_file}) -O ${vim_file}

echo -e "\nVim config file has been downloaded to ${vim_file}.\n"
#-------------------------------------------------------------------------------


# 配置 ~/.bashrc
#-------------------------------------------------------------------------------
echo -e "Bash config file is starting to download...\n"

bashrc_file=$HOME/.bashrc
if [ -f ${bashrc_file} ]; then
    cp ${bashrc_file}{,.bak}
fi

wget ${file_url}/$(basename ${bashrc_file}) -O ${bashrc_file}

echo -e "\nBash config file has been downloaded to ${bashrc_file}.\n"
#-------------------------------------------------------------------------------


# 配置 ~/.inputrc
#-------------------------------------------------------------------------------
echo -e "Readline config file is starting to download...\n"

inputrc_file=$HOME/.inputrc
if [ -f ${inputrc_file} ]; then
    cp ${inputrc_file}{,.bak}
fi

wget ${file_url}/$(basename ${inputrc_file}) -O ${inputrc_file}

echo -e "\nReadline config file has been downloaded to ${inputrc_file}.\n"
#-------------------------------------------------------------------------------


# 创建 ~/bin 目录
if [ ! -d $HOME/bin ]; then
    mkdir $HOME/bin
fi


# 检查是否安装 git 以安装 MMMS 课程上机实验材料
#-------------------------------------------------------------------------------
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
