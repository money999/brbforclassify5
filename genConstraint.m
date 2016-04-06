function [ A, b, Aeq, beq, lb, ub ] = genConstraint( ratt, x, par )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
prA = ratt.prA;
rule = ratt.rule;
preN = size(prA, 2);
preNE = par.preNE;

xNum = size(x, 2);
rNum = size(rule, 2);
BNum = par.BNum;

Aeq = zeros(rNum, xNum);
beq = ones(rNum, 1);
%%%%%置信度为1的等式约束%%%%%
%%%正取的
for i = 0:rNum-1
    Aeq(i+1, BNum * i + 1 : BNum * i + BNum) = ones(1, BNum);
end
% for i = 0:rNum-1
%     Aeq(i+1,  1:BNum) = ones(1, BNum);
% end

%%%%%不等式约束%%%%%
ite = rNum * BNum + rNum;%去掉B、wR
%%%1、期望值约束
uA = [];
ub = [];
if (par.uFlag && BNum > 3)
    tBNum = BNum - 3;
    uA = zeros(tBNum, xNum); %uA(tBNum, xNum) = 0;%%这个没有预先分配？
    for i = 1:tBNum
        uA(i, ite + i:ite + i + 1) = [1 -1];
    end
    ite = ite + BNum - 2;
    ub = zeros(tBNum, 1); %uA * X < ub
end
%%%2、候选值约束
if par.prAwFlag %%不训练w就不用跳过
    ite = ite + preN; %%跳过中间的prA.w
end

pA = [];
pb = [];
%  tt = preNE - 3;
%  tt(tt<0) = 0;
%  pb = zeros(sum(tt),1);
if par.prAFlag
    for i = 1:preN
        if preNE(i) > 3
            nowNE = preNE(i) - 3;
            for j = 1:nowNE
                tmpS = zeros(1, xNum);
                tmpS(ite + j : ite + j + 1) = [1 -1];
                pA = [pA; tmpS];
                pb = [pb; 0];
            end
            ite = ite + nowNE + 1;
        end
    end
end

A = [uA; pA];
b = [ub; pb];

%%%最大最小值约束
%改变 u 和 前提候选值首尾值

lb = zeros(1, xNum);
ub = ones(1, xNum);

ite = rNum * BNum + rNum;
if (par.uFlag && BNum > 2)
    lb(ite + 1 : ite + BNum - 2) = ratt.u(1);
    ub(ite + 1 : ite + BNum - 2) = ratt.u(BNum);
    ite = ite + BNum - 2;
end

if par.prAFlag
    if par.prAwFlag
        ite = ite + preN;
    end
    for i = 1:preN
        tt = preNE(i);
        if tt > 2
            lb(ite + 1 : ite + tt - 2) = prA(i).a(1);
            ub(ite + 1 : ite + tt - 2) = prA(i).a(tt);
        end
        ite = ite + tt - 2;
    end
end
%再改变每条规则权重大于0（没有等）
wAS = rNum * BNum + 1;%权重在x0中的起点
wAE = rNum * BNum + rNum;%权重在x0中的终点
lb(wAS:wAE) = 1e-8;

end

