function plot_cube(Vh, E, T, coloSpec)

% Transformação homogênea
Vt = T * Vh;

% Plot
hold on
for k = 1:size(E, 1)
    P = Vt(1:3, E(k, :));
    plot3(P(1,:), P(2,:), P(3,:), '-', 'LineWidth', 2, 'Color', coloSpec);
end

axis('equal'); grid('on'); view(3)

end