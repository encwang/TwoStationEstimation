function y = LogLikelihood(x, WorkLoad, WorkLoadPlus, JoiningInd, ATimesInt)
lambda = x(1:2);
theta = x(3);
c = x(4);

K = 500; % number of effective arrivals
y = 0;
for k = 1:K
    wStart = WorkLoadPlus(k,:);
    w = WorkLoad(k,:);
    t = ATimesInt(k);
    if abs(wStart(1) - wStart(2)) < c
        JoinRate = lambda(JoiningInd(k))*ProbJoin(theta, w(JoiningInd(k)));
        IntProb = (-lambda(1)*ProIntegral(wStart(1),t,theta) - lambda(2)*ProIntegral(wStart(2),t,theta));
    else
        % check whether the joined server is with higher cost
        [useless,ind] = min(w); 
        indTheOther = 3-ind;
        if ind == JoiningInd(k)
            if abs(w(1) - w(2)) < c
                JoinRate = lambda(ind);
                % JoinRate = lambda(ind)*ProbJoin(theta, w(ind));
                tc = wStart(indTheOther)-c; % find the when it becomes smaller than c
                IntProb = (-lambda(ind)*ProIntegral(wStart(ind),t,theta) ...
                    - lambda(indTheOther)*ProIntegral(wStart(ind)+c,wStart(ind),theta) ...
                    - lambda(indTheOther)*ProbJoin(theta, c)*(tc-wStart(ind))...
                    - lambda(indTheOther)*ProIntegral(c,t-tc,theta));
            elseif t < wStart(ind)
                JoinRate = lambda(ind)*ProbJoin(theta, w(ind)) + lambda(indTheOther)*ProbJoin(theta, w(ind)+c);
                IntProb = (-lambda(ind)*ProIntegral(wStart(ind),t,theta) ...
                    - lambda(indTheOther)*ProIntegral(wStart(ind)+c,t,theta));
            else
                JoinRate = lambda(ind)*ProbJoin(theta, w(ind)) + lambda(indTheOther)*ProbJoin(theta, w(ind)+c);
                IntProb = (-lambda(ind)*ProIntegral(wStart(ind),t,theta) ...
                    - lambda(indTheOther)*ProIntegral(wStart(ind)+c,wStart(ind),theta)) ...
                    - lambda(indTheOther)*ProbJoin(theta, c)*(t-wStart(ind));
            end
        else
            if abs(w(1) - w(2)) < c
                JoinRate = lambda(indTheOther)*ProbJoin(theta, w(indTheOther));
                tc = wStart(indTheOther)-c; % find the when it becomes smaller than c
                IntProb = (-lambda(indTheOther)*ProIntegral(wStart(ind)+c,wStart(ind),theta) ...
                    - lambda(indTheOther)*ProbJoin(theta, c)*(tc-wStart(ind)) ...
                    - lambda(indTheOther)*ProIntegral(c,t-tc,theta) ...
                    - lambda(ind)*ProIntegral(wStart(ind),t,theta));
            else
                JoinRate = 0;
            end
        end
    end
    if JoinRate == 0
        ytmp = -1000;
    else
        ytmp = log(JoinRate)+IntProb;
    end
    y = y + ytmp;
end