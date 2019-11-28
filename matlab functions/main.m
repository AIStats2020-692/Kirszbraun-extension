
%% Generate data
%----------------
clear all
profile on

N1 = 10000; % number of data samples generated used only ones
N = 100; % number of training data.
DOF_agent1 = 5; %DoF
RangeX = "A1:E" + N; % this is for reading the data from xls matrix
DOF_agent2 = 3; % DoF
RangeY = "A1:C" + N;

%{
lx = 0.1 + 0.6*rand(DOF_agent1,1); % link lengths (random)
ly = 0.1 + 0.6*rand(DOF_agent2,1); % link lengths (random)
ly = ly/sum(ly)*sum(lx); % link lengths (random, but same total length of expert)
"Start Generating Data"
[thx_tr,thy_tr] = GenerateData(N1,lx,ly,DOF_agent1,DOF_agent2); % training set
"Finished training Set"
[thx_val,thy_val] = GenerateData(N1,lx,ly,DOF_agent1,DOF_agent2); % validation set
"Finished val Set"
[thx_test,thy_test] = GenerateData(N1,lx,ly,DOF_agent1,DOF_agent2); % test set
"Finished test Set"

xlswrite('data2\X_train.xlsx',thx_tr)
xlswrite('data2\X_val.xlsx',thx_val)
xlswrite('data2\X_test.xlsx',thx_test)
xlswrite('data2\Y_train.xlsx',thy_tr)
xlswrite('data2\Y_val.xlsx',thy_val)
xlswrite('data2\Y_test.xlsx',thy_test)
xlswrite('data2\lx.xlsx',lx)
xlswrite('data2\ly.xlsx',ly)

%}
dir = 'data_new';
X_train=xlsread([dir '\X_train.xlsx'],RangeX);
X_val=xlsread([dir '\X_val.xlsx'],RangeX);
X_test=xlsread([dir '\X_test.xlsx'],RangeX);
Y_train=xlsread([dir '\Y_train.xlsx'],RangeY) + noise(N,DOF_agent2);
Y_val=xlsread([dir '\Y_val.xlsx'],RangeY);
Y_test=xlsread([dir '\Y_test.xlsx'],RangeY);
lx = xlsread([dir '\lx.xlsx']);
ly = xlsread([dir '\ly.xlsx']);

%Y_train=mod(Y_train,2*pi);
%Y_val=mod(Y_val,2*pi);
%Y_test = mod(Y_test,2*pi);
%{
%% training and validating (choosing L)
L = linspace(1,400,5) ;
si = 0; % index for keeping the score
%best_kirsz_l = 0; % 
best_l = 190;
score = zeros(1,20);
%best_score_kirsz = 1000;
best_score = Inf;
eps = 1;
N_val = min(100,N);

tic 

for l=60 %L
    
%    TODO : return that part after fmincon optimiztion problem fixed   
    si = si+1;
    tic
    "Training " + l
    %Z_train = reshape(train(X_train,Y_train,l),[],N)'; 
    Z_train = Y_train;%Smoothing(X_train,Y_train,l);
    [~,a] = Graph(Z_train);
    [~,b] = Graph(X_train);
    tmp = a./b;
    max(tmp,[],'all')
    
    Z_val_mw = zeros(N,DOF_agent2); % for now size of train val and test sets is equal
    
    tic
    for i = 1:N_val % extdending each point in val set
        x = X_val(i,:);
        Z_val_mw(i,:) = extensionMW(x,X_train,Z_train,eps,l)';
    end
    
    s = lstsqr(Z_val_mw,Y_val);
    score(si) = s;
    if s < best_score
        best_score = s;
        best_l = l;
        Z_train_final = Z_train;
    end
    "Finished "+ l +" in " + toc + " sec"
end

Z = xlsread('data2\Z_train.xlsx',RangeY);
%% test
%---------------
"Test time"
tic
N_tst = min(N,50);
Y_test = Y_test(1:N_tst,:);
Z_test = Y_test;
for i = 1:N_tst % extdending each point in val set
    x = X_test(i,:);
    Z_test(i,:) = extensionMW(x,X_train,Z,eps,best_l);
end
toc

N_tst = min(N,50);
Z_test = xlsread('data2\Z_test_mw.xlsx',RangeY);
Z_svm = SVMfit(X_train,Y_train,X_test(1:N_tst,:));

final_score_mw = lstsqr(Z_test,Y_test(1:N_tst,:)) %resutls
%final_score_mem = lstsqr(Z(1:N_tst,:),Y_test(1:N_tst,:)) % comparison
final_score_svm = lstsqr(Z_svm,Y_test(1:N_tst,:)) %comparison2

%% Ploting
%----------------------------------- 
%}
Z_train=xlsread('Z_train.xlsx');
Z_test=xlsread('Z_test_mw.xlsx');
Z_svm=xlsread( 'Z_test_SVR.xlsx');

for i = 1:5 %randi(100,1,10)
% get arm = joint locations
 expert = GetArm(X_test(i,:),lx);
 correspondence = GetArm(Y_test(i,:),ly);
 learner_mw = GetArm(Z_test(i,:),ly);
 svm = GetArm(Z_svm(i,:),ly);

% plot arm 
  figure
  Black = [0 0 0]; % expert, black
  Green = [0 0.6 0]; %true correspondence, Green
  Blue = [0 0 0.6]; %mw_learner, Blue
  Red = [0.6 0 0];  %SVM , Red
  PlotArm(expert,Black)
  hold on;
  PlotArm(correspondence,Green)
  hold on;
  PlotArm(learner_mw,Blue)
  hold on;
  PlotArm(svm,Red)
  hold on;
  axis equal;
end
%close all
%profsave
profile off
%}

POS_Z = vectorize(Z_test,ly);
POS_SVR = vectorize(Z_svm,ly);
POS_y = vectorize(Y_test,ly);
xlswrite('data_new\test\pos_Z_mw.xlsx',POS_Z);
xlswrite('data_new\test\pos_Z_svr.xlsx',POS_SVR);
xlswrite('data_new\test\pos_Y_test.xlsx',POS_y);
score_mw = lstsqr(POS_Z,POS_y)
score_svr = lstsqr(POS_SVR,POS_y)