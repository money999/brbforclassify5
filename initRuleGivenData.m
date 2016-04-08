function [ ratt, par ] =  initRuleGivenData( )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

preN = 3;%前提属性个数
preNE = [8 5 5];%每个前提属性候选值个数
rNum = prod(preNE);%规则数
BNum = 12;%等级评价数量

prAwFlag = false;%前提属性权重是否参与训练
prAFlag = true;%前提属性候选值是否参与训练
uFlag = false;%期望值是否参与训练

gB = zeros(rNum, BNum) ;%每条规则的beta，行数是规则编号，矩阵大小为rNum * BNum
gwR = zeros(1, rNum);%规则权重，矩阵大小为1*rNum
gu = zeros(1, BNum);%期望值，矩阵大小为1*BNum
gPraW = zeros(1, preN);%前提属性权重，矩阵大小为1*preN
gPraA = cell(1,preN);%前提属性候选值采用细胞矩阵，每个元存储候选值数组，矩阵大小为1*preN


%%%自动生成%%%不好的在于每个数都小于0.5，没有随机分配的感觉
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
    error('置信度矩阵gB出错');
end

if size(gwR, 2) ~= rNum;
    error('规则权重gwR出错');
end

if size(gu, 2) ~= BNum;
    error('期望gu出错');
end

if size(gPraW, 2) ~= preN;
    error('前提属性权重gPraW出错');
end

for i = 1:preN
    if (size(gPraA{i},2) ~= preNE(i))
        error('前提属性候选值gPreN出错');
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

