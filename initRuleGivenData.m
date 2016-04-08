function [ ratt, par ] =  initRuleGivenData( )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

preN = 3;%ǰ�����Ը���
preNE = [8 5 5];%ÿ��ǰ�����Ժ�ѡֵ����
rNum = prod(preNE);%������
BNum = 12;%�ȼ���������

prAwFlag = false;%ǰ������Ȩ���Ƿ����ѵ��
prAFlag = true;%ǰ�����Ժ�ѡֵ�Ƿ����ѵ��
uFlag = false;%����ֵ�Ƿ����ѵ��

gB = zeros(rNum, BNum) ;%ÿ�������beta�������ǹ����ţ������СΪrNum * BNum
gwR = zeros(1, rNum);%����Ȩ�أ������СΪ1*rNum
gu = zeros(1, BNum);%����ֵ�������СΪ1*BNum
gPraW = zeros(1, preN);%ǰ������Ȩ�أ������СΪ1*preN
gPraA = cell(1,preN);%ǰ�����Ժ�ѡֵ����ϸ������ÿ��Ԫ�洢��ѡֵ���飬�����СΪ1*preN


%%%�Զ�����%%%���õ�����ÿ������С��0.5��û���������ĸо�
% gB = rand(rNum,BNum);
% for i = 1:rNum
%     gB(i,:) = gB(i,:)/sum(gB(i,:));
% end
% gB = [1 0 0
%     0.5 0.5 0
%     0 1 0
%     0 0.5 0.5
%     0 0 1
%     ];
gB = ones(rNum,BNum);
gB(:) = gB(:)./BNum;

gwR = ones(1,rNum);

gu = [-0.5 0 0.5 0.2 0.3 0.4 0.5 0.5 0.5 0.5 0.5 0.5];
%gu = ones(1,BNum);

gPraW = [1 1 1];

gPraA = {[0 0.85 1.2 1.7 4.5 6 8 10],[0.5 0.7 0.85 0.95 1],[0.01 0.03 0.06 0.1 0.35]};

if (size(gB,1) ~= rNum || size(gB,2) ~= BNum)
    error('���ŶȾ���gB����');
end

if size(gwR, 2) ~= rNum;
    error('����Ȩ��gwR����');
end

if size(gu, 2) ~= BNum;
    error('����gu����');
end

if size(gPraW, 2) ~= preN;
    error('ǰ������Ȩ��gPraW����');
end

for i = 1:preN
    if (size(gPraA{i},2) ~= preNE(i))
        error('ǰ�����Ժ�ѡֵgPreN����');
    end
end

ratt.u = gu;
prA(preN).a = [];
prA(preN).w = 0;
for i = 1:preN
    prA(i).a = gPraA{i};
    prA(i).w = gPraW(i);
end

rule(rNum).wR = 0;
rule(rNum).B = [];
for i = 1:rNum
    rule(i).B = gB(i,:);
    rule(i).wR = gwR(i);
end

ratt.prA = prA;
ratt.rule = rule;

par.preNE = preNE;
par.BNum = BNum;
par.prA = prA;
par.prAFlag = prAFlag;
par.uFlag = uFlag;
par.prAwFlag= prAwFlag;
par.u = gu;

