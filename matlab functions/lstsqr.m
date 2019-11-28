function s = lstsqr(Z,Y)
%Z is the hypothesis where each row Z(i,:) = x_i;
%Y is the true labels, where each row Y(i,:) = y_i;
score = vecnorm(Z-Y,2,2).^2;
s = mean(score);
end