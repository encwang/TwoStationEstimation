Diff12 = WorkLoad(:,1) - WorkLoad(:,2);
[a, inda] = find(Diff12' > 0);
[b, indb] = find(JoiningInd==1);
c1 = max(Diff12(intersect(inda,indb)))

[a, inda] = find(Diff12' < 0);
[b, indb] = find(JoiningInd==2);
c2 = -min(Diff12(intersect(inda,indb)))

max(c1,c2)