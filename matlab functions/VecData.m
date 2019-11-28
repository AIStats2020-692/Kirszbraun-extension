function [vec_x,vec_y] = VecData(X,Y,N1,N2)
% each configuration of the robot is represented as k X N1 \ d X N2 matrix 
% Where N1 and N2 are the agents DoF, k and d is the dimension of space ( in this program k=d=2)  
% This function chages the configuration to a k*N1 \ d*N2 vectors

% If you don't understand why the data is cleaned the way we did, check the data before vectorizing
% GenerateData also has comment lines when uncommented plot the configurations

%%%%%%%  setting sizes
N = size(X,1)/(N1+1);
k = size(X,2)-1;
d = size(Y,2)-1;
%%%%%%%

% vectorizing X
indx = 1:N*(N1+1); % number of rows in dataset
indx = mod(indx-1,N1+1) > 0;
X = X(indx,1:k); % filtering seperating rows

tmp_vec = reshape(X',[1,N*N1*k]);
vec_x = reshape(tmp_vec,[N1*k,N])';

% vectorizing Y
indx = 1:N*(N2+1); % number of rows in dataset
indx = mod(indx-1,N2+1) > 0;
Y = Y(indx,1:d); % filtering seperating rows

tmp_vec = reshape(Y',[1,N*N2*d]);
vec_y = reshape(tmp_vec,[N2*d,N])';
