function f = cost(th2,l2,X1)

Xi = X1; Xj = GetArm(th2,l2);
D = pdist2(Xi,Xj);
W = 0.1*ones(size(D));
W(end,end) = 3;
f = sum(sum(W.*D));
  