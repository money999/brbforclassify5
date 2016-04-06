% clear global

% clear 
 load('14图0度仅共生5特征.mat');
% [ ratt, par] = initRuleGivenData();
% x0 = ratt2x(ratt, par);
% [A,b,Aeq,beq,lb,ub] = genConstraint(ratt, x0, par);
% x0 = x0';
% lb = lb';
% ub = ub';
% 
% options = optimset( 'Display' , 'Iter' , 'MaxFunEvals'...
%     , 10000*length(x0) , 'MaxIter', 10000 , 'TolFun' , 1e-10 , 'TolX' , 1e-6 , 'TolCon', 1e-6);
% [x,fval,flag] = fmincon(@(x) fmin_fun(par, newFeature, x ) ...
%     ,x0, A, b, Aeq, beq, lb, ub,[],options);
% rattNew = x2ratt(x, par);

% % yesss = fmin_fun(par,newFeature,x);

disp('dddd');

fname = {'D55','D56','D65','D68','D76','D78','D95','D94'};
vname = {'Contrast','Correlation'};

% for ttt = 1:16
ttt = 16;%%%%%%%%%%%%%%%%%%%%每张图片取前多少个出来 

yd = 0;

restt = zeros(1,length(fname));
for i = 1:length(fname)
    for k = 1:ttt
        for j = 1:length(vname)
            xin(j) = newFeature.(fname{i}).(vname{j})(k);
        end
        [B, BA] = activeRuleNew_2(rattNew, xin);
        
        [v,l] = max(B);
        if l~=i
            restt(i) = restt(i) + 1;
        end
    end
end


% yp = zeros(1,16);
% for yi = 1:16
%     at = 0;
%     pNum = yi * 5;
%     for yj = 1:30
%         [sp, sv, sc, p1, v1, c1, p2, v2, c2] = gen_match_source(pNum, 5, 2*pi, 0.5, 0.8);
%         pdis = pdist2(p1, p2);
%         vdis = pdist2(v1, v2);
%         c1tm1 = normpdf(c1, -1,2)./(normpdf(c1, -1,2) + normpdf(c1, 1,2));%注意点除根据文章所给公式计算bpa
%         c1tm2 = 1-c1tm1;
%         c2tm1 = normpdf(c2, -1,2)./(normpdf(c2, -1,2) + normpdf(c2, 1,2));
%         c2tm2 = 1-c2tm1;
%         cdis = c1tm1*c2tm2' + c1tm2*c2tm1';
%         
%         m1 = zeros(pNum, pNum);
%         m0 = zeros(pNum, pNum);
%         mA = zeros(pNum, pNum);
%         for i = 1:pNum
%             for j = 1:pNum
%                 xin = [pdis(i,j) vdis(i,j) cdis(i,j)];
%                 [Be,BeA] = activeRuleNew(rattNew, xin);
%                 m0(i,j) = Be(1);
%                 m1(i,j) = Be(2);
%                 mA(i,j) = BeA;
%             end
%         end
%         result = goalBRB( m1, m0, mA );
%          dim = size(result,1) * 0.8;
%          result = result((1:dim),(1:dim));
%         at = at + size(result,1) - sum(diag(result));
%     end
%     yp(yi) = at / 30 / (pNum * 0.8);
%     yp(yi) = 1 - yp(yi);
% end

% plot(5:5:80, yp, 'k');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pma = 0;
% vma = 0;
% cma = 0;
% %for ki = 1:5000
% [sp, sv, sc, p1, v1, c1, p2, v2, c2] = gen_match_source(500, 5, 2*pi, 0.5, 1);
% pdis = pdist2(p1, p2);
% vdis = pdist2(v1, v2);
% c1tm1 = normpdf(c1, -1,2)./(normpdf(c1, -1,2) + normpdf(c1, 1,2));%注意点除根据文章所给公式计算bpa
% c1tm2 = 1-c1tm1;
% c2tm1 = normpdf(c2, -1,2)./(normpdf(c2, -1,2) + normpdf(c2, 1,2));
% c2tm2 = 1-c2tm1;
% cdis = c1tm1*c2tm2' + c1tm2*c2tm1';
% 
% plot(1:500, pdis(1,:), '.');
% vvv = pdis(1,:);
% vvv(vvv<1)
% max(diag(vdis))
% max(max(vdis))
% % tpma = max(max(pdis));
% % tvma = max(max(vdis));
% % tcma = max(max(cdis));
% % if tpma > pma
% %     pma = tpma;
% % end
% % if tvma > vma
% %     vma = tvma;
% % end
% % if tcma > cma
% %     cma = tcma;
% % end
% %end
% % pma
% % vma
% % cma

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% si = 0:0.01:2*pi;
% v = 0:0.01:0.5;
% x = cos(si)' * v;
% y = sin(si)' * v;
% plot(x, y, '.');

% si1 = rand() * 2 * pi;
% v1 = rand() * 0.5;
% x1 = cos(si1) * v1;
% y1 = sin(si1) * v1;
% si2 = rand() * 2 * pi;
% v2 = rand() * 0.5;
% x2 = cos(si2) * v2;
% y2 = sin(si2) * v2;
% pdist2([x1 y1], [x2 y2])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% [ ratt, par] = match_orig_initRuleGivenData();
% x0 = ratt2x(ratt, par);
% [A,b,Aeq,beq,lb,ub] = genConstraint(ratt, x0, par);
% x0 = x0';
% lb = lb';
% ub = ub';
% pNum = 100;
% [sp, sv, sc, p1, v1, c1, p2, v2, c2] = gen_match_source(pNum, 5, 2*pi, 0.5, 1);
% 
% pdis = pdist2(p1, p2);
% vdis = pdist2(v1, v2);
% c1tm1 = normpdf(c1, -1,2)./(normpdf(c1, -1,2) + normpdf(c1, 1,2));%注意点除根据文章所给公式计算bpa
% c1tm2 = 1-c1tm1;
% c2tm1 = normpdf(c2, -1,2)./(normpdf(c2, -1,2) + normpdf(c2, 1,2));
% c2tm2 = 1-c2tm1;
% cdis = c1tm1*c2tm2' + c1tm2*c2tm1';
% 
% options = optimset('Algorithm', 'active-set', 'Display' , 'Iter' , 'MaxFunEvals'...
%     , 20000*length(x0) , 'MaxIter', 10000 , 'TolFun' , 1e-6 , 'TolX' , 1e-6 , 'TolCon', 1e-6);
% [x,fval,flag] = fmincon(@(x) match_fmin_fun(par, pdis, vdis, cdis, x ) ...
%     ,x0, A, b, [], [], lb, ub,[],options);
% rattNew = x2ratt(x, par);
% 
% disp('dddd');
% 
% yp = zeros(1,16);
% for yi = 1:16
%     at = 0;
%     pNum = yi * 5;
%     for yj = 1:15
%         [sp, sv, sc, p1, v1, c1, p2, v2, c2] = gen_match_source(pNum, 5, 2*pi, 0.5, 1);
%         pdis = pdist2(p1, p2);
%         vdis = pdist2(v1, v2);
%         c1tm1 = normpdf(c1, -1,2)./(normpdf(c1, -1,2) + normpdf(c1, 1,2));%注意点除根据文章所给公式计算bpa
%         c1tm2 = 1-c1tm1;
%         c2tm1 = normpdf(c2, -1,2)./(normpdf(c2, -1,2) + normpdf(c2, 1,2));
%         c2tm2 = 1-c2tm1;
%         cdis = c1tm1*c2tm2' + c1tm2*c2tm1';
%         
%         m1 = zeros(pNum, pNum);
%         m0 = zeros(pNum, pNum);
%         mA = zeros(pNum, pNum);
%         for i = 1:pNum
%             for j = 1:pNum
%                 xin = [pdis(i,j) vdis(i,j) cdis(i,j)];
%                 [Be,BeA] = activeRuleNew(rattNew, xin);
%                 m0(i,j) = Be(1);
%                 m1(i,j) = Be(2);
%                 mA(i,j) = BeA;
%             end
%         end
%         result = goalBRB( m1, m0, mA );
%         % dim = size(result,1) * 0.8;
%         % result = result((1:dim),(1:dim));
%         at = at + size(result,1) - sum(diag(result));
%     end
%     yp(yi) = at / 15 / (pNum * 1);
%     yp(yi) = 1 - yp(yi);
% end
% 
% plot(5:5:80, yp);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [ ratt, par] = oil_orig_initRuleGivenData();
% x0 = ratt2x(ratt, par);
% [A,b,Aeq,beq,lb,ub] = genConstraint(ratt, x0, par);
% x0 = x0';
% lb = lb';
% ub = ub';
%  
% options = optimset('Algorithm', 'active-set', 'Display' , 'Iter' , 'MaxFunEvals'...
%     , 20000*length(x0) , 'MaxIter', 10000 , 'TolFun' , 1e-6 , 'TolX' , 1e-6 , 'TolCon', 1e-6);
% 
% [x,fval,flag] = fmincon(@(x) oil_fmin_fun(par, x ) ...
%     ,x0, A, b, Aeq, beq, lb, ub,[],options);
% disp(flag);
% rattNew = x2ratt(x, par);
% 
% 
% 
% data = load('TrainData2008.mat');
% x0 = data.TrainData2008(:,1:2);
% yNew = zeros(1,2007);
% 
% for i = 1:2007
% [Be,BeA] = activeRuleNew(rattNew, x0(i,:));
% yNew(i) = sum(Be .* [ratt.u]);
% %disp(i);
% end
% plot(1:2007, yNew);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% [ ratt, par] = Curve_whj_orig_initRuleGivenData();
% x0 = ratt2x(ratt, par);
% [A,b,Aeq,beq,lb,ub] = genConstraint(ratt, x0, par);
% x0 = x0';
% lb = lb';
% ub = ub';
%  
% options = optimset('Algorithm', 'active-set', 'Display' , 'Iter' , 'MaxFunEvals' , 20000*length(x0) ...
%     , 'MaxIter', 10000 , 'TolFun' , 1e-6 , 'TolX' , 1e-6 , 'TolCon', 1e-6);
% 
% [x,fval,flag] = fmincon(@(x) curve_fmin_fun(par, x ) ...
%     ,x0, A, b, Aeq, beq, lb, ub,[],options);
% disp(flag);
% rattNew = x2ratt(x, par);
% 
% xc = -5:0.0125:5;
% yc(size(xc,2)) = 0;
% for i = 1:size(xc,2)
%     [Be,BeA] = activeRuleNew(rattNew, xc(i));
%      yc(i) = sum(Be .* [rattNew.u]);
% end
% plot(xc,yc,'.r');
% 
%  xc = -5:0.0125:5;
%  yc = exp(-(xc-2).^2) + 0.5*exp(-(xc+2).^2);
%  hold on
%  plot(xc,yc,'.g');

 