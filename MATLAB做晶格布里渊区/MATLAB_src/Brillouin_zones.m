%{
@author: Liang Hanpu
@date: 2019/3/25
@description: 本程序用于计算一些简单晶格的布里渊区并做图。
              目前仍是未完成状态，只是开个坑占个位，提醒我还要做这东西。
%}

clc, clear, close all

% 晶格常数
a = 2;
% 基矢
a1 = a/2*[0, 1, 1];
a2 = a/2*[1, 0, 1];
a3 = a/2*[1, 1, 0];

[b1, b2, b3] = reciprocalLattice(a1, a2,a3);

%% 作图
% 基础设置
figure
axis equal
hold on
grid on
view(-37.5, 30)
xlabel('x')
ylabel('y')
zlabel('z')

% 基矢矢量
plotVector(b1, b2, b3)
% 布里渊区边界
plotFace(b1)

function plotVector(b1, b2, b3)
    plot3([0 b1(1)], [0 b1(2)], [0 b1(3)])
    plot3([0 b2(1)], [0 b2(2)], [0 b2(3)])
    plot3([0 b3(1)], [0 b3(2)], [0 b3(3)])
end

function plotFace(b)
% 计算面的方程并且作图
%   如何判断面的大小？？
    rho = sqrt(sum(b.^2));
    theta0 = acos(b(3)/rho);
    phi0 = atan(b(2)/b(1));
    theta = linspace(theta0*5/10, theta0*15/10, 10);
    phi = linspace(phi0*5/10, phi0*15/10, 10);
    
    [T, P] = meshgrid(theta, phi);
    
    x = rho*sin(T).*cos(P);
    y = rho*sin(T).*sin(P);
    % z = rho*cos(T);
    z = -1/b(3)*(b(1)*x + b(2)*y - b(1)^2-b(2)^2)+b(3)
    mesh(x, y, z)
end




function [b1, b2, b3] = reciprocalLattice(a1, a2, a3)
% 晶格基矢转为倒格子矢量
    V = a1*cross(a2, a3)';
    b1 = 2*pi*cross(a2, a3)/V;
    b2 = 2*pi*cross(a3, a1)/V;
    b3 = 2*pi*cross(a1, a2)/V;
end
    