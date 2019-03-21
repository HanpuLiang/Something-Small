%{
@author: Liang Hanpu
@date: 2019/3/21

@description1: 设定出单个元胞并做图
    晶格参数a1, a2, a3; alpha, beta, gamma
    各原子坐标
@description2: 设定超胞大小并做图
@description3: 因为难度原因, 只能beta=gamma=pi/2
@description4: 一般情况下，简单立方是最基础的内容框架
    面心立方和体心立方是在简单立方的基础上添加原子的
@description5: 可以设置原子大小和颜色
%}

clc, clear, close all
%% 晶胞参数
global cell_size a1 a2 a3 alpha beta gamma
% 晶格常数
a = [1, 1, 1];
% 三个角度
angle = [pi/2, pi/2, pi/2];
% 超胞大小
cell_size = [2, 2, 2];
% 简单立方
position1 = [0, 0, 0; ...
           1, 1, 0; ...
           1, 0, 0; ...
           0, 1, 0; ...
           0, 0, 1; ...
           1, 1, 1; ...
           1, 0, 1; ...
           0, 1, 1];
% 体心
position2 = [0.5, 0.5, 0.5];
% 面心
position3 = [0, 0.5, 0.5; ...
             0.5, 0, 0.5; ...
             0.5, 0.5, 0; ...
             1, 0.5, 0.5; ...
             0.5, 1, 0.5; ...
             0.5, 0.5, 1];

[a1, a2, a3] = deal(a(1), a(2), a(3));
[alpha, beta, gamma] = deal(angle(1), angle(2), angle(3));
%% 作图
figure
% 作图设置
hold on, axis equal
axis image off
view(-37.5, 30)

% 做超胞框架
plotBox();
% 做各个原子
plotAtoms(position2, [244, 13, 100]/255, 40);
plotAtoms(position1, [29, 191, 151]/255, 50);   %简单立方的一定要放在最后面
title('Made by Liang Hanpu')

%% 函数区
function plotBox()
% 做边框
    global a1 a2 a3 alpha beta gamma cell_size 
    % 超胞的边长
    [A1, A2, A3] = deal(a1*cell_size(1), a2*cell_size(2), a3*cell_size(3));
    % 8个顶点
    vertex = [0, 0, 0;...
              A1, 0, 0;...
              A2*cos(alpha), A2*sin(alpha), 0;...
              A2*cos(alpha)+A1, A2*sin(alpha), 0;...
              0, 0, A3;...
              A1, 0, A3;...
              A2*cos(alpha), A2*sin(alpha), A3;...
              A2*cos(alpha)+A1, A2*sin(alpha), A3];
    % 12个边
    plotLine(vertex(1,:), vertex(2,:))
    plotLine(vertex(1,:), vertex(3,:))
    plotLine(vertex(2,:), vertex(4,:))
    plotLine(vertex(3,:), vertex(4,:))
    plotLine(vertex(5,:), vertex(6,:))
    plotLine(vertex(5,:), vertex(7,:))
    plotLine(vertex(6,:), vertex(8,:))
    plotLine(vertex(7,:), vertex(8,:))
    plotLine(vertex(1,:), vertex(5,:))
    plotLine(vertex(2,:), vertex(6,:))
    plotLine(vertex(3,:), vertex(7,:))
    plotLine(vertex(4,:), vertex(8,:))
end

function plotAtoms(position, markercolor, markersize)
% 做各原子图像
    global cell_size a1 a2 a3 alpha beta gamma
    % 原始晶胞
    % plot3(position(:,1), position(:,2), position(:,3), 'ok', 'linewidth', 1.5, 'markersize', 50, 'markerfacecolor', [29,191,151]/255)
    % 超胞
    % 遍历得到超胞所有原子
    cur_point = position;
    for i1 = 1:cell_size(1)
        for i2=1:cell_size(2)
            for i3=1:cell_size(3)
                x_plus = a1*(i1-1) + a2*cos(alpha)*(i1-1);
                y_plus = a2*sin(alpha)*(i2-1);
                z_plus = a3*(i3-1);
                cur_point = [cur_point; [position(:,1)+x_plus position(:,2)+y_plus position(:,3)+z_plus]];
            end
        end
    end
    plot3(cur_point(:,1), cur_point(:,2), cur_point(:,3), 'ok', 'linewidth', 1.5, 'markersize', markersize, 'markerfacecolor', markercolor)
    % 设置坐标轴大小
    [x_min, x_max, y_min, y_max, z_min, z_max] = deal(min(cur_point(:,1)), max(cur_point(:,1)), ...
                                                      min(cur_point(:,2)), max(cur_point(:,2)), ...
                                                      min(cur_point(:,3)), max(cur_point(:,3)));
    x_len = (x_max - x_min)/6;
    y_len = (y_max - y_min)/6;
    z_len = (z_max - z_min)/6;
    axis([x_min-x_len x_max+x_len y_min-y_len y_max+y_len z_min-z_len z_max+z_len])
end

function plotLine(x1, x2)
% 做两个点之间的框架线
    plot3([x1(1) x2(1)], [x1(2), x2(2)], [x1(3), x2(3)], 'k', 'linewidth', 1.3)
end
    