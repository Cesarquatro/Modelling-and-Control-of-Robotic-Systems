function [roll, pitch, yaw] = rpy_from_matrix(R)
% RPY_FROM_MATRIX  Extrai (roll, pitch, yaw) de uma matriz de rotação R 
% (ordem Z–Y–X).

% Convenção: R = Rz(yaw) * Ry(pitch) * Rx(roll)
%   roll  (φ)  -> rotação em torno do eixo X
%   pitch (θ)  -> rotação em torno do eixo Y
%   yaw   (ψ)  -> rotação em torno do eixo Z

% Ideia:
%   1) Encontre primeiro o pitch (θ). Para Z–Y–X, R(3,1) = -sin(θ).
%   2) Se cos(θ) ≠ 0 (não há gimbal lock), extraia:
%        roll = atan2(R(3,2), R(3,3))
%        yaw  = atan2(R(2,1), R(1,1))
%   3) Se cos(θ) ≈ 0 (gimbal lock, θ ≈ ±90°), há infinitas combinações
%      (roll,yaw).
%      Fixamos roll = 0 e recuperamos yaw a partir de outra relação.

% Observações:
%   - Usamos atan2(·,·) para manter a informação de quadrante.
%   - Tolerância numérica ‘epsCos’ evita divisões instáveis quando]
%     cos(θ) ~ 0.
%   - Assumimos R ∈ SO(3) (ortonormal e det=+1).

% ----- 1) Pitch (encontrar primeiro)
% Forma direta: pitch = -asin(R(3,1)).
% Alternativa mais robusta numericamente:
%   pitch = atan2(-R(3,1), sqrt(R(1,1)^2 + R(2,1)^2));


pitch = -asin( max(-1,min(1, R(3,1))) );  
% clamp para proteger contra ruído numérico

% 2) Verifica singularidade (gimbal lock): cos(pitch) ~ 0
epsCos = 1e-6;
cp = cos(pitch);

if abs(cp) > epsCos
    % Caso regular: cos(pitch) != 0
    % Para Z–Y–X:
    %   roll = atan2(R(3,2), R(3,3))
    %   yaw  = atan2(R(2,1), R(1,1))
    % (estas fórmulas evitam divisão por cos(pitch) e são mais estáveis)
    roll = atan2( R(3,2), R(3,3) );
    yaw  = atan2( R(2,1), R(1,1) );
else
    % Caso singular (gimbal lock): pitch ≈ ±90°
    % Fixamos roll = 0 (convencional) e recuperamos yaw usando elementos 
    % remanescentes.
    roll = 0;

    % Se R(3,1) ≈ -1 => pitch ≈ +90°; se R(3,1) ≈ +1 => pitch ≈ -90°
    % Use elementos da primeira linha para obter yaw preservando quadrante.
    if R(3,1) < 0   % ~ +90°
        % R ~ Rz(yaw) * Ry(+pi/2) * Rx(roll); uma forma consistente:
        yaw = atan2( -R(1,2), -R(1,3) );
    else            % ~ -90°
        yaw = atan2(  R(1,2),  R(1,3) );
    end
end

end