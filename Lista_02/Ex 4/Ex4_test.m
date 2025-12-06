clc; close all
%  Cesar Augusto Mendes Cordeiro da Silva
%  RA: 211270121
%  Lista 2
%  Exercício 4: Controle para Alcançar um Ponto
%  Teste de diferentes conjuntos de ganhos para o Ex_4_Alcancar_sim
% --------------------------------------------------------------

% Pose inicial e final
x0 = [0 4 pi/6];
xg = [6 9 pi];

gains = [
    1.0   5.0   -2.0;
    2.0   6.0   -2.5;
    0.8   3.0   -1.0;
    1.5   1.7   -0.1
];

model = 'Ex_4_Alcancar_sim';
load_system(model);

figure; hold on; grid on;
colors = lines(size(gains,1));

for i = 1:size(gains,1)
    Krho   = gains(i,1);
    Kalpha = gains(i,2);
    Kbeta  = gains(i,3);

    sim(model);          % To Workspace cria 'traj'

    x = traj(:,1);
    y = traj(:,2);

    plot(x, y, 'Color', colors(i,:), 'LineWidth', 1.8, ...
        'DisplayName', sprintf('K=[%.1f, %.1f, %.1f]', Krho, Kalpha, Kbeta));
end

plot(xg(1), xg(2), 'rx', 'MarkerSize', 12, 'LineWidth', 2);
xlabel('X (m)'); ylabel('Y (m)');
title('Trajetórias para diferentes ganhos (K_\rho, K_\alpha, K_\beta)');
legend('Location','best');