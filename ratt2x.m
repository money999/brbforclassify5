function [ x ] = ratt2x( ratt, par)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
%   x依次放每条规则的B，wR， 再放期望值，前提属性权重， 前提属性权重候选值


prA = ratt.prA;
rule = ratt.rule;
preN = size(prA, 2);
BNum = par.BNum;

if (par.uFlag && BNum > 2)%%%u的首位也不参与训练
    x = [[rule.B] [rule.wR] ratt.u(2:BNum-1)];
else
    x = [[rule.B] [rule.wR]];
end

if par.prAwFlag
    x = [x [prA.w]];
end

if par.prAFlag
    tmpx = [];
    for i = 1:preN
        iprAN = size(prA(i).a, 2);
        if iprAN > 2
             tmpx = [tmpx prA(i).a(2:iprAN-1)];
        end
    end
    x = [x tmpx];
end
end

