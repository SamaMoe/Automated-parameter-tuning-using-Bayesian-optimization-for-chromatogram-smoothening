function [z] = vCurveBayOpt(y)
%computes signal smoothening using V-Curves and Bayesian optimization
% Define paramters
lambda= optimizableVariable('lambda', [0.001 10000000000], 'Transform','log');
d = optimizableVariable('d', [1 3],'Type','integer');
vars = [lambda,d];
fun = @(x)VcurveEvaluation3(y,x);
% Bayesian optimization
results = bayesopt(fun,vars,"AcquisitionFunctionName","expected-improvement-plus","IsObjectiveDeterministic",true,"MaxObjectiveEvaluations",75,"NumSeedPoints",10,'UseParallel',true, 'GPActiveSetSize',300,"Verbose",0,"PlotFcn",[]);
para = bestPoint(results);

% fitting with optimal parameters 
z = TVRM2fun(y,para.lambda,para.d);
end