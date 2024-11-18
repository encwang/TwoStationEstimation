Arecord(2) = Arecord(2)+1;
N_ev = N_ev + 1;
ev_list(N_ev,:) = [t - log(rand)/lambda2, 2];
w1tmp = max(w1 - (t-told), 0);
w2tmp = max(w2 - (t-told), 0);
w1 = w1tmp;
w2 = w2tmp;
%%%%%%%%%%%%%%%
if w2tmp <= (w1tmp+c)
    ind = 2;
    tmp = w2tmp;
else
    ind = 1;
    tmp = w1tmp+c;
end
if rand < ProbJoin(theta, tmp)
    WorkLoad = [WorkLoad; w1tmp w2tmp];
    JoiningInd = [JoiningInd ind];
    if ind == 1
        Switchtimes = Switchtimes +1;
        % w1 = w1 + wblrnd(alpha,3);
        % w1 = w1tmp + gprnd(1/alpha,C/alpha,0);
        w1 = - log(rand)/alpha;
        Jrecord(1) = Jrecord(1) + 1;
    else
        w2 = - log(rand)/beta;
        % w2 = w2tmp + gprnd(1/beta,C/beta,0);
        % w2 = w2 + wblrnd(beta,3);
        Jrecord(2) = Jrecord(2) + 1;
    end
    ATimes = [ATimes t];
    WorkLoadPlus = [WorkLoadPlus; w1 w2];
end
%%%%%%%%%%%%%%%