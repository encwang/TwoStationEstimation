throughputRecord1 = [];
throughputRecord2 = [];
for lambda1 = 0:0.01:2
    lambda2 = 2-lambda1;
    alpha = 1; beta = 1;
    Simulation
    throughputRecord1 =[throughputRecord1 1000/t];
    alpha = 2; beta = 0;
    Simulation
    throughputRecord2 =[throughputRecord2 1000/t];
end

plot(0:0.01:2, throughputRecord1)
hold on
plot(0:0.01:2, throughputRecord2)
legend('$G_1(x) = 1-e^{-x}, G_2(x) = 1-e^{-x}$','$G_1(x) = 1-e^{-2x}$, no server at station 2','Interpreter','latex','FontSize',20)
xlabel('$\lambda_1$','Interpreter','latex','FontSize',26)
ylabel('Simulated throughput','FontSize',26)