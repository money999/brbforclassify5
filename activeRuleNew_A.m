function [ B, BA ] = activeRuleNew_A( ratt, indata )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

prA = ratt.prA;
rule = ratt.rule;
BNum = size(rule(1).B, 2);
preN = size(prA, 2);
preNE(preN) = 0;


if size(indata,2)~=preN
    error('�����������ֵ��ǰ�����Ը���ƥ��')
end

for i = 1:preN
    preNE(i) = size(prA(i).a, 2);
end

% if size(indata,2)~=preN
%     error('error');
% end
mDegree = zeros(preN, 2);%ÿ�ζ��Ǽ�����������ƥ���Ϊ1����λ��дһ�����Ǳ�������,
                         % ����һ��ƥ�����0�����棬���������Ȩ�ػ��0,0�Ͳ�����ϳ�
mDegAdd = zeros(preN, 2);%�����Ǽ������Ե�λ����degreeһһ��Ӧ

for i = 1:preN
     l = find(prA(i).a<=indata(i), 1, 'last');
     e = find(prA(i).a>=indata(i), 1, 'first');
    
     if isempty(l)||isempty(e)
        error('ƥ��Խ��')
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
     
     mDegree(i,1) = mDegree(i,1)^prA(i).w;%%%����ֱ���ȸ���ǰ������Ȩ�أ�
     mDegree(i,2) = mDegree(i,2)^prA(i).w;%%%ǰ������Ȩ��ûѵ����Ĭ�Ͼ�1
     end
end

mulpre = ones(1,preN);
for i = preN-1:-1:1
    mulpre(i) = mulpre(i+1) * preNE(i+1);
end
%��������SB����preN�м�����д����for
%%%%%%%%%%%%%%%%�˴�Ҫ�ֶ��޸�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rIndex = 0;
rValue = 1;

actrule = zeros(2^preN, 2);%��һ�д漤�����ı�ţ��ڶ��д漤��Ȩ��wk
acrN = 0;
%wk�ǻ�û�г��Է�ĸ�ģ���ĸҪȫ����ټ���
for i = 1:2
    rIndex = rIndex + (mDegAdd(1,i) - 1) * mulpre(1);
    rValue = rValue * mDegree(1,i);
    
    %%%%%%%%%%%%����������for%%%%%%%%%%%%%%%
    if rValue ~= 0
        acrN = acrN + 1;
        actrule(acrN,1) = rIndex;
        actrule(acrN,2) = rValue * rule(rIndex).wR;
    end
    %%%%%%%%%%%%����������for%%%%%%%%%%%%%%
    
end

%%%%%%%%%%%%%%%%�˴�Ҫ�ֶ��޸�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

