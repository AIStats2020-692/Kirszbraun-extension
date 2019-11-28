function [thx,thy] = GenerateData(N,lx,ly,DOF_agent1,DOF_agent2)
 
%{ 
%-----------------------------------
% example 
%----------------------------------- 
% expert
  N1 = 3; % DOFs
  th1 = [pi/3,pi/12,pi/4]; %pi/5,pi/12,pi/4,pi/12]; % joint angle
  l1 = [0.3,0.4,0.7]; %,0.6,0.2,0.3,0.2]; % link lengths
% learner
  N2 = 2; % DOFs
  th2 = [pi/4,pi/3];%,pi/12,pi/5]; % joint angle
  l2 = [0.8,0.5];%,0.7,0.7]; % link lengths
% get arm = joint locations
  X1 = GetArm(th1,l1);
  X2 = GetArm(th2,l2);
% plot arm 
  figure
  color1 = [0 0.6 0];
  color2 = [0 0 0.6];
  PlotArm(X1,color1)
  hold on;
  PlotArm(X2,color2)
  axis equal
  clf
%}


%--------------------------------------- 
% generate training data
%---------------------------------------  
dim = 2;
thx = zeros(N,DOF_agent1);
thy = zeros(N,DOF_agent2);
for n = 1:N
th_exp = -pi/2 + 2*pi/2*rand(DOF_agent1,1); % joint angles (random)
thx(n,:) = th_exp; 
% get arm
X0 = GetArm(th_exp,lx); % We geneate the arm Euclid representation, because the real correspondence problem is based on that representation
%learner: generate similar configuration with respect to some 'cost'
% initial guess 
th_learn = rand(DOF_agent2,1);
options = optimoptions(@fminunc,'Display','Off');
th_learn = fminunc('cost',th_learn,options,ly,X0);
thy(n,:) = th_learn;

% plot configuration of expert and learner
%figure
%color1 = [0 0.6 0];
%color2 = [0 0 0.6];
%PlotArm(X1,color1)
%hold on;
%PlotArm(X2,color2) 
%axis equal
%clf
%pause
%close al  
end
end
  
