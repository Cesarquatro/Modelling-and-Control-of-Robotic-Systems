clear; clc; close all
%  Cesar Augusto Mendes Cordeiro da Silva
%  RA: 211270121
%  Exercício 5: Eixo-Parafuso (Screw Axis)


%% (a) Gere aleatoriamente uma matriz de transformação T ∈ SE(3).
% Convenções (Modern Robotics):
%   T = exp( [S] * theta ), com S = [ ω ; v ],  ω∈R^3, v∈R^3
%   [S] = [ [ω]x  v ; 0 0 ]  (matriz 4x4 de se(3))
%   Se ||ω|| = 1, então um ponto do eixo é q = ω × v;  pitch h = ω^T v.

disp('(a) Gere aleatoriamente uma matriz de transformação T ∈ SE(3).')

% R: rotação (3x3) em SO(3) | p: translação (3x1)
R = orth(rand(3,3));          % base ortonormal "aleatória"
if det(R) < 0
    R(:,3) = -R(:,3);         % corrige para det(R)=+1 (rotação pura)
end
% OBS: 'orth(rand(3,3))' NÃO é amostragem uniforme em SO(3), mas serve
% para o exercício.

p = rand(3,1)*2 - 1;          % translação uniforme em [-1,1]^3
T = [R p; 0 0 0 1];

disp('Matriz de transformação T = ');
disp(T);

%% (b) Plote o frame de referência e o frame transformado.
disp('(b) Plote o frame de referência e o frame transformado.')

% 'plot_frame' deve desenhar eixos x/y/z a partir de uma T 4x4.
figure;
plot_frame(eye(4), 'Base');   % frame de referência (mundo)
hold on;
plot_frame(T, 'Transformado');
title('Exercício 5 – Eixo-Parafuso (Screw Axis)');
axis equal; grid on; view(135,30);

%% (c) Calcule o eixo-parafuso (twist) que leva o frame de referência até
% o escolhido.
disp(['Calcule o eixo-parafuso (twist) que leva o frame de referência até ' ...
    'o escolhido.'])

% Esperado: T = exp([S] * theta).
%  - Se houver rotação: ||ω||=1 e theta é o ângulo (rad).
%  - Se for translação pura: ||ω||=0 e theta = ||p|| (S retorna [0; p_hat]).
[S, theta] = matrix_Log6(T);


disp('Twist S = [omega; v] = ');
disp(S);
disp(['Ângulo de rotação (rad) / passo de translação: ', num2str(theta)]);

%% (d) Visualize a rotação em torno desse eixo.
disp('(d) Visualize a rotação em torno desse eixo.')

n = S(1:3);                   % parte angular do twist (ω não normalizado)
v = S(4:6);                   % parte linear do twist

if norm(n) < 1e-9
    % Caso especial: translação pura (não há eixo de rotação bem definido)
    % Opcional: desenhar a direção de translação a partir da origem.
    quiver3(0,0,0, v(1),v(2),v(3), 0.5, 'k','LineWidth',1.2);
    text(0,0,0,' Translação pura');
else
    % Movimento helicoidal / rotação (ω ≠ 0)
    w = n / norm(n);          % direção unitária do eixo de rotação
    % Para ||w||=1, um ponto do eixo mais próximo da origem é q = w × v:
    p_axis = cross(w, v);

    % Marca o ponto do eixo e traça um segmento na direção w
    plot3(p_axis(1), p_axis(2), p_axis(3), 'ko', 'MarkerFaceColor','k');
    L = 1.0;                  % meia-extensão do segmento (ajuste visual)
    plot3([p_axis(1)-L*w(1), p_axis(1)+L*w(1)], ...
          [p_axis(2)-L*w(2), p_axis(2)+L*w(2)], ...
          [p_axis(3)-L*w(3), p_axis(3)+L*w(3)], ...
          'k--','LineWidth',1.2);
    text(p_axis(1), p_axis(2), p_axis(3), ' Eixo-Parafuso');

    % (Opcional) pitch do parafuso: h = w^T v
    % h = dot(w, v);
    % fprintf('Pitch (avanco por rad): %.4f\n', h);
end