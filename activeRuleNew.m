function [ B, BA ] = activeRuleNew( ratt, indata )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
clear global;
global maRes;
global maI;
global tmpM;

prA = ratt.prA;
rule = ratt.rule;
BNum = size(rule(1).B, 2);
preN = size(prA, 2);
preNE(preN) = 0;


if size(indata,2)~=preN
    error('激活规则输入值与前提属性个数匹配')
end

for i = 1:preN
    preNE(i) = size(prA(i).a, 2);
end

% if size(indata,2)~=preN
%     error('error');
% end
indm(preN).alpha = [];
indm(preN).index = [];
for i = 1:preN
    if(isempty(find(prA(i).a == indata(i),1)))
        indm(i).index = [find(prA(i).a<indata(i), 1, 'last') find(prA(i).a>indata(i), 1, 'first')];
        indm(i).alpha = zeros(1,preNE(i));
        tmpAl = prA(i).a(indm(i).index);
        indm(i).alpha(indm(i).index(1)) = (tmpAl(2) - indata(i)) / (tmpAl(2)-tmpAl(1));
        indm(i).alpha(indm(i).index(2)) = (indata(i) - tmpAl(1)) / (tmpAl(2)-tmpAl(1));
    else
        indm(i).index = find(prA(i).a == indata(i),1);
        indm(i).alpha = zeros(1,preNE(i));
        indm(i).alpha(indm(i).index) = 1;
    end
end
tmpM = indm;
maRes(2^preN, preN) = 0;
maI = 0;
pp(preN) = 0;
conquer(1, preN, pp);
mulpre = ones(1,preN);
mai = maI;%激活了mai条规则
res = maRes;%%%每行存储激活的前提属性位置
actrule(mai, 2) = 0;%第一列存激活规则的编号，第二列存激活权重wk

for i = preN-1:-1:1
    mulpre(i) = mulpre(i+1) * preNE(i+1);
end

for i = 1:mai
    tmpe = 1;
    tmpk = 0;
    for j = 1:preN
        al = indm(j).alpha(res(i,j));
        al = al^prA(j).w;
        tmpe = tmpe * al;
        tmpk = tmpk + (res(i,j)-1) * mulpre(j);
    end
    tmpk = tmpk + 1;
    wk = rule(tmpk).wR * tmpe;
    actrule(i,:) = [tmpk, wk];
end
tmpActRuleWSum = sum (actrule(:,2));
if tmpActRuleWSum ~= 0
    actrule(:,2) = actrule(:,2)/tmpActRuleWSum;
end
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

% if abs(cw) > 0.001 
%     disp(cw);
% end

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

function [] = conquer(t, preN, p)
global tmpM;
global maI;
global maRes;
if t>preN
    maI = maI + 1;
    maRes(maI, :) = p;
    return ;
end
dim = size(tmpM(t).index, 2);
for i = 1:dim
    p(t) = tmpM(t).index(i);
    conquer(t+1, preN, p);
end
end
