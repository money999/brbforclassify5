function [ B, BA ] = activeRuleNew_1( ratt, indata )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

prA = ratt.prA;
rule = ratt.rule;
BNum = size(rule(1).B, 2);


l = find(prA.a<=indata, 1, 'last');
e = find(prA.a>=indata, 1, 'first');


if l == e
    actrule(1,1) = l;
    actrule(1,2) = rule(l).wR;
    acrN = 1;
else
    actrule(1,1) = l;
    actrule(1,2) = rule(l).wR * ((prA.a(e) - indata) / (prA.a(e) - prA.a(l)));
    actrule(2,1) = e;
    actrule(2,2) = rule(e).wR * ((indata - prA.a(l)) / (prA.a(e) - prA.a(l)));
    acrN = 2;
end


tmpActRuleWSum = sum (actrule(:,2));
if tmpActRuleWSum ~= 0
    actrule(:,2) = actrule(:,2)/tmpActRuleWSum;
end

[B, BA] = erCombine(actrule, acrN, rule, BNum);


end



function [B, BA] = erCombine(actrule, acrN, rule, BNum)

mai = acrN;%%%%actrule有多少条

m = zeros(mai, BNum);
mw = zeros(mai, 1);
mu = zeros(mai, 1);

for i = 1:mai
    
    m(i,:) = actrule(i,2) .* rule(actrule(i,1)).B;
    mw(i,:) = actrule(i,2) .* ( 1 - sum(rule(actrule(i,1)).B) );
    mu(i,:) = 1 - actrule(i,2);
end
c = zeros(1, BNum);
cu = prod(mu);
cw = prod(mu + mw) - cu;


for i = 1:BNum
    c(i) = prod(m(:,i) + mu + mw) - (cu + cw);
end

k1 = sum(c) + cu + cw;
c = c ./ k1;
cw = cw /k1;
cu = cu / k1;

B = c ./ ( 1 - cu );
BA = cw / ( 1 - cu );

if isnan(sum(B))
    disp(6969);
end

end

