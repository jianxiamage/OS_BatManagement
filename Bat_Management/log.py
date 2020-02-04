#!/usr/bin/env python
#coding=utf-8

import os
import sys

import logging

#日志等级（level） 	描述
#DEBUG 	                最详细的日志信息，典型应用场景是 问题诊断
#INFO 	                信息详细程度仅次于DEBUG，通常只记录关键节点信息，用于确认一切都是按照我们预期的那样进行工作
#WARNING 	        当某些不期望的事情发生时记录的信息（如，磁盘可用空间较低），但是此时应用程序还是正常运行的
#ERROR 	                由于一个更严重的问题导致某些功能不能正常运行时记录的信息
#CRITICAL 	        当发生严重错误，导致应用程序不能继续运行时记录的信息

#%Y-%m-%d\ %T
#LOG_FORMAT = "%(asctime)s - %(levelname)s - %(user)s[%(ip)s] - %(message)s"
#DATE_FORMAT = "%m/%d/%Y %H:%M:%S %p"

#For example:
#logging.debug('debug 信息')
#logging.info('info 信息')
#logging.warning('warning 信息')
#logging.error('error 信息')
#logging.critical('critial 信息')



logging.basicConfig(level=logging.INFO,           #控制台打印的日志级别
                    filename='/var/log/OS-Test.log',
                    filemode='a',                 #模式，有w和a，w就是写模式，每次都会重新写日志，覆盖之前的日志
                                                  #a是追加模式，默认如果不写的话，就是追加模式
                    format=
                    #'%(asctime)s - %(pathname)s[line:%(lineno)d] - %(levelname)s: %(message)s'
                    '[%(levelname)s : %(asctime)s] : %(message)s',
                    #datefmt = "%m/%d/%Y %H:%M:%S"
                    datefmt = "%Y-%m-%d %T"
                    )


if __name__ == '__main__':
  strArgs=sys.argv
