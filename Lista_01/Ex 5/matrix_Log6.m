function [S, theta] = matrix_Log6(T)
% MATRIXLOG6  Logaritmo de T ∈ SE(3): T = exp([S] * theta)

% Input:
%   T = [ R  p
%         0  1 ],  com R ∈ SO(3), p ∈ R^3

% Output:
%   S     = [omega; v]  (twist unitário; 6x1)
%   theta = escalar tal que T = exp([S]*theta)

% Casos:
%   - Rotação (||omega||=1):R = exp([omega]× * theta)
%                           p = (I - R)[omega]× v + omega*omega^T*v * theta
%   - Translação pura (omega=0): theta = ||p||,  S = [0; p/||p||]

    R = T(1:3,1:3);
    p = T(1:3,4);

    % - Caso próximo de identidade (rotação ~ zero): translação pura -
    if norm(R - eye(3), 'fro') < 1e-10
        % Não há rotação, só deslocamento; escolhemos S translacional 
        % unitário
        dp = norm(p);
        if dp < 1e-12
            % T ~ identidade total
            omega = [0;0;0];
            v     = [0;0;0];
            theta = 0;
        else
            omega = [0;0;0];
            v     = p / dp;   % direção da translação
            theta = dp;       % “ângulo” vira o tamanho da translação
        end

    else
        % - Rotação não-nula: extrai theta e omega -
        % Evita erros numéricos no acos (trace pode sair levemente 
        % fora de [-1,1]).
        tr = max(-1,min(1, (trace(R) - 1)/2 ));
        theta = acos(tr);

        % Se theta ~ pi, sin(theta) ~ 0 -> forma padrão instabiliza.
        if abs(sin(theta)) < 1e-8
            % Extração robusta de omega quando theta ~ pi:
            % Usa (R + I) para obter um autovetor associado a 1 
            % (eixo de rotação).
            A = (R + eye(3))/2;
            [~,idx] = max(diag(A));
            w = A(:,idx);
            omega = w / norm(w + (norm(w)<1e-12)); % normaliza com proteção
            % Constrói matriz chapeu para omega
            omega_hat = [  0       -omega(3)  omega(2);
                        omega(3)     0       -omega(1);
                       -omega(2)  omega(1)     0     ];
        else
            % Forma estável quando sin(theta) “ok”
            omega_hat = (R - R') / (2*sin(theta));
            omega = [omega_hat(3,2); omega_hat(1,3); omega_hat(2,1)];
        end

        % -v a partir de p: usa a inversa do Jacobiano à esquerda de SO(3)-
        % V^{-1}(theta) = 
        % I/theta - 0.5*[omega]x + (1/theta - 0.5*cot(theta/2))*[omega]x^2
        % tal que: v = V^{-1} * p
        if theta < 1e-8
            % fallback (nunca deve cair aqui por causa do ramo anterior, 
            % mas por segurança)
            Vinv = eye(3)/theta - 0.5*omega_hat;
        else
            Vinv = (eye(3)/theta) - 0.5*omega_hat + ...
                   ( (1/theta) - 0.5*cot(theta/2) ) * (omega_hat^2);
        end
        v = Vinv * p;
    end

    % Twist final: S = [omega; v]
    S = [omega; v];
end
