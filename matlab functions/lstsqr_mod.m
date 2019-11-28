function s = lstsqr_mod(Z,Y)
%H_x is the hypothesis where each row H_x(i,:) = x_i;
%Y is the true labels, where each row Y(i,:) = y_i;
diff = min(mod(Z-Y,2*pi),mod(Y-Z,2*pi));
score = vecnorm(diff,2,2).^2;
s = mean(score);
end