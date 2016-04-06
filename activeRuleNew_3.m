function [ B, BA ] = activeRuleNew_3( ratt, indata )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

prA = ratt.prA;
rule = ratt.rule;
BNum = size(rule(1).B, 2);
%%%%%%%%%%此处候选值个数要手动修改随initRuleGivenData%%%%%%%%%
preN2 = size(prA(3).a,2);
preN1 = size(prA(2).a,2) * preN2;


l1 = find(prA(1).a<=indata(1), 1, 'last');
e1 = find(prA(1).a>=indata(1), 1, 'first');

l2 = find(prA(2).a<=indata(2), 1, 'last');
e2 = find(prA(2).a>=indata(2), 1, 'first');

l3 = find(prA(3).a<=indata(3), 1, 'last');
e3 = find(prA(3).a>=indata(3), 1, 'first');

mDegree = zeros(3,2);
mDegree(1,1) = ((prA(1).a(e1) - indata(1)) / (prA(1).a(e1) - prA(1).a(l1)));
mDegree(1,2) = 1 - mDegree(1,1);
mDegree(2,1) = ((prA(2).a(e2) - indata(2)) / (prA(2).a(e2) - prA(2).a(l2)));
mDegree(2,2) = 1 - mDegree(2,1);
mDegree(3,1) = ((prA(3).a(e3) - indata(3)) / (prA(3).a(e3) - prA(3).a(l3)));
mDegree(3,2) = 1 - mDegree(3,1);

mDegree(1,1) = mDegree(1,1)^prA(1).w;
mDegree(1,2) = mDegree(1,2)^prA(1).w;
mDegree(2,1) = mDegree(2,1)^prA(2).w;
mDegree(2,2) = mDegree(2,2)^prA(2).w;
mDegree(3,1) = mDegree(3,1)^prA(3).w;
mDegree(3,2) = mDegree(3,2)^prA(3).w;

r1 = (l1 - 1) * preN1 + (l2 - 1) * preN2 + l3;
r2 = (l1 - 1) * preN1 + (l2 - 1) * preN2 + e3;
r3 = (l1 - 1) * preN1 + (e2 - 1) * preN2 + l3;
r4 = (l1 - 1) * preN1 + (e2 - 1) * preN2 + e3;
r5 = (e1 - 1) * preN1 + (l2 - 1) * preN2 + l3;
r6 = (e1 - 1) * preN1 + (l2 - 1) * preN2 + e3;
r7 = (e1 - 1) * preN1 + (e2 - 1) * preN2 + l3;
r8 = (e1 - 1) * preN1 + (e2 - 1) * preN2 + e3;


actrule(1,1) = r1;
actrule(1,2) = rule(r1).wR * mDegree(1,1) * mDegree(2,1) * mDegree(3,1);
actrule(2,1) = r2;
actrule(2,2) = rule(r2).wR * mDegree(1,1) * mDegree(2,1) * mDegree(3,2);
actrule(3,1) = r3;
actrule(3,2) = rule(r3).wR * mDegree(1,1) * mDegree(2,2) * mDegree(3,1);
actrule(4,1) = r4;
actrule(4,2) = rule(r4).wR * mDegree(1,1) * mDegree(2,2) * mDegree(3,2);
actrule(5,1) = r5;
actrule(5,2) = rule(r5).wR * mDegree(1,2) * mDegree(2,1) * mDegree(3,1);
actrule(6,1) = r6;
actrule(6,2) = rule(r6).wR * mDegree(1,2) * mDegree(2,1) * mDegree(3,2);
actrule(7,1) = r7;
actrule(7,2) = rule(r7).wR * mDegree(1,2) * mDegree(2,2) * mDegree(3,1);
actrule(8,1) = r8;
actrule(8,2) = rule(r8).wR * mDegree(1,2) * mDegree(2,2) * mDegree(3,2);

acrN = 8;


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

