% Generate more data

% generate more data based on previous data (consistent with former arms length)
%----------------
clear all
profile on

N1 = 10000; % number of data samples generated used only ones
DOF_agent1 = 5; %DoF
DOF_agent2 = 3; % DoF


lx = xlsread('data\lx.xlsx');
ly = xlsread('data\ly.xlsx');%"Start Generating Data"
tic
[thx_tr,thy_tr] = GenerateData(N1,lx,ly,DOF_agent1,DOF_agent2); % training set
toc
"Finished training Set"
[thx_val,thy_val] = GenerateData(N1,lx,ly,DOF_agent1,DOF_agent2); % validation set
"Finished val Set"
[thx_test,thy_test] = GenerateData(N1,lx,ly,DOF_agent1,DOF_agent2); % test set
"Finished test Set"

thy_tr=mod(thy_tr,2*pi);
thy_val=mod(thy_val,2*pi);
thy_test = mod(thy_test,2*pi);

xlswrite('data_new\X_train.xlsx',thx_tr)
xlswrite('data_new\X_val.xlsx',thx_val)
xlswrite('data_new\X_test.xlsx',thx_test)
xlswrite('data_new\Y_train.xlsx',thy_tr)
xlswrite('data_new\Y_val.xlsx',thy_val)
xlswrite('data_new\Y_test.xlsx',thy_test)
xlswrite('data_new\lx.xlsx',lx)
xlswrite('data_new\ly.xlsx',ly)
%}
