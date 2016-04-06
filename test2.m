clear
% load('14图0度仅共生5特征.mat')
% fname = {'D1','D46','D47','D49','D101','D102'};
% vname = {'Contrast','Correlation','Energy','Entropy','Homogeneity'};
% 
% anss = zeros(1,16);
% % for ttt = 1:16
% ttt = 16;%%%%%%%%%%%%%%%%%%%%每张图片取前多少个出来 
% xin = zeros(6*ttt,5);
% xN = 0;
% for i = 1:length(fname)
%     for k = 1:ttt
%         xN = xN + 1;
%         for j = 1:length(vname)
%             xin(xN,j) = newFeature.(fname{i}).(vname{j})(k);
%         end
%     end
% end

% load hald
% ing = xin;
% [coeef, score, latent, tsquare] = princomp(ing);
% per = cumsum(latent)./sum(latent);

% (xin(1,:) - mean(xin))*coeef;
% 
%  for i = 1:5
%      kk(i).a = i;
%      kk(i).b = i;
%  end
%  
%  kk(1).a = 2;
%  kk(3).a = 4;

% save('c:\1.mat','xin');

xn = 0;
for i=1:2
    for j = 1:2
        for k= 1:2
            xn = xn + 1;
            xin(xn,:) = [i j k];
        end
    end
end

