clear; clc; close all
%  Cesar Augusto Mendes Cordeiro da Silva
%  RA: 211270121
%  Exercício 4: Ângulos Roll, Pitch e Yaw (RPY)

%% (a) Crie três variáveis simbólicas: roll, pitch e yaw.
disp('(a) Crie três variáveis simbólicas: roll, pitch e yaw.')
%  Convenção usada:
%    R = Rz(yaw) * Ry(pitch) * Rx(roll)
%  => rotações intrínsecas (no corpo) yaw→pitch→roll.

% Criar variáveis simbólicas (reais):

syms roll pitch yaw real
% roll  = rotação em torno de x (φ)
% pitch = rotação em torno de y (θ)
% yaw   = rotação em torno de z (ψ)


%% (b) Derive a matriz de rotação correspondente (não utilize eul2rotm).
disp(['(b) Derive a matriz de rotação correspondente (não utilize ' ...
    'eul2rotm).'])

% rotRPY deve montar: R = Rz(yaw) * Ry(pitch) * Rx(roll)
% Cada Ri(·) é a rotação elemental 3x3 em torno do eixo i.
R = rotRPY(roll, pitch, yaw);

disp('Matriz de rotacao R (Z-Y-X):');
disp(simplify(R));   % simplifica expressões (não altera o significado)


%% (c) Aplique essa matriz para transformar o vetor unitário na direção z.
disp(['(c) Aplique essa matriz para transformar o vetor unitário na ' ...
    'direção z.'])

z_unit = [0; 0; 1]; % z do "mundo"
z_transformado = simplify(R * z_unit);
% Obs: R * [0;0;1] devolve exatamente a 3a coluna de R,
%      que é a direção do eixo z do corpo expressa no mundo.
disp('Vetor z transformado (direcao do z do corpo no mundo):');
disp(z_transformado);


%% (d) A partir dos elementos da matriz, proponha um algoritmo para 
% recuperar os ângulos (dica: encontre o pitch primeiro).
disp(['(d) A partir dos elementos da matriz, proponha um algoritmo para ' ...
    'recuperar os ângulos (dica: encontre o pitch primeiro).'])

% Teste do código de recuperação, exemplo numérico:
roll_val  =  pi/6;   %  30°
pitch_val =  pi/8;   %  22.5°
yaw_val   = -pi/4;   % -45°

% Substitui os símbolos por números e avalia R:
Rnum = double(subs(R, [roll, pitch, yaw], [roll_val, pitch_val, yaw_val]));

% rpy_from_matrix deve implementar a extração para Z–Y–X:
% 1) pitch = atan2(-R31, sqrt(R11^2 + R21^2))   (encontre pitch primeiro)
% 2) roll  = atan2(R32, R33)
% 3) yaw   = atan2(R21, R11)
% Tratando gimbal lock quando |cos(pitch)| ~ 0.
[r_rec, p_rec, y_rec] = rpy_from_matrix(Rnum);

disp('Angulos originais [rad]   (roll, pitch, yaw):');
disp([roll_val, pitch_val, yaw_val]);
disp('Angulos recuperados [rad] (roll, pitch, yaw):');
disp([r_rec, p_rec, y_rec]);