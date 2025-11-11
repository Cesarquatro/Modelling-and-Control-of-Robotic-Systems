function R = rotRPY(roll, pitch, yaw)
% ROTRPY  Matriz de rotação para ângulos Roll–Pitch–Yaw na ORDEM Z–Y–X.

% Convenção adotada (intrínseca, no corpo):
%   R = Rz(yaw) * Ry(pitch) * Rx(roll)
% onde:
%   yaw   (ψ) = rotação em torno do eixo Z,
%   pitch (θ) = rotação em torno do eixo Y,
%   roll  (φ) = rotação em torno do eixo X.

% OBS:
% - Os ângulos devem estar em RADIANOS.
% - Esta ordem Z–Y–X (yaw→pitch→roll) é diferente de outras convenções
%   comuns (p.ex., XYZ ou ZYX extrínseco). Trocar a ordem muda R.
% - Para uso numérico, `simplify` não é necessário (é útil apenas no modo
%   simbólico); mantemos aqui por conveniência.
% - Propriedades: R ∈ SO(3) → R'*R = I e det(R) = +1.

% Input:
%   roll  : rotação em torno de x (φ)
%   pitch : rotação em torno de y (θ)
%   yaw   : rotação em torno de z (ψ)

% Output:
%   R     : matriz de rotação 3x3 equivalente

% Rotação elemental em torno de Z (yaw = ψ)
Rz = [ cos(yaw)  -sin(yaw)   0;
       sin(yaw)   cos(yaw)   0;
           0          0      1 ];

% Rotação elemental em torno de Y (pitch = θ)
Ry = [ cos(pitch)   0   sin(pitch);
            0       1        0;
      -sin(pitch)   0   cos(pitch) ];

% Rotação elemental em torno de X (roll = φ)
Rx = [ 1      0           0;
       0   cos(roll)  -sin(roll);
       0   sin(roll)   cos(roll) ];

% Ordem intrínseca Z–Y–X: aplica-se Rx, depois Ry, depois Rz ao vetor no corpo.
% Na convenção de pós-multiplicação: R = Rz * Ry * Rx
R = simplify(Rz * Ry * Rx);

end
