clear; clc; close all
%  Cesar Augusto Mendes Cordeiro da Silva
%  RA: 211270121
%  Exercício 1: Cubo Rotativo

%% (a) Função para plotar as arestas de um cubo centrado na origem
% Implementada abaixo como local function: plotCubeEdges(ax, H, L, style)
% Uso mínimo (identidade):
figure('Name','(a) Cubo centrado na origem','Color','w');
ax = gca; axis(ax,'equal'); grid(ax,'on'); hold(ax,'on');
xlabel('x'); ylabel('y'); zlabel('z'); view(135,25);
plot3(0,0,0,'k.','MarkerSize',12);  % origem
plotFrame(ax, eye(4), 0.8);          % eixos de referência
plotCubeEdges(ax, eye(4), 1.0, {'LineWidth',1.8}); % L=1

%% (b) Aplicar transformação homogênea antes do plot
% Exemplo: translação + rotação em Z
H = transl(0.5, -0.2, 0.3) * Rz(pi/6);
figure('Name','(b) Cubo transformado','Color','w');
ax = gca; axis(ax,'equal'); grid(ax,'on'); hold(ax,'on');
xlabel('x'); ylabel('y'); zlabel('z'); view(135,25);
plotFrame(ax, eye(4), 0.8);
plotFrame(ax, H, 0.6);
plotCubeEdges(ax, H, 1.0, {'LineWidth',1.8});

%% (c) Animação: rotação em torno do eixo x
figure('Name','(c) Rotação em torno de x','Color','w');
ax = gca; axis(ax,'equal'); grid(ax,'on'); hold(ax,'on');
xlabel('x'); ylabel('y'); zlabel('z'); view(135,25);
plotFrame(ax, eye(4), 0.8);
L = 1.0;
n = 180;
for k = 1:n
    th = 2*pi*(k/n);                 % 0 -> 360°
    Hk = Rx(th);                      % rotação em x
    hPlot = plotCubeEdges(ax, Hk, L, {'LineWidth',1.8});
    drawnow;
    if k < n, delete(hPlot); end      % apaga e redesenha (efeito animação)
end

%% (d) Animação: rotação em todos os eixos (x, y, z)
figure('Name','(d) Rotação em x,y,z','Color','w');
ax = gca; axis(ax,'equal'); grid(ax,'on'); hold(ax,'on');
xlabel('x'); ylabel('y'); zlabel('z'); view(135,25);
plotFrame(ax, eye(4), 0.8);
L = 1.0;
n = 240;
for k = 1:n
    thx = 2*pi*(k/n);
    thy = 2*pi*(k/n)*0.75;
    thz = 2*pi*(k/n)*0.5;
    Hk  = Rz(thz) * Ry(thy) * Rx(thx); % ordem Z*Y*X
    hPlot = plotCubeEdges(ax, Hk, L, {'LineWidth',1.8});
    drawnow;
    if k < n, delete(hPlot); end
end

%% Observações breves (para o relatório)
% - O cubo é definido por 8 vértices (±L/2) e 12 arestas; a transformação
%   homogênea H (4x4) é aplicada nos vértices em coordenadas homogêneas.
% - Em (c), a rotação em x mantém as coordenadas y–z do cubo girando
%   em torno do eixo x; em (d), a composição de rotações muda o eixo
%   instantâneo, produzindo trajetórias mais ricas dos vértices.

%% ======= Funções locais (auto-contidas) =======

function h = plotCubeEdges(ax, H, L, styleArgs)
% Desenha as arestas de um cubo de lado L, centrado na origem, após
% aplicar a transformação homogênea H (4x4).
    if nargin < 4, styleArgs = {}; end
    % vértices (±L/2)
    s = L/2;
    V = [ -s -s -s;
          -s -s  s;
          -s  s -s;
          -s  s  s;
           s -s -s;
           s -s  s;
           s  s -s;
           s  s  s ];
    % converte para homogêneo e transforma
    Vh = [V, ones(8,1)]';
    Vt = (H * Vh)';   % 8x4
    Vt = Vt(:,1:3);   % volta p/ 3D

    % arestas (pares de índices)
    E = [1 2; 1 3; 1 5;
         2 4; 2 6;
         3 4; 3 7;
         4 8;
         5 6; 5 7;
         6 8;
         7 8];

    % desenha
    h = gobjects(size(E,1),1);
    for i=1:size(E,1)
        p = Vt(E(i,:),:);
        h(i) = plot3(ax, p(:,1), p(:,2), p(:,3), 'k-', styleArgs{:});
    end
    axis(ax,'tight');
end

function plotFrame(ax, H, s)
% Desenha um triádico de eixos na pose H (4x4), tamanho s.
    o = H(1:3,4)';
    x = (H(1:3,1)*s)'; y = (H(1:3,2)*s)'; z = (H(1:3,3)*s)';
    plot3(ax, [o(1) o(1)+x(1)], [o(2) o(2)+x(2)], [o(3) o(3)+x(3)], '-', 'LineWidth',1.5);
    plot3(ax, [o(1) o(1)+y(1)], [o(2) o(2)+y(2)], [o(3) o(3)+y(3)], '-', 'LineWidth',1.5);
    plot3(ax, [o(1) o(1)+z(1)], [o(2) o(2)+z(2)], [o(3) o(3)+z(3)], '-', 'LineWidth',1.5);
    text(o(1)+x(1), o(2)+x(2), o(3)+x(3), 'x', 'Color','k', 'FontSize',10,'Parent',ax);
    text(o(1)+y(1), o(2)+y(2), o(3)+y(3), 'y', 'Color','k', 'FontSize',10,'Parent',ax);
    text(o(1)+z(1), o(2)+z(2), o(3)+z(3), 'z', 'Color','k', 'FontSize',10,'Parent',ax);
end

% --- Transformações homogêneas úteis (independentes da Toolbox) ---
function T = transl(x,y,z)
    T = eye(4); T(1:3,4) = [x;y;z];
end
function T = Rx(theta)
    c = cos(theta); s = sin(theta);
    T = [1 0 0 0; 0 c -s 0; 0 s c 0; 1-1 0 0 1]; % 1-1 vira 0, evita má formatação
end
function T = Ry(theta)
    c = cos(theta); s = sin(theta);
    T = [ c 0 s 0; 0 1 0 0; -s 0 c 0; 0 0 0 1];
end
function T = Rz(theta)
    c = cos(theta); s = sin(theta);
    T = [ c -s 0 0; s c 0 0; 0 0 1 0; 0 0 0 1];
end
