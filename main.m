clear;clc;
EstRecord = [];
SwitchRecord = [];
JoiningRecord = [];

for Num = 1:1000
    clearvars -except EstRecord   SwitchRecord  JoiningRecord
    Simulation
    fun = @(x)-LogLikelihood(x, WorkLoad, WorkLoadPlus, JoiningInd, ATimesInt);
    x0 = rand(1,4);
    xEst = fminsearchbnd(fun,x0,[0 0 0 0],[5 5 5 5]);
    EstRecord = [EstRecord; xEst]
    SwitchRecord = [SwitchRecord, Switchtimes/500];
    JoiningRecord = [JoiningRecord, 500/(lambda1+lambda2)/t];
end

%Plots for
% lambda1 = 1;
% lambda2 = 3;
% lambda = [lambda1 lambda2];
% alpha = 2; beta = 4; C = 1; theta = 3;
% c = 0.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RecordNew = rmoutliers(EstRecord);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nbins = 10;
figure
% h = histogram(RecordNew(:,1),nbins,'Normalization','pdf','FaceColor','r','FaceAlpha', 0.3);
h = histogram(RecordNew(:,1),nbins,'Normalization','pdf','FaceColor','r','FaceAlpha', 0.3);
hold on
X = 0.6:0.01:1.4;
plot(X,normpdf(X, mean(RecordNew(:,1)), std(RecordNew(:,1))),"Color",'black','LineStyle','-','LineWidth', 3)
legend('$\hat{\lambda}_1$','Interpreter','latex','FontSize',26)
figure
h = histogram(RecordNew(:,2),nbins,'Normalization','pdf','FaceColor','b','FaceAlpha', 0.3);
hold on
X = 4.8:0.01:5.2;
% X = 0.6:0.01:1.4;
plot(X,normpdf(X, mean(RecordNew(:,2)), std(RecordNew(:,2))),"Color",'black','LineStyle','-','LineWidth', 3)
legend('$\hat{\lambda}_2$','Interpreter','latex','FontSize',26)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
h = histogram(RecordNew(:,3),nbins,'Normalization','pdf','FaceColor','y');
hold on
X = 2:0.01:4;
plot(X,normpdf(X, mean(RecordNew(:,3)), std(RecordNew(:,3))),"Color",'black','LineStyle','-','LineWidth', 3)
legend('$\hat{\theta}$','Interpreter','latex','FontSize',26)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
h = histogram(RecordNew(:,4),nbins,'Normalization','pdf','FaceColor','b');
hold on
X = 0.44:0.001:0.55;
plot(X,normpdf(X, mean(RecordNew(:,4)), std(RecordNew(:,4))),"Color",'black','LineStyle','-','LineWidth', 3)
legend('$\hat{c}$','Interpreter','latex','FontSize',26)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mean(RecordNew)
std(RecordNew)
mean(SwitchRecord)
mean(JoiningRecord)
    