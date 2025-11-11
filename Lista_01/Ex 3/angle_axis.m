function [eixo, ang] = angle_axis(R) % Converte matriz de rotação em eixo e ângulo
    ang = acos((trace(R) - 1)/2);
    if abs(ang) < 1e-6
        eixo = [0; 0; 0];
    else
        eixo = (1/(2*sin(ang))) * [R(3,2)-R(2,3); R(1,3)-R(3,1); R(2,1)-R(1,2)];
    end
end