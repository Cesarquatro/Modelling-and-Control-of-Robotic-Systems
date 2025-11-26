clc; clear; close all
%  Cesar Augusto Mendes Cordeiro da Silva
%  RA: 211270121
%  Lista 2
%  Exercício 1: Eixo-Parafuso (Screw Axis)
% Considere um veículo com distância entre eixos L = 2 m (a 
% distância longitudinal entre o eixo dianteiro e o eixo traseiro) 
% e bitola W = 1,5 m (correspondente à distância lateral entre os 
% centros das rodas de um mesmo eixo (esquerda e direita)).

%% (a) Para uma velocidade de v = 20 km/h e uma taxa de guinada 
% $\dot{\theta} $ = 10\degree /s, determine o ângulo de esterçamento 
% $\psi$ necessário.

disp('(a) Determine o ângulo de esterçamento \psi necessário:')

L = 2;   % Entre-Eixo [m]
W = 1.5; % Bitola [m]

v_km = 20;         % Velocidade linear [Km/h]
v_ms = v_km / 3.6; % Velocidade linear [m/s]

th_degree = 10;                 % Guinada [°/s]
th_rad    = th_degree * pi/180; % Guinada [rad/s]

% θ' = v/R_B
% R_B = L/tg(psi)
% ∴ psi = arctg((L*θ')/v)

psi = atan((L*th_rad)/v_ms);
disp(['ψ = ', num2str(psi), ' rad'])
disp(['ψ = ', num2str(rad2deg(psi)), '°'])

%% (b) Calcule a diferença entre os ângulos de esterçamento das rodas
% dianteiras esquerda e direita, em um sistema de direção do tipo
% Ackermann, para curvas de raio $R = 10, 50$ e $100$ m.
disp(' ')
disp('(b) Calcule a diferença entre os ângulos de esterçamento:')

R1 = 10;
R2 = 50;
R3 = 100;

% (R_B-(W/2)) = L/tg(psi_i)
% (R_B+(W/2)) = L/tg(psi_o)

% \therefore psi_i = 
% arctg((2L)/(2R-W)) e psi_o = arctg((2L)/(2R+W))

% \therefore psi_i - psi_o =
% arctg((2L)/(2R-W)) - arctg((2L)/(2R+W))

% Diferenças entre ângulos das rodas 1
delta_psi1 = atan((2*L)/(2*R1-W)) - atan((2*L)/(2*R1+W)); 
disp(['ΔΨ1 = ', num2str(delta_psi1), ' rad'])
disp(['ΔΨ1 = ', num2str(rad2deg(delta_psi1)), '°'])

% Diferenças entre ângulos das rodas 2
delta_psi2 = atan((2*L)/(2*R2-W)) - atan((2*L)/(2*R2+W));
disp(' ')
disp(['ΔΨ2 = ', num2str(delta_psi2), ' rad'])
disp(['ΔΨ2 = ', num2str(rad2deg(delta_psi2)), '°'])

% Diferenças entre ângulos das rodas 3
delta_psi3 = atan((2*L)/(2*R3-W)) - atan((2*L)/(2*R3+W));
disp(' ')
disp(['ΔΨ3 = ', num2str(delta_psi3), ' rad'])
disp(['ΔΨ3 = ', num2str(rad2deg(delta_psi3)), '°'])
%% (c) Supondo que o veículo esteja se movendo a 80 km/h, determine a 
% diferença nas velocidades angulares das rodas traseiras para essas 
% mesmas curvas.
disp(' ')
disp(['(c) determine a diferença nas velocidades angulares das ' ...
    'rodas traseiras:'])

% θ' = v_Δ/W
vnovo_ms = 80/3.6; % Velocidade linear [m/s]

delta_th_linha_1 = (2*vnovo_ms)/(2*R1-W) - (2*vnovo_ms)/(2*R1+W); 
disp(['Δθ`1 = ', num2str(delta_th_linha_1), ' rad/s'])
disp(['Δθ`1 = ', num2str(rad2deg(delta_th_linha_1)), '°/s'])

delta_th_linha_2 = (2*vnovo_ms)/(2*R2-W) - (2*vnovo_ms)/(2*R2+W);
disp(' ')
disp(['Δθ`2 = ', num2str(delta_th_linha_2), ' rad/s'])
disp(['Δθ`2 = ', num2str(rad2deg(delta_th_linha_2)), '°/s'])

delta_th_linha_3 = (2*vnovo_ms)/(2*R3-W) - (2*vnovo_ms)/(2*R3+W); 
disp(' ')
disp(['Δθ`3 = ', num2str(delta_th_linha_3), ' rad/s'])
disp(['Δθ`3 = ', num2str(rad2deg(delta_th_linha_3)), '°/s'])