function twist = calc_rot2twist(R) % Calcula o twist (vetor 3x1) a partir de uma rotação 3x3
    theta = acos((trace(R) - 1)/2);
    if abs(theta) < 1e-6
        twist = [0; 0; 0];
    else
        lnR = (theta/(2*sin(theta))) * (R - R');
        twist = [lnR(3,2); lnR(1,3); lnR(2,1)];
    end
end