function y = fmin_fun(par, newFeature ,x )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%[Be,BeA] = activeRuleNew(ratt, x0(i,:));

ratt = x2ratt(x, par);


fname = {'D55','D56','D65','D68','D76','D78','D95','D94','D1','D46','D47','D49'};
vname = {'Contrast','Correlation','Energy'};

anss = zeros(1,16);
% for ttt = 1:16
ttt = 16;%%%%%%%%%%%%%%%%%%%%ÿ��ͼƬȡǰ���ٸ����� 

yd = 0;
for i = 1:length(fname)
    for k = 1:ttt
        for j = 1:length(vname)
            xin(j) = newFeature.(fname{i}).(vname{j})(k);
        end
        [B, BA] = activeRuleNew_3(ratt, xin);
        
        B(i) = 1 - B(i);
        yd = yd + sum(B);
    end
end

y = yd;

end

