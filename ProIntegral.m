function y = ProIntegral(a,b,alpha)

if a > b
    y =((a-b+1)^(-alpha+1) - (a+1)^(-alpha+1))/(alpha-1);
else
    y = (1 - (a+1)^(-alpha+1))/(alpha-1) + (b-a);
end