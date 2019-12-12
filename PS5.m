clear,clc
close all

%%% Q1
rawdata = readtable('card.csv');
data=table2array(rawdata);

lwage=data(:,33);
educ = data(:,4);
exp = data(:,32);
SMSA=data(:,23);
race=data(:,22);
region=data(:,24);

X = [ones(length(Y),1),educ,exp,SMSA,race,region];
Y = lwage;
OLS = fitlm(X,Y,'variablenames',{'lwage','educ','exp','SMSA','race','region'});
b = OLS.Coefficients(:,1);
stdb = OLS.Coefficients(:2);
residual = OLS.Residuals);
sdresidual = std(residual);

%%% Q2
iter = 1000;
accept=[0,0];
p = 0.001;
S = p*[[bsxfun(@times,betavar,eye(K)) zeros(K,1)];[zeros(1,K) (OLS.RMSE^2)]];
Para = [b,OLS.RMSE];
Y = data.lwage;


for i  = 1:iter                        
    [P,a] = MHstepOLS(Para,S,X,Y); 
    accept = accept + [a 1];          
end


ParaM=zeros(10000,7);
accept0=[0 0];


for i=1:100000
     [P,a] = MHstepOLS(Para,S,X,Y);
        accept0 = accept0 + [a 1];
         ParaM(i,:) = P';
end


histogram(ParaM(:,1),'Normalization','probability');
title("Constant");
histogram(ParaM(:,2),'Normalization','probability');
title("educ");
histogram(ParaM(:,3),'Normalization','probability');
title("race");
histogram(ParaM(:,4),'Normalization','probability');
title("SMSA");
histogram(ParaM(:,5),'Normalization','probability');
title("region");
histogram(ParaM(:,6),'Normalization','probability');
title("experience");
histogram(ParaM(:,7),'Normalization','probability');
title("rmse");