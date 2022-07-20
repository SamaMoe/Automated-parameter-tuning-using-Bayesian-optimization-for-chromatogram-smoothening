%%Load data
A = readmatrix("C:\Users\emery\OneDrive - KU Leuven\Chromatograms\chromatograms smoothening paper\ISO10_mixed_noisy\MIX_ISO10_F160.CSV");
x = A(:,1)';
y = A(:,2)';

B = readmatrix("C:\Users\emery\OneDrive - KU Leuven\Chromatograms\chromatograms smoothening paper\ISO10_mixed_noisy\MIX_ISO10_F10.CSV");
x_10 = B(:,1)';
y_10= B(:,2)';
y_10 = interp1(x_10,y_10,x,'spline');

%% Grid search
tic
lambdas = logspace(-2,5,20);
degrees = [1 2 3];
for i = 1:length(lambdas)
    for j = 1:length(degrees)
        error(i,j) = minfun(y,lambdas(i),degrees(j));
    end 
end
[M1,I] = min(error);
[M2,CI] = min(M1);
z = TVRM2fun(y,lambdas(I(CI)),degrees(CI));
toc
figure 
plot(x,y,'b',x,z,'r')

rmse_Grid = rmse(y_10,z);
figure 
plot(x,y,':k',x,y_10,'-.b',x,z,'r')

%% Bayesian optimization
tic
lambda = optimizableVariable('lambda', [0.01 100000], 'Transform','log');
d = optimizableVariable('d', [1 3],'Type','integer');
vars = [lambda,d]; 

fun = @(x)objfun(x,y);

results = bayesopt(fun,vars,"AcquisitionFunctionName","expected-improvement-plus","IsObjectiveDeterministic",true,"MaxObjectiveEvaluations",25,"NumSeedPoints",6,'UseParallel',true, 'GPActiveSetSize',300,'Verbose',0,'PlotFcn',[]);
para = bestPoint(results);

% fitting with optimal parameters 
z = TVRM2fun(y,para.lambda,para.d);
toc
figure 
plot(x,y,'b',x,z,'r')
%title('final fitting')
xlabel('time [min]')
ylabel('Absorbance')
%legend(["noisy chromatogram","optimal fitting"])

rmse_BO = rmse(y_10,z);
figure 
plot(x,y,':k',x,y_10,'-.b',x,z,'r')

