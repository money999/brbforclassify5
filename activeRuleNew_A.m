function [ B, BA ] = activeRuleNew_A( ratt, indata )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

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
mDegree = zeros(preN, 2);%每次都是激活两条，若匹配度为1，则位置写一样还是保存两个,
                         % 其中一个匹配度用0来代替，这样算规则权重会变0,0就不加入合成
mDegAdd = zeros(preN, 2);%用来记激活属性的位置与degree一一对应

for i = 1:preN
     l = find(prA(i).a<=indata(i), 1, 'last');
     e = find(prA(i).a>=indata(i), 1, 'first');
    
     if isempty(l)||isempty(e)
        error('匹配越界')
     end
     
     if l == e
     mDegree(i,1) = 1;
     mDegree(i,2) = 0;
     mDegAdd(i,1) = e;
     mDegAdd(i,2) = l;
     else
     mDegree(i,1) = (prA(i).a(e) - indata(i)) / (prA(i).a(e) - prA(i).a(l));
     mDegree(i,2) = (indata(i) - prA(i).a(l)) / (prA(i).a(e) - prA(i).a(l));
     mDegAdd(i,1) = l;
     mDegAdd(i,2) = e;
     
     mDegree(i,1) = mDegree(i,1)^prA(i).w;%%%这里直接先搞上前提属性权重，
     mDegree(i,2) = mDegree(i,2)^prA(i).w;%%%前提属性权重没训练，默认就1
     end
end

mulpre = ones(1,preN);
for i = preN-1:-1:1
    mulpre(i) = mulpre(i+1) * preNE(i+1);
end
%现在先用SB方法preN有几个就写几重for
%%%%%%%%%%%%%%%%此处要手动修改%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rIndex = 0;
rValue = 1;

actrule = zeros(2^preN, 2);%第一列存激活规则的编号，第二列存激活权重wk
acrN = 0;
%wk是还没有除以分母的，分母要全求出再计算
for i = 1:2
    rIndex = rIndex + (mDegAdd(1,i) - 1) * mulpre(1);
    rValue = rValue * mDegree(1,i);
    
    %%%%%%%%%%%%放在最里层的for%%%%%%%%%%%%%%%
    if rValue ~= 0
        acrN = acrN + 1;
        actrule(acrN,1) = rIndex;
        actrule(acrN,2) = rValue * rule(rIndex).wR;
    end
    %%%%%%%%%%%%放在最里层的for%%%%%%%%%%%%%%
    
end

%%%%%%%%%%%%%%%%此处要手动修改%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

