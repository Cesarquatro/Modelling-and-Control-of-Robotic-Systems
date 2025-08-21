close all; clear; clc;
%% 

% Criação do Sistema de referência A
theta = 0.3;     % ângulo em relação ao sistema XY
R = rot2(theta)

% Plot
trplot2(R, 'frame', 'A', 'color', 'b')
axis equal

% Verificação, Det = 1 (sistema destro, segue a regra da mão direita)
det(R)
det(R*R)

%% Trabalhar com valores simbólicos:
syms theta real

R = rot2(theta)
simplify(R*R)
det (R)