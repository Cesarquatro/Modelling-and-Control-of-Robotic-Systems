function plot_frame(T, label)
% PLOT_FRAME  Desenha um frame (eixos x,y,z) a partir de uma T ∈ SE(3).

%   T   : matriz homogênea 4x4  [ R  p ; 0 0 0 1 ]
%        - R (3x3): rotação (colunas são as direções dos eixos do frame)
%        - p (3x1): origem do frame no espaço (coordenadas x,y,z)
%   label : string para anotar o nome do frame ao lado da sua origem

% Convenção:
%   - As colunas de R são os eixos do frame expressos no sistema mundial:
%       R(:,1) ≡ eixo x, R(:,2) ≡ eixo y, R(:,3) ≡ eixo z.
%   - Cada eixo é plotado como uma seta partindo da origem p.

% Cores:
%   - x em vermelho, y em verde, z em azul (RGB padrão).

    % Origem (p) e orientação (R) do frame
    origin = T(1:3,4);     % p = [px; py; pz]
    R = T(1:3,1:3);        % R = [x̂ ŷ ẑ], colunas unitárias

    % Fator de escala das setas (0.5): controla o comprimento visual 
    % no plot
    scale = 0.5;

    % Eixo X (vermelho): vetor direção = primeira coluna de R
    quiver3(origin(1), origin(2), origin(3), ...
            R(1,1),     R(2,1),     R(3,1), ...
            scale, 'r', 'LineWidth', 2);
    hold on;

    % Eixo Y (verde): segunda coluna de R
    quiver3(origin(1), origin(2), origin(3), ...
            R(1,2),     R(2,2),     R(3,2), ...
            scale, 'g', 'LineWidth', 2);

    % Eixo Z (azul): terceira coluna de R
    quiver3(origin(1), origin(2), origin(3), ...
            R(1,3),     R(2,3),     R(3,3), ...
            scale, 'b', 'LineWidth', 2);

    % Rótulo do frame próximo à origem
    text(origin(1), origin(2), origin(3), ['  ' label]);
end
