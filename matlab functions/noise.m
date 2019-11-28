function nse = noise(N,d)
%NOISE creates noise to samples
%   gets the Y true correspondence and add noise to each joint
%   the first links will have noise of N(0,0.1)
%   the last link wiil have noise of N(0,0.2) 
nse = zeros(N,d);
nse(:,1:d-1) = randn(N,d-1)*0.5;
nse(:,d) = randn(N,1)*0.5;


