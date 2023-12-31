#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#=================================================================#
#   System Required: CentOS7 X86_64                               #
#   Description: FFmpeg Stream Media Server                       #
#   Author: LALA                                    #
#   Website: https://www.lala.im                                  #
#=================================================================#

# 颜色选择
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
font="\033[0m"

stream_start(){
    # 定义推流地址
    read -p "输入你的推流地址 (rtmp或https协议):" rtmp

    # 判断用户输入的地址是否合法
    if [[ $rtmp =~ ^(rtmp|https):// ]]; then
        echo -e "${green} 推流地址输入正确,程序将进行下一步操作. ${font}"
        sleep 2
    else  
        echo -e "${red} 你输入的地址不合法,请重新运行程序并输入! ${font}"
        exit 1
    fi 

    echo -e "${yellow} 程序将开始转发直播流. ${font}"
    
    # 循环
    while true
    do
        ffmpeg -tls_verify 1 -rtmp_ssl_verify 1 -i "${rtmp}" -c:v copy -c:a aac -b:a 192k -strict -2 -f flv "rtmp://your-rtmp-server/your-stream-key" # 将 "your-rtmp-server/your-stream-key" 替换为您的直播地址和流密钥
    done
}

# 开始菜单设置
echo -e "${yellow} CentOS7 X86_64 FFmpeg无人值守循环推流 For LALA.IM ${font}"
echo -e "${red} 请确定此脚本目前是在screen窗口内运行的! ${font}"
echo -e "${green} 1.开始无人值守循环推流 ${font}"
echo -e "${green} 2.停止推流 ${font}"

start_menu(){
    read -p "请输入数字(1-2),选择你要进行的操作:" num
    case "$num" in
        1)
        stream_start
        ;;
        2)
        screen -S stream -X quit
        ;;
        *)
        echo -e "${red} 请输入正确的数字 (1-2) ${font}"
        ;;
    esac
}

# 运行开始菜单
start_menu
