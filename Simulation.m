% clear;
% clc;
% parameters
lambda1 = 1;
lambda2 = 5;
lambda = [lambda1 lambda2];
alpha = 2; beta = 6; C = 1; 
theta = 3;
c = 0.5;


t = 0; % the current time 
w1 = 0; w1tmp = 0;% the workload at effective joining times
w2 = 0; w2tmp = 0;
Switchtimes = 0;

WorkLoad = []; % the workload at effective joining times
WorkLoadPlus = [];
ATimes = []; % the intervals before effective joins
Arecord = [0,0]; % record the number of arriving customers
Jrecord = [0,0]; % record the number of effective joining customers
JoiningInd = [];
ev_list = inf*ones(3,2) ; 
%%%%%%%%%%%%%%%%%%%%%%%%%%5
ev_list(1,:) = [- log(rand)/lambda1, 1]; 
ev_list(2,:) = [- log(rand)/lambda2, 2];
N_ev = 2 ; 
while sum(Jrecord) < 1000
    % ev_list
    ev_list = sortrows(ev_list ,1);
    told = t;
    t = ev_list(1,1);
    ev_type = ev_list(1,2);
    switch ev_type
        case 1
            arrival1
        case 2  
            arrival2
    end
    ev_list(1,:) = [inf,inf];
    N_ev = N_ev - 1;
    ev_list = sortrows(ev_list ,1);
end
ATimesInt = [ATimes(1) ATimes(2:end)-ATimes(1:end-1)];
WorkLoadPlus = [0,0;WorkLoadPlus];
% 500/(lambda1+lambda2)/t
