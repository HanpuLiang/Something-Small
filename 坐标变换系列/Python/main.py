# -*- coding: utf-8 -*-
"""
Created on Fri Mar 23 19:15:51 2018

@author: vento
"""

import numpy as np

def Move(a, x, X1, Y1, Z1):
    '''对坐标进行平移操作'''
    #确定坐标轴与位移矩阵
    if a == 1:
        move = np.array([[x], [0], [0]])
    elif a == 2:
        move = np.array([[0], [x], [0]])
    elif a == 3:
        move = np.array([[0], [0], [x]])
    
    #数组的大小
    s = X1.shape
    
    #初始化操作后的数组
    X2, Y2, Z2 = [np.zeros(s) for i in range(3)]
    
    for i in range(s[0]):
        #进行操作
        temp = np.vstack((X1[i,:], Y1[i,:], Z1[i,:])) + move*np.ones(s[1])
        X2[i,:] = temp[0,:]
        Y2[i,:] = temp[1,:]
        Z2[i,:] = temp[2,:]
    return X2, Y2, Z2

def Rotate(a, theta, X1, Y1, Z1):
    '''对坐标进行旋转操作'''
    if a == 1:
        rotate = np.array([[1, 0, 0], [0, np.cos(theta), np.sin(theta)], [0, -np.sin(theta), np.cos(theta)]])
    elif a == 2:
        rotate = np.array([[np.cos(theta), 0, -np.sin(theta)], [0, 1, 0], [np.sin(theta), 0, np.cos(theta)]])
    elif a == 3:
        rotate = np.array([[np.cos(theta), np.sin(theta), 0], [-np.sin(theta), np.cos(theta), 0], [0, 0, 1]])
    
    s = X1. shape
    
    X2, Y2, Z2 = [np.zeros(s) for i in range(3)]
    
    for i in range(s[0]):
        temp = np.dot(rotate,np.vstack((X1[i,:], Y1[i,:], Z1[i,:])))
        X2[i,:] = temp[0,:]
        Y2[i,:] = temp[1,:]
        Z2[i,:] = temp[2,:]
    return X2, Y2, Z2

X = np.array([[1, 2, 3, 4, 5]])
Y = np.array([[1, 2, 3, 4, 5]])
Z = np.array([[0, 0, 0, 0, 0]])

X1, Y1, Z1 = Rotate(3, np.pi/2, X, Y, Z)

print(X1, Y1, Z1)

