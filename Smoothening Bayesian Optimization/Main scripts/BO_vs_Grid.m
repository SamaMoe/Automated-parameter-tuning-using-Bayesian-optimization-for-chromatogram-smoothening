% Load simulated data
A = readmatrix("C:\Users\emery\OneDrive - KU Leuven\Python scripts\chroms_noisy.CSV");
% initialize parameters 
lambda = optimizableVariable('lambda', [0.001 10000000000], 'Transform','log');
d = optimizableVariable('d', [1 3],'Type','integer');
vars = [lambda,d]; 

lambdas = logspace(-3,10,40);
degrees = [1 2 3];
% initialize storing matrices 
denoised_BO_LOOCV = ones([100 8192]);
denoised_BO_curves = ones([100 8192]);
denoised_Grid = ones([100 8192]);

for i = 1:10
    y = A(i,:);
    x = 1:1:length(y);
%Bayesian optimization LOOCV
    fun = @(x)objfun(x,y);

    results = bayesopt(fun,vars,"AcquisitionFunctionName","expected-improvement-plus","IsObjectiveDeterministic",true,"MaxObjectiveEvaluations",40,"NumSeedPoints",6,'UseParallel',true, 'GPActiveSetSize',300,'Verbose',0, 'PlotFcn',[]);
    para = bestPoint(results);
    z = TVRM2fun(y,para.lambda,para.d);
    denoised_BO_LOOCV(i,:) = z;
%Bayesian optimization curves
    fun = @(x)VcurveEvaluation3(y,x);

    results = bayesopt(fun,vars,"AcquisitionFunctionName","expected-improvement-plus","IsObjectiveDeterministic",true,"MaxObjectiveEvaluations",40,"NumSeedPoints",6,'UseParallel',true, 'GPActiveSetSize',300,'Verbose',0, 'PlotFcn',[]);
    para = bestPoint(results);
    z = TVRM2fun(y,para.lambda,para.d);
    denoised_BO_curves(i,:) = z;
% Grid
    error = zeros([length(lambdas) length(degrees)]);
    for k = 1:length(lambdas)
        for j = 1:length(degrees)
            error(k,j) = minfun(y,lambdas(k),degrees(j));
        end 
    end
    [M1,I] = min(error);
    [M2,CI] = min(M1);
    z = TVRM2fun(y,lambdas(I(CI)),degrees(CI));
    denoised_Grid(i,:) = z;
end

writematrix(denoised_BO_LOOCV,'desnoised_BO_LOOCV.csv') 
writematrix(denoised_BO_curves,'denoised_BO_curvesd.csv') 
writematrix(denoised_Grid,'denoised_Grid.csv') 

%% Load perfect data
B = readmatrix("C:\Users\emery\OneDrive - KU Leuven\Python scripts\chroms.CSV");
denoised_BO_LOOCV = readmatrix("desnoised_BO_LOOCV.csv");
denoised_BO_curves = readmatrix("desnoised_BO_curves.csv");
denoised_Grid = readmatrix("denoised_Grid.csv");
%% root mean square error
sum_BO_LOOCV = 0;
sum_BO_curves = 0;
sum_Grid = 0;
errors_BO_LOOCV = zeros([1 100]);
errors_BO_curves = zeros([1 100]);
errors_Grid = zeros([1 100]);
for i = 1:10
    y = B(i,:);
    err_BO_LOOCV = rmse(y,denoised_BO_LOOCV(i,:));
    errors_BO_LOOCV(i) = err_BO_LOOCV;
    sum_BO_LOOCV = sum_BO_LOOCV + err_BO_LOOCV; 
    err_BO_curves = rmse(y,denoised_BO_curves(i,:));
    errors_BO_curves(i) = err_BO_curves;
    sum_BO_curves = sum_BO_curves + err_BO_curves;
    err_Grid = rmse(y,denoised_Grid(i,:));
    errors_Grid(i) = err_Grid;
    sum_Grid = sum_Grid + err_Grid;
end
mErr_BO_LOOCV = sum_BO_LOOCV/100;
mErr_BO_curves = sum_BO_curves/100;
mErr_Grid = sum_Grid/100;
%% standard deviation of errors
sd_BO_LOOCV = staDev(errors_BO_LOOCV);
sd_BO_curves = staDev(errors_BO_curves);
sd_Grid = staDev(errors_Grid);





