clc; clear; close all
%  Cesar Augusto Mendes Cordeiro da Silva
%  RA: 211270121
%  Lista 2
%  Exercício 2: Controle para Alcançar um Ponto
%  Implemente o modelo \texttt{sl\_drivepoint} no Simulink, conforme
%  apresentado em aula. O objetivo é conduzir o robô de uma posição inicial
%  ($x_0$, $y_0$, $\theta_0$) até um ponto de destino ($x^*$, $y^*$

%% (a) Varie os ganhos de controle $K_v$ (velocidade linear) e $K_h$ 
% (direção) e observe o comportamento da trajetória.
xg = [4 2];   % Posição final
x0 = [0 0 0]; % Posição inicial