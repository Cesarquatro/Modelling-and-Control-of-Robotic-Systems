clear; clc; close all
%  Cesar Augusto Mendes Cordeiro da Silva
%  RA: 211270121
%  Exercício 3: Relação Entre Dois Referenciais

%% (a) Crie duas matrizes de rotação diferentes (2D ou 3D), representando 
% os frames f_{A} e f_{B}.
disp(['(a) Crie duas matrizes de rotação diferentes (2D ou 3D), representando ' ...
      'os frames f_{A} e f_{B}'])
% Usamos as funções do Robotics Toolbox (trotx/troty/trotz) que retornam 
% T 4x4. Extraímos apenas o bloco 3x3 de rotação para trabalhar com R em
% SO(3).

RAz = trotz(pi/6);   % Rot em torno de Z ( 30°) p/ compor o frame A
RAy = troty(pi/4);   % Rot em torno de Y ( 45°) p/ compor o frame A
RBx = trotx(pi/3);   % Rot em torno de X ( 60°) p/ compor o frame B
RBy = troty(-pi/6);  % Rot em torno de Y (-30°) p/ compor o frame B

% Extrai somente a parte de rot (3x3) das transformações homogêneas:
RAz = RAz(1:3,1:3);
RAy = RAy(1:3,1:3);
RBx = RBx(1:3,1:3);
RBy = RBy(1:3,1:3);

% Combinações de rotações puras 3x3.
% OBS (convenção pós-multiplicativa): RA = RAz * RAy aplica primeiro RAy, depois RAz.
RA = RAz * RAy;   % Rotação absoluta do frame A no mundo
RB = RBx * RBy;   % Rotação absoluta do frame B no mundo

disp('Matriz de rotação do frame A (RA):');
disp(RA);   % Dica: antes estava 'disp(''RA'')', o que mostra só o texto
disp('Matriz de rotação do frame B (RB):');
disp(RB);


%% (b) Determine as matrizes $^AR_B$ e $^BR_A$.
disp('(b) Determine as matrizes $^AR_B$ e $^BR_A$.')
% ^A R_B: leva vetores expressos no frame B para o frame A (orientação de 
% B vista por A). Para rotações puras, R^{-1} = R^T.
A_R_B = RA' * RB;   % ^A R_B = R_A^T R_B
B_R_A = RB' * RA;   % ^B R_A = R_B^T R_A = (^A R_B)^T

disp('^A R_B (rotação de B em relação a A):');
disp(A_R_B);
disp('^B R_A (rotação de A em relação a B):');
disp(B_R_A);

%% (c) Expresse cada rotação como eixo-ângulo.
disp('(c) Expresse cada rotação como eixo-ângulo.')
% Função utilitária 'eixo_angulo(R)' deve retornar:
%   - eixo unitário k (3x1)
%   - ângulo theta (rad)
% Relaciona-se por: R = exp( theta * [k]_x )
[eixoA, angA] = angle_axis(RA);
[eixoB, angB] = angle_axis(RB);

disp('Frame A (axis-angle):');
disp(['  eixo^T = [', num2str(eixoA.', ' %.6f'), ' ]']);
disp(['  angulo = ', num2str(angA, '%.6f'), ' rad']);

disp('Frame B (axis-angle):');
disp(['  eixo^T = [', num2str(eixoB.', ' %.6f'), ' ]']);
disp(['  angulo = ', num2str(angB, '%.6f'), ' rad']);

%% (d) Expresse tamb ́em como um twist.
disp('(d) Expresse tamb ́em como um twist.')
% Para rotação pura, log(R) = theta * [k]_x. O "twist" angular é 
% omega = theta * k. A função 'rot2twist(R)' pode retornar:
%   - omega (3x1), o vetor de rotação, OU
%   - a matriz skew-simétrica Omega = log(R), OU
%   - um twist 6x1 [v; omega] com v=0 (sem translação).
twistA = calc_rot2twist(RA);
twistB = calc_rot2twist(RB);

disp('Twist (parte angular) equivalente para frame A:');
disp(twistA);
disp('Twist (parte angular) equivalente para frame B:');
disp(twistB);