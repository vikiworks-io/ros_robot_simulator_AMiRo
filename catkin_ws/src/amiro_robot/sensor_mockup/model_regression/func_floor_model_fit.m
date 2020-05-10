function [fitresult, gof] = func_floor_model_fit(x, y, valuesUnique, y_sigma)
%CREATEFITS(X,Y,VALUESUNIQUE,Y_SIGMA)
%  Create fits.
%
%  Data for 'spline' fit:
%      X Input : x
%      Y Output: y
%  Data for 'atan' fit:
%      X Input : x
%      Y Output: y
%  Data for 'std tanh' fit:
%      X Input : valuesUnique
%      Y Output: y_sigma
%  Data for 'std spline' fit:
%      X Input : valuesUnique
%      Y Output: y_sigma
%  Output:
%      fitresult : a cell-array of fit objects representing the fits.
%      gof : structure array with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 29-Jul-2017 22:00:16

%% Initialization.

% Initialize arrays to store fits and goodness-of-fit.
fitresult = cell( 4, 1 );
gof = struct( 'sse', cell( 4, 1 ), ...
    'rsquare', [], 'dfe', [], 'adjrsquare', [], 'rmse', [] );

%% Fit: 'spline'.
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 3.61651972190313e-07;

% Fit model to data.
[fitresult{1}, gof(1)] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'spline' );
h = plot( fitresult{1}, xData, yData );
legend( h, 'y vs. x', 'spline', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
grid on

%% Fit: 'atan'.
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'a*atan(b*x+d)+c', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.35140797108346 0.921591044836866 0.0981414184126863 0.959291425205444];

% Fit model to data.
[fitresult{2}, gof(2)] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'atan' );
h = plot( fitresult{2}, xData, yData );
legend( h, 'y vs. x', 'atan', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
grid on

%% Fit: 'std tanh'.
[xData, yData] = prepareCurveData( valuesUnique, y_sigma );

% Set up fittype and options.
ft = fittype( 'a*tanh(b*x+d)+c', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.482752028232992 0.82667029805762 0.649189825616455 0.181847028302852];

% Fit model to data.
[fitresult{3}, gof(3)] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'std tanh' );
h = plot( fitresult{3}, xData, yData );
legend( h, 'y_sigma vs. valuesUnique', 'std tanh', 'Location', 'NorthEast' );
% Label axes
xlabel valuesUnique
ylabel y_sigma
grid on

%% Fit: 'std spline'.
[xData, yData] = prepareCurveData( valuesUnique, y_sigma );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 1.61388378650095e-05;

% Fit model to data.
[fitresult{4}, gof(4)] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'std spline' );
h = plot( fitresult{4}, xData, yData );
legend( h, 'y_sigma vs. valuesUnique', 'std spline', 'Location', 'NorthEast' );
% Label axes
xlabel valuesUnique
ylabel y_sigma
grid on

